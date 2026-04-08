import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/theme.dart';
import '../../l10n/app_localizations.dart';

enum LegalType { privacy, terms, kvkk }

class LegalScreen extends StatelessWidget {
  const LegalScreen({super.key, required this.type});
  final LegalType type;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final title = switch (type) {
      LegalType.privacy => l.privacyPolicy,
      LegalType.terms => l.termsOfService,
      LegalType.kvkk => l.kvkkText,
    };

    final content = switch (type) {
      LegalType.privacy => _privacyPolicy,
      LegalType.terms => _termsOfService,
      LegalType.kvkk => _kvkkText,
    };

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(title, style: AppTextStyles.h2, overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                child: Text(
                  content,
                  style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, height: 1.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const _privacyPolicy = '''
Gizlilik Politikası
Son güncelleme: 3 Nisan 2026

gooffgrid uygulaması ("Uygulama") olarak kişisel verilerinizin korunmasına önem veriyoruz.

1. Toplanan Veriler

• Hesap bilgileri: Ad, e-posta adresi, profil fotoğrafı
• Uygulama kullanım verileri: Ekran süresi istatistikleri, uygulama kullanım süreleri
• Konum verisi: Şehir bazında sıralama için yaklaşık konum (yalnızca izin verildiğinde)
• Sosyal veriler: Arkadaş listesi, düello sonuçları, hikayeler ve yorumlar
• Cihaz bilgileri: İşletim sistemi, uygulama sürümü

2. Verilerin Kullanımı

Topladığımız verileri şu amaçlarla kullanırız:
• Ekran süresi takibi ve istatistik gösterimi
• Şehir ve ülke bazında sıralama oluşturma
• Arkadaşlarla düello ve sosyal etkileşim
• Uygulama deneyimini iyileştirme
• Abonelik ve ödeme işlemleri (Apple/Google üzerinden)

3. Veri Paylaşımı

Kişisel verileriniz üçüncü taraflarla paylaşılmaz. Aşağıdaki istisnalar geçerlidir:
• Supabase: Veri depolama ve kimlik doğrulama
• RevenueCat: Abonelik yönetimi
• Apple/Google: Ödeme işlemleri
• Yasal zorunluluklar: Mahkeme kararı veya yasal talep durumunda

4. Veri Güvenliği

Verileriniz şifreli bağlantılar (TLS/SSL) üzerinden iletilir ve güvenli sunucularda saklanır.

5. Veri Saklama Süresi

Hesabınız aktif olduğu sürece verileriniz saklanır. Hesap silindiğinde tüm kişisel verileriniz 30 gün içinde kalıcı olarak silinir.

6. Haklarınız

• Verilerinize erişim talep edebilirsiniz
• Verilerinizin düzeltilmesini isteyebilirsiniz
• Hesabınızı ve tüm verilerinizi silebilirsiniz
• Veri taşınabilirliği talep edebilirsiniz

7. Çocukların Gizliliği

Uygulamamız 13 yaşın altındaki çocuklara yönelik değildir ve bilerek bu yaş grubundan veri toplamaz.

8. İletişim

Gizlilik ile ilgili sorularınız için: privacy@gooffgrid.com

9. Değişiklikler

Bu politika güncellenebilir. Önemli değişikliklerde uygulama içi bildirim yapılır.
''';

const _termsOfService = '''
Kullanım Şartları
Son güncelleme: 3 Nisan 2026

gooffgrid uygulamasını ("Uygulama") kullanarak aşağıdaki şartları kabul etmiş olursunuz.

1. Hizmet Tanımı

gooffgrid, ekran süresi takibi, dijital detoks ve sosyal rekabet özellikleri sunan bir mobil uygulamadır.

2. Hesap Oluşturma

• Geçerli bir e-posta adresi ile hesap oluşturabilirsiniz
• Google veya Apple hesabınızla giriş yapabilirsiniz
• Hesap bilgilerinizin doğruluğundan siz sorumlusunuz
• Hesabınızın güvenliğini korumak sizin sorumluluğunuzdadır

3. Abonelik ve Ödeme

• Ücretsiz plan temel özellikleri içerir
• Pro ve Pro+ planları aylık veya yıllık abonelik ile kullanılabilir
• Ödemeler Apple App Store veya Google Play Store üzerinden işlenir
• Abonelikler dönem sonunda otomatik yenilenir
• İptal, mevcut dönemin sonuna kadar geçerlidir
• Apple: Ayarlar > Apple Kimliği > Abonelikler'den iptal edilebilir
• Google: Play Store > Abonelikler'den iptal edilebilir

4. Kullanıcı Davranışı

Aşağıdaki davranışlar yasaktır:
• Uygunsuz, hakaret içeren veya yasadışı içerik paylaşmak
• Başka kullanıcıları taciz etmek
• Uygulamanın işleyişini bozmaya çalışmak
• Sahte hesap oluşturmak

5. İçerik

Paylaştığınız hikaye ve yorumlardan siz sorumlusunuz. gooffgrid uygunsuz içeriği kaldırma hakkını saklı tutar.

6. Sorumluluk Sınırlaması

Uygulama "olduğu gibi" sunulmaktadır. Ekran süresi verilerinin doğruluğu cihaz ve işletim sistemi izinlerine bağlıdır.

7. Hesap Silme

Hesabınızı Ayarlar > Hesabımı Sil bölümünden silebilirsiniz. Silme işlemi geri alınamaz.

8. Değişiklikler

Bu şartlar güncellenebilir. Devam eden kullanım, güncellenen şartların kabulü anlamına gelir.

9. İletişim

support@gooffgrid.com
''';

const _kvkkText = '''
KVKK Aydınlatma Metni
Son güncelleme: 3 Nisan 2026

6698 sayılı Kişisel Verilerin Korunması Kanunu ("KVKK") kapsamında aydınlatma yükümlülüğümüzü yerine getirmek amacıyla aşağıdaki bilgileri sunarız.

1. Veri Sorumlusu

gooffgrid uygulaması adına veri sorumlusu olarak hareket edilmektedir.

2. İşlenen Kişisel Veriler

• Kimlik bilgileri: Ad, soyad
• İletişim bilgileri: E-posta adresi
• Konum verileri: Şehir bilgisi (yaklaşık konum)
• Uygulama kullanım verileri: Ekran süresi, uygulama kullanım istatistikleri
• Sosyal etkileşim verileri: Arkadaş listesi, düello sonuçları, hikayeler

3. Veri İşleme Amaçları

• Uygulama hizmetlerinin sunulması
• Kullanıcı deneyiminin iyileştirilmesi
• Şehir ve ülke bazında sıralama
• Abonelik ve ödeme yönetimi

4. Veri İşlemenin Hukuki Sebebi

• Açık rıza (KVKK md. 5/1)
• Sözleşmenin ifası (KVKK md. 5/2-c)
• Meşru menfaat (KVKK md. 5/2-f)

5. Veri Aktarımı

Kişisel verileriniz yurt dışında bulunan hizmet sağlayıcılara (Supabase, RevenueCat) aktarılabilir. Bu aktarım KVKK md. 9 kapsamında açık rızanıza dayanır.

6. Haklarınız (KVKK md. 11)

• Kişisel verilerinizin işlenip işlenmediğini öğrenme
• İşlenmişse bilgi talep etme
• İşlenme amacını ve amacına uygun kullanılıp kullanılmadığını öğrenme
• Yurt içinde/dışında aktarıldığı üçüncü kişileri bilme
• Eksik/yanlış işlenmişse düzeltilmesini isteme
• KVKK md. 7 kapsamında silinmesini/yok edilmesini isteme
• Düzeltme/silme işlemlerinin aktarılan üçüncü kişilere bildirilmesini isteme
• Münhasıran otomatik sistemlerle analiz sonucu aleyhinize bir sonuç çıkmasına itiraz etme
• Kanuna aykırı işleme nedeniyle zararınızın giderilmesini talep etme

7. Başvuru

Haklarınızı kullanmak için: kvkk@gooffgrid.com
''';
