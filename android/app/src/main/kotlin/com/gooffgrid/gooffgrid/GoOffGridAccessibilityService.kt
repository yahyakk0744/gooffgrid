package com.gooffgrid.gooffgrid

import android.accessibilityservice.AccessibilityService
import android.content.Intent
import android.view.accessibility.AccessibilityEvent

/**
 * GoOffGrid App Blocker — Accessibility Service.
 *
 * Engelli listedeki bir uygulama ön plana geldiğinde
 * kullanıcıyı gooffgrid intervention ekranına yönlendirir.
 *
 * Bu servis sadece WINDOW_STATE_CHANGED eventlerini dinler,
 * kişisel veri toplamaz.
 */
class GoOffGridAccessibilityService : AccessibilityService() {

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        if (event == null) return
        if (!AppBlockService.isEnabled) return
        if (event.eventType != AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED) return

        val pkg = event.packageName?.toString() ?: return

        // Kendimizi ve sistem UI'ını engelleme
        if (pkg == packageName) return
        if (pkg == "com.android.systemui") return
        if (pkg == "com.android.launcher") return
        if (pkg == "com.android.launcher3") return
        if (pkg.startsWith("com.google.android.apps.nexuslauncher")) return

        if (AppBlockService.blockedPackages.contains(pkg)) {
            // Engelli uygulamayı geri gönder, pre-open intervention ekranını aç
            performGlobalAction(GLOBAL_ACTION_BACK)

            // one sec tarzı pre-open akışı: 5 saniye nefes + vazgeç/aç seçimi
            val route = "/pre-open?app=${android.net.Uri.encode(pkg)}&secs=5"

            val intent = Intent(this, MainActivity::class.java).apply {
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_SINGLE_TOP)
                putExtra("route", route)
                putExtra("blockedApp", pkg)
            }
            startActivity(intent)
        }
    }

    override fun onInterrupt() {
        // Required override
    }
}
