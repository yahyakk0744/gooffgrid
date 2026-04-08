# gooffgrid — Mağaza Yükleme Kılavuzu

**Uygulama:** gooffgrid
**Slogan:** Fişi çek. Oyuna başla. Dijitalde kaybolma.
**Bundle ID (iOS):** `com.gooffgrid.gooffgrid`
**Package Name (Android):** `com.gooffgrid.gooffgrid`
**Versiyon:** 1.0.0+1
**Kategori:** Health & Fitness (iOS) / Sağlık ve Fitness (Play)
**Yaş:** 13+
**Monetizasyon:** Free + Pro/Pro+ IAP (reklam YOK)

---

## 1. Ön Hazırlık (Pre-Submission)

### Hesaplar
- [ ] **Apple Developer Program** — $99/yıl — https://developer.apple.com/programs/enroll/
  - Kayıt 24-48 saat sürebilir, kimlik doğrulaması gerekli
- [ ] **Google Play Console** — $25 tek seferlik — https://play.google.com/console/signup
  - Kayıt genelde 1-2 saat, bazen 2 gün
- [ ] D-U-N-S numarası (şirket hesabı ise Apple için zorunlu)

### Domain & E-posta
- [ ] `gooffgrid.com` domain satın al (Hostinger/Namecheap/GoDaddy)
- [ ] `privacy@gooffgrid.com` e-posta kutusu oluştur
- [ ] `support@gooffgrid.com` e-posta kutusu oluştur
- [ ] DNS MX kayıtları ayarla

### Yasal Sayfalar (Hosting)
- [ ] `privacy-policy.html` → `https://gooffgrid.com/privacy`
- [ ] `terms.html` → `https://gooffgrid.com/terms`
- [ ] `support.html` → `https://gooffgrid.com/support`
- [ ] URL'ler tarayıcıda açılıyor mu kontrol et (mağaza review'ı ilk bunu tıklar)

---

## 2. App Store Connect Hazırlıkları

### App Bilgileri
- [ ] App Store Connect → My Apps → `+` → New App
- [ ] Platform: iOS
- [ ] Name: **gooffgrid**
- [ ] Primary Language: Turkish
- [ ] Bundle ID: `com.gooffgrid.gooffgrid` (Apple Developer > Identifiers'da önce oluştur)
- [ ] SKU: `gooffgrid-ios-001`
- [ ] User Access: Full Access

### Metadata (store/appstore/metadata_tr.txt ve metadata_en.txt)
- [ ] Subtitle (TR): **Dijital Detoks & Ekran Süresi**
- [ ] Subtitle (EN): **Digital Detox & Screen Time**
- [ ] Keywords (TR): `ekran süresi,dijital detoks,telefon bağımlılığı,odak,düello,sosyal,nefes,sıralama,arkadaş,hedef`
- [ ] Keywords (EN): `screen time,digital detox,phone addiction,focus,duel,social,breathing,ranking,friends,goals`
- [ ] Promotional Text (metadata dosyalarından kopyala)
- [ ] Description (metadata dosyalarından kopyala — tam metin)
- [ ] Support URL: `https://gooffgrid.com/support`
- [ ] Marketing URL: `https://gooffgrid.com`
- [ ] Privacy Policy URL: `https://gooffgrid.com/privacy`
- [ ] Kategori: Primary = Health & Fitness, Secondary = Lifestyle

### App Privacy Formu (store/appstore/app_privacy.txt)
Apple "App Privacy" bölümünde şunları işaretle:
- [ ] Data Collected: **YES**
- [ ] **Contact Info** → Name (linked, not tracking), Email (linked, not tracking)
- [ ] **User Content** → Photos (optional, linked, not tracking)
- [ ] **Usage Data** → Product Interaction (linked, not tracking) — ekran süresi verileri
- [ ] **Identifiers** → User ID (linked, not tracking)
- [ ] **Location** → Coarse Location (optional, linked, not tracking)
- [ ] **Diagnostics** → Crash Data, Performance Data (NOT linked, not tracking)
- [ ] Tracking: **NO** (AppTrackingTransparency istemiyoruz)

### Screenshots (MUTLAKA)
- [ ] **6.7" iPhone** (iPhone 15 Pro Max — 1290×2796) — min 3, max 10 adet
- [ ] **6.5" iPhone** (iPhone 11 Pro Max — 1242×2688) — min 3 adet
- [ ] **iPad Pro 12.9"** (2048×2732) — iPad desteği varsa zorunlu
- [ ] Her dil için ayrı ekran (TR + EN)
- [ ] App preview video (opsiyonel ama ASO için güçlü)

### App Review Bilgileri
- [ ] Sign-in required: **YES**
- [ ] Test hesabı: `reviewer@gooffgrid.com` / `Test1234!`
- [ ] Contact Info: Ad, soyad, telefon, e-posta
- [ ] Notes (İngilizce):
  > gooffgrid is a digital detox app. Screen time data is read via iOS FamilyControls / DeviceActivity framework. Location is optional (country-level ranking only). No ad tracking. Test account: reviewer@gooffgrid.com / Test1234!
- [ ] **FamilyControls entitlement** — Apple'dan özel izin iste (Capabilities > Family Controls)
  > Apple bunu ayrıca onaylar, bu adım SÜRENİ UZATIR. Şimdiden talep et.

### IAP (In-App Purchases)
- [ ] App Store Connect → Features → In-App Purchases → `+`
- [ ] **Pro Monthly** — Auto-Renewable Subscription — `gooffgrid_pro_monthly` — ₺X/ay
- [ ] **Pro Yearly** — Auto-Renewable Subscription — `gooffgrid_pro_yearly` — ₺X/yıl
- [ ] **Pro+ Monthly** (varsa) — `gooffgrid_proplus_monthly`
- [ ] **Pro+ Yearly** (varsa) — `gooffgrid_proplus_yearly`
- [ ] Subscription group oluştur, her iki tier'ı aynı gruba koy
- [ ] Her product için localized display name + description (TR + EN)
- [ ] Paid Agreements (Agreements, Tax, and Banking) — banka + vergi bilgileri TAM olmalı, aksi halde IAP aktif olmaz

### RevenueCat
- [ ] https://app.revenuecat.com → Project oluştur
- [ ] iOS app bağla (App Store Connect API Key)
- [ ] App Store Connect'teki ürünleri RevenueCat'e offering olarak tanımla
- [ ] **Gerçek API Key'i** al, `lib/config/revenuecat_config.dart` dosyasına yaz (placeholder'ı değiştir)
- [ ] Sandbox tester hesabı oluştur ve test et

### Pricing & Availability
- [ ] Price: **Free**
- [ ] Availability: All countries (veya sadece TR + belirli ülkeler)

### Age Rating
- [ ] Yaş derecesi anketini doldur → 12+ veya 17+ (sosyal özellik = user-generated content = 12+)

---

## 3. Google Play Console Hazırlıkları

### App Oluşturma
- [ ] Play Console → Create app
- [ ] App name: **gooffgrid**
- [ ] Default language: Turkish (tr-TR)
- [ ] App or game: App
- [ ] Free or paid: Free
- [ ] Developer Program Policies checkbox'ları onayla
- [ ] Package name: `com.gooffgrid.gooffgrid`

### Store Listing (store/playstore/listing_tr.txt ve listing_en.txt)
- [ ] App name: **gooffgrid**
- [ ] Short description (TR): `Ekran süresini takip et, arkadaşlarınla dijital detoks düellosu yap, kazan.`
- [ ] Short description (EN): `Track screen time, duel friends on digital detox, and reclaim your life.`
- [ ] Full description (listing dosyalarından kopyala — emojilerle birlikte)
- [ ] App icon: 512×512 PNG
- [ ] Feature graphic: 1024×500 PNG (ZORUNLU)
- [ ] Phone screenshots: min 2, max 8 (16:9 veya 9:16)
- [ ] 7-inch tablet screenshots (opsiyonel)
- [ ] 10-inch tablet screenshots (opsiyonel)
- [ ] App category: Health & Fitness
- [ ] Contact: Email = `support@gooffgrid.com`, Website = `https://gooffgrid.com`
- [ ] Privacy Policy: `https://gooffgrid.com/privacy`

### Data Safety Formu (store/playstore/data_safety.txt)
- [ ] Data collected: **YES**
- [ ] Data encrypted in transit: **YES**
- [ ] Users can request deletion: **YES** (`https://gooffgrid.com/delete-account`)
- [ ] **Personal info:** Name, Email, User IDs (collected, NOT shared, for App functionality + Account management)
- [ ] **Photos:** Optional, collected, NOT shared
- [ ] **App activity:** App interactions (ekran süresi) — collected, NOT shared
- [ ] **Location:** Approximate location, optional, NOT shared
- [ ] **App info & performance:** Crash logs, Diagnostics — collected, NOT shared
- [ ] Reklam amaçlı paylaşım: **HAYIR**

### Content Rating (IARC anketi)
- [ ] Questionnaire'ı doldur: user-generated content var → 12+ derece beklenir
- [ ] Violence: None, Sexuality: None, Profanity: None, Drugs: None
- [ ] User-generated content: YES (hikayeler), moderasyon var

### Target Audience
- [ ] Target age: **13+** (13 yaş altı verileri toplamıyoruz, Data Safety'de beyan ettik)
- [ ] Appeals to children: NO

### Permissions Declarations
- [ ] **Usage Stats (PACKAGE_USAGE_STATS)** — Android özel izin gerektirir
  > Declaration: "App tracks user's own screen time for digital detox features. User grants Usage Access from system settings. Not used for ads or sold."
- [ ] Foreground service (varsa) declaration

### Closed → Open → Production Akışı
- [ ] **Internal testing** → 20 tester e-posta, anında yayında (test için)
- [ ] **Closed testing** → En az 20 tester × 14 gün aktif test (ZORUNLU, Play'in yeni kuralı)
- [ ] **Open testing** (opsiyonel) → Public link
- [ ] **Production** → Kapalı test 14 gün tamamlanınca aç

---

## 4. Build Komutları

### Android (Windows'ta çalışır)
```bash
cd C:\Users\Mega\Desktop\gooffgrid

# Temizle
flutter clean
flutter pub get

# AAB üret (Play Store için)
flutter build appbundle --release

# Çıktı:
# build\app\outputs\bundle\release\app-release.aab
```

**ÖN KOŞUL:** `android/key.properties` ve keystore dosyası hazır olmalı.

### iOS (Mac gerekli)
```bash
# Mac'te:
cd gooffgrid
flutter clean
flutter pub get
cd ios && pod install && cd ..
flutter build ipa --release

# Çıktı:
# build/ios/ipa/gooffgrid.ipa
```

### Windows'ta iOS Build Alternatifleri
- **Codemagic** (https://codemagic.io) — ücretsiz tier 500 dakika/ay
- **Bitrise** (https://bitrise.io)
- **GitHub Actions** + macOS runner

---

## 5. Yükleme

### Android → Play Console
- [ ] Play Console → Release → Closed testing → Create new release
- [ ] AAB dosyasını yükle: `app-release.aab`
- [ ] Release name: `1.0.0 (1)`
- [ ] Release notes (TR + EN) ekle
- [ ] Review release → Start rollout

### iOS → App Store Connect
**Seçenek A — Mac'ten Xcode Organizer:**
- [ ] Xcode → Window → Organizer → Archives → Distribute App → App Store Connect → Upload

**Seçenek B — Transporter (Mac):**
- [ ] App Store'dan Transporter'ı indir
- [ ] .ipa dosyasını sürükle-bırak → Deliver

**Seçenek C — Codemagic (Windows'tan):**
- [ ] Codemagic workflow'u App Store Connect'e otomatik upload yapacak şekilde ayarla
- [ ] App Store Connect API Key (`.p8`) gerekli

**Upload sonrası:**
- [ ] App Store Connect → TestFlight → Build işlemden geçtikten sonra (5-30 dk) görünür
- [ ] Internal testing grubuna ekle → kendi cihazında test et
- [ ] Her şey tamamsa → App Store tab → Submit for Review

---

## 6. İnceleme Süreci

| Mağaza | Süre | Not |
|--------|------|-----|
| Apple App Store | 24-72 saat (ortalama 48h) | FamilyControls entitlement onayı EK süre |
| Google Play Closed Test | Anında - 2 gün | — |
| Google Play Production | 7 gün (yeni app) | İlk yayında zorunlu bekleme |

---

## 7. Bilinen Riskler / Reddedilme Sebepleri

### Apple
- **FamilyControls / DeviceActivity API** → Özel entitlement gerekli, başvuru formu doldurulmalı. Apple reddedebilir veya açıklama isteyebilir.
- **Screen Time verisi kullanımı** → Sadece kullanıcının kendi verisini göster; başkasının verisini alıp sunucuya yollama.
- **4.2 Minimum Functionality** → App tek bir özelliğe dayanıyorsa ret. Düello + sıralama + hikaye + nefes sayesinde güvende.
- **5.1.1 Data Collection** → Privacy Policy URL açılmıyorsa direkt ret.
- **3.1.2 Subscriptions** → IAP açıklamaları eksikse ret. Her subscription için benefit listesi yaz.

### Google
- **PACKAGE_USAGE_STATS özel izin** → Declaration formu eksikse ret. permissionsScreen'de net açıklama var (OK).
- **Data Safety yanlış beyanı** → Form ile gerçek app davranışı uyuşmuyorsa ret + policy strike.
- **Target API level** → Flutter 3.11+ zaten Android 14 (API 34) hedefliyor, OK.
- **Closed testing 14 gün + 20 tester** → Yeni hesaplar için ZORUNLU, atlama.

### Her İkisi
- Eksik screenshot
- Çalışmayan Privacy Policy / Support URL
- Test hesabı vermemek (sign-in gereken uygulamada ANINDA ret)
- Crash on launch

---

## 8. Final Checklist (Yüklemeden Hemen Önce)

- [ ] `pubspec.yaml` → `version: 1.0.0+1` doğru
- [ ] `lib/config/revenuecat_config.dart` → GERÇEK API key (placeholder değil)
- [ ] `_demoMode = false` tüm dosyalarda (grep ile kontrol et)
- [ ] Supabase endpoint → PRODUCTION URL ve anon key
- [ ] Google Maps API key (kullanılıyorsa) → production key + HTTP referrer kısıtlaması
- [ ] **Firebase YOK** kontrolü → `grep -r "firebase" lib/` boş dönmeli
- [ ] `android/key.properties` + keystore → **GÜVENLI YEDEKLE** (Google Drive + USB + şifre yöneticisi)
  > UYARI: Keystore kaybedilirse Play Store'a aynı app'i güncelleyemezsin, YENI app olarak submit etmek zorunda kalırsın. KAYBETME.
- [ ] `ios/Runner/Info.plist` → NSLocationWhenInUseUsageDescription, NSPhotoLibraryUsageDescription, NSCameraUsageDescription mevcut (OK)
- [ ] iOS bundle ID Apple Developer → Identifiers'da oluşturuldu
- [ ] FamilyControls capability Xcode'da aktif
- [ ] `flutter analyze` → 0 error
- [ ] `flutter test` → tüm testler geçiyor
- [ ] Release build gerçek cihazda test edildi (hem iOS hem Android)
- [ ] Hesap silme akışı çalışıyor (Profile > Settings > Delete Account)
- [ ] Yasal ekranlar açılıyor (legal_screen.dart → KVKK, Terms, Privacy linkleri)

---

## 9. Yayın Sonrası

- [ ] **ASO (App Store Optimization)**: Keywords'leri haftalık gözden geçir
- [ ] **İlk 100 indirme** → arkadaş ağı + organik → yorum topla (rating istemi)
- [ ] **Crash monitoring**: Sentry/Crashlytics (Firebase YASAK ise Sentry kullan)
- [ ] **Analytics events**: duel_created, duel_won, story_posted, breath_completed, goal_reached
- [ ] **Rating prompt**: 3. gün veya 5. oturum sonrası `in_app_review` göster
- [ ] **Güncellemeler**: İlk 2 hafta hızlı fix cycle (her 3-5 günde bir patch)

---

# 🌙 ŞIMDI YAPILACAKLAR (Gece, Offline, Bilgisayar Başında)

1. [ ] `flutter clean && flutter pub get` çalıştır
2. [ ] `flutter analyze` — 0 error olduğundan emin ol
3. [ ] `lib/config/revenuecat_config.dart` dosyasındaki placeholder'ı gerçek key ile değiştir (hazırda key varsa)
4. [ ] Kodda `_demoMode = false` kontrol et, varsa güncelle
5. [ ] Supabase URL + anon key production değerlerine çek
6. [ ] `flutter build appbundle --release` → AAB üret
7. [ ] AAB dosyasını güvenli yere kopyala (`build/app/outputs/bundle/release/app-release.aab`)
8. [ ] Keystore'u 3 yere yedekle (Drive + USB + şifre yöneticisi notu)
9. [ ] Screenshot'ları hazırla/güncelle (Android: 1080×1920, iOS: 1290×2796)
10. [ ] Feature graphic hazırla (1024×500 PNG)
11. [ ] `privacy-policy.html` ve `terms.html` dosyalarını hazırla (lokalde)
12. [ ] Test hesabı credentials'ı bir yere yaz (`reviewer@gooffgrid.com` / `Test1234!`)
13. [ ] `store/appstore/metadata_tr.txt`, `metadata_en.txt`, `app_privacy.txt` oku, kafanda tazele
14. [ ] `store/playstore/listing_tr.txt`, `listing_en.txt`, `data_safety.txt` oku

---

# ☀️ SABAH YAPILACAKLAR (Online, Insan İle Temas Gerekli)

1. [ ] **Apple Developer Program** kaydı — $99 öde, kimlik doğrulaması (1-2 gün sürebilir)
2. [ ] **Google Play Console** kaydı — $25 öde (genelde 1-2 saat)
3. [ ] **gooffgrid.com** domain satın al (Hostinger/Namecheap)
4. [ ] **DNS ayarları** (A record + MX kayıtları) — Hostinger panelinden
5. [ ] **privacy@gooffgrid.com** + **support@gooffgrid.com** e-posta oluştur
6. [ ] **Privacy Policy + Terms** HTML'lerini hostinga yükle (FTP veya File Manager)
7. [ ] URL'leri tarayıcıda test et: `https://gooffgrid.com/privacy`, `/terms`, `/support`
8. [ ] **App Store Connect** → New App oluştur, bundle ID kaydet
9. [ ] **Apple Developer** → Identifiers → `com.gooffgrid.gooffgrid` oluştur
10. [ ] **Apple Developer** → Capabilities → **FamilyControls** başvurusu yap (Apple'a açıklama yolla)
11. [ ] **Google Play Console** → Create app → tüm form alanlarını doldur
12. [ ] **RevenueCat** hesabı aç, API key al, koda göm (yoksa gece build tekrar gerekir)
13. [ ] **App Store Connect IAP** ürünlerini oluştur (Pro monthly/yearly)
14. [ ] **Google Play IAP** ürünlerini oluştur (Monetize > Subscriptions)
15. [ ] **Banking + Tax bilgileri** (Apple: Agreements; Google: Payments profile)
16. [ ] **Screenshot'ları yükle** (her iki mağaza)
17. [ ] **Metadata'yı yapıştır** (description, keywords, promo text)
18. [ ] **Data Safety formu** (Play) ve **App Privacy formu** (Apple) doldur
19. [ ] **Android closed testing** → AAB yükle → 20 tester e-posta → başlat
20. [ ] **iOS TestFlight** → Mac veya Codemagic'ten build upload → internal test
21. [ ] Her şey yeşilse → **Submit for Review** (Apple) / **Production Release** (Google, 14 gün test sonrası)

---

**Not:** FamilyControls entitlement Apple'dan onay alması 1-2 hafta sürebilir. **Bu adımı en başta başlat.**

**Son Güncelleme:** 2026-04-05

---

## EK: Bireysel Hesap + IAP (Şirketsiz Satış)

Şirketin yoksa da bireysel hesapla IAP satabilirsin.

### Apple Developer (Individual) — $99/yıl
- TC kimlik, adres, telefon, kredi kartı
- Entity Type: **Individual / Sole Proprietor**
- Developer name olarak **gerçek ad-soyad** gözükür

**IAP için** (App Store Connect → Agreements, Tax, and Banking):
1. **Paid Apps Agreement** imzala
2. **Banking:** Kendi adına IBAN + SWIFT
3. **Tax Forms:** W-8BEN (ABD dışı bireyler için)
4. **Vergi No:** TC kimlik numarası

### Google Play Console (Personal) — $25 tek sefer
- TC kimlik, adres, telefon doğrulama, kredi kartı
- Account Type: **Personal**
- D-U-N-S numarası İSTEMEZ (sadece Organization'da ister)

**IAP için:**
1. Play Console → Setup → Payments profile → Google Payments merchant account aç
2. Kendi adına banka hesabı
3. Türkiye bireysel vergi formu
4. Yeni hesapta zorunlu: 20 test kullanıcısı × 14 gün kapalı test

### Komisyon
| Platform | İlk yıl abonelik | Sonraki yıl | Small Business Program |
|---|---|---|---|
| Apple | %30 | %15 | %15 (< $1M yıllık) |
| Google | %30 | %15 | %15 (< $1M yıllık) |

**Small Business Program'a başvur** — ikisinde de ücretsiz, komisyonu yarıya indirir.

### Türkiye Vergi
- Apple/Google net gelir gönderir (komisyon + ABD vergisi düşülmüş)
- Para kendi IBAN'ına gelir
- Yıllık ~330.000 TL'yi aşınca muhasebeciyle konuş (şahıs şirketi / genç girişimci istisnası)
- Başlangıçta bireysel yeterli, sonra şirkete çevirilebilir

### RevenueCat (zaten entegre)
- Şirket istemez, email ile hesap yeter
- $2.5K/ay gelire kadar ücretsiz
- Apple + Google IAP tek dashboard

### Özet
- ✅ Apple + Google bireysel hesap
- ✅ IAP satışı, abonelik, dünya çapında dağıtım
- ✅ Kendi IBAN'ına para akışı
- ❌ Şirket adı göstermek (LTD gerektirir)
