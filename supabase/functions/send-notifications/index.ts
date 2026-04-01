import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

/**
 * Provokatif push notification gönderici.
 * Supabase Cron ile her gün 20:00'de çağrılır.
 * Kullanıcının bugünkü ekran süresine göre mesaj seçer.
 */

const PROVOCATIVE_MESSAGES = {
  // Ekran süresi çok yüksek (>4 saat)
  high: [
    { title: 'Ciddi misin?', body: 'Bugün {minutes} dakika harcadın. Telefon seni mi kullanıyor?' },
    { title: 'Alarm!', body: '{minutes} dakika ekranda. Arkadaşların seni geçiyor.' },
    { title: 'Acı gerçek', body: 'Bugün {minutes} dk. Bu tempoda yılda {yearDays} gün telefona bakıyorsun.' },
    { title: '🔴 Kırmızı alarm', body: 'Günlük hedefini çoktan aştın. Telefonu bırak ve dışarı çık!' },
  ],
  // Orta seviye (2-4 saat)
  medium: [
    { title: 'Fena değil ama...', body: '{minutes} dk. Biraz daha azaltabilirsin.' },
    { title: 'Yarışta geride kalıyorsun', body: 'Arkadaşların bugün senden az kullandı. Sen?' },
    { title: 'Son sprint', body: 'Günün sonuna {remaining} dk kaldı. Hedefin altında bitir!' },
  ],
  // Düşük (hedefin altında) — tebrik
  low: [
    { title: 'Efsane gün!', body: 'Sadece {minutes} dk. Bu tempoda devam et!' },
    { title: '🟢 Hedefin altında', body: 'Bugün {minutes} dk kullandın. Off-grid kralısın!' },
    { title: 'Streak devam!', body: '{streak} gün üst üste hedefin altında. Durma!' },
  ],
}

serve(async (req) => {
  try {
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? '',
    )

    const today = new Date().toISOString().split('T')[0]

    // Aktif cihazları olan kullanıcıları çek
    const { data: devices } = await supabase
      .from('devices')
      .select('user_id, fcm_token, profiles(display_name, daily_goal_minutes, current_streak)')
      .eq('is_active', true)

    if (!devices || devices.length === 0) {
      return new Response(JSON.stringify({ sent: 0 }), { status: 200 })
    }

    // Her kullanıcı için bugünkü screen time'ı çek
    let sent = 0
    const fcmKey = Deno.env.get('FCM_SERVER_KEY') ?? ''

    for (const device of devices) {
      const { data: screenTime } = await supabase
        .from('screen_time_daily')
        .select('total_minutes')
        .eq('user_id', device.user_id)
        .eq('date', today)
        .maybeSingle()

      const minutes = screenTime?.total_minutes ?? 0
      const goal = device.profiles?.daily_goal_minutes ?? 120
      const streak = device.profiles?.current_streak ?? 0

      // Mesaj kategorisi seç
      let category: 'high' | 'medium' | 'low'
      if (minutes > goal * 2) category = 'high'
      else if (minutes > goal) category = 'medium'
      else category = 'low'

      const messages = PROVOCATIVE_MESSAGES[category]
      const template = messages[Math.floor(Math.random() * messages.length)]

      const remaining = Math.max(0, goal - minutes)
      const yearDays = Math.round((minutes / 1440) * 365)

      const title = template.title
      const body = template.body
        .replace('{minutes}', String(minutes))
        .replace('{remaining}', String(remaining))
        .replace('{yearDays}', String(yearDays))
        .replace('{streak}', String(streak))

      // FCM gönder
      if (fcmKey && device.fcm_token) {
        try {
          await fetch('https://fcm.googleapis.com/fcm/send', {
            method: 'POST',
            headers: {
              'Content-Type': 'application/json',
              'Authorization': `key=${fcmKey}`,
            },
            body: JSON.stringify({
              to: device.fcm_token,
              notification: { title, body },
              data: { type: 'daily_provocation', minutes: String(minutes) },
            }),
          })
          sent++
        } catch (e) {
          console.error(`FCM error for ${device.user_id}:`, e)
        }
      }

      // Notification log'a kaydet
      await supabase.from('notification_log').insert({
        user_id: device.user_id,
        title,
        body,
        type: 'daily_provocation',
        data: { minutes, category },
      })
    }

    return new Response(JSON.stringify({ sent }), { status: 200 })
  } catch (err) {
    return new Response(JSON.stringify({ error: err.message }), { status: 500 })
  }
})
