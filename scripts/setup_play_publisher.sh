#!/usr/bin/env bash
# Bir kerelik kurulum: Google Cloud projesinde service account üret + Play Console'a publish izni ver.
#
# Önkoşul:
#   1. gcloud CLI kurulu (https://cloud.google.com/sdk/docs/install)
#   2. `gcloud auth login` yapılmış (aynı Google hesabı, Play Console sahibi)
#   3. Play Console'da "com.gooffgrid.gooffgrid" uygulaması oluşturulmuş olmalı
#
# Çalıştır:
#   bash scripts/setup_play_publisher.sh
#
# Çıktı:
#   /tmp/gooffgrid-play-publisher.json  -> Codemagic UI'ya GCLOUD_SERVICE_ACCOUNT_CREDENTIALS olarak ekle
#
# Manuel adım (script'in yapamayacağı):
#   Play Console -> Kullanıcılar ve izinler -> Yeni kullanıcılar davet et ->
#   email = ${SA_EMAIL} (script çıktısına bakar) ->
#   Hesap düzeyi izinler: "Sürümleri Yayınla" + "Uygulama bilgilerini görüntüle" ver

set -euo pipefail

PROJECT_ID="gooffgrid-publisher"
SA_NAME="gooffgrid-publisher"
SA_DISPLAY="GoOffGrid Play Publisher"
KEY_OUT="/tmp/gooffgrid-play-publisher.json"

echo "[1/5] Project: $PROJECT_ID"
gcloud projects describe "$PROJECT_ID" >/dev/null 2>&1 || \
  gcloud projects create "$PROJECT_ID" --name="GoOffGrid Publisher"

echo "[2/5] Enabling androidpublisher.googleapis.com"
gcloud services enable androidpublisher.googleapis.com --project="$PROJECT_ID"

echo "[3/5] Service account: ${SA_NAME}@${PROJECT_ID}.iam.gserviceaccount.com"
SA_EMAIL="${SA_NAME}@${PROJECT_ID}.iam.gserviceaccount.com"
gcloud iam service-accounts describe "$SA_EMAIL" --project="$PROJECT_ID" >/dev/null 2>&1 || \
  gcloud iam service-accounts create "$SA_NAME" \
    --display-name="$SA_DISPLAY" \
    --project="$PROJECT_ID"

echo "[4/5] Generating key -> $KEY_OUT"
gcloud iam service-accounts keys create "$KEY_OUT" \
  --iam-account="$SA_EMAIL" \
  --project="$PROJECT_ID"

echo "[5/5] Done."
echo
echo "==> Service account: $SA_EMAIL"
echo "==> Key file:        $KEY_OUT"
echo
echo "SONRAKI MANUEL ADIMLAR:"
echo
echo "  A) Play Console (web) -> Kullanıcılar ve izinler -> Yeni kullanıcılar davet et"
echo "     Email:  $SA_EMAIL"
echo "     İzinler: 'Sürümleri yayınla' + 'Uygulama bilgilerini görüntüle' + 'Üretim'"
echo
echo "  B) Codemagic UI (https://codemagic.io/app/69cad53e08e63b52a2833133/settings)"
echo "     -> Environment variables -> Group: gooffgrid_env"
echo "     -> Add: GCLOUD_SERVICE_ACCOUNT_CREDENTIALS = $(cat $KEY_OUT | tr -d '\\n' | head -c 30)... (full file)"
echo "     -> 'Secure' (Mark as secure) checked"
echo
echo "  C) İlk AAB yükleme (Google policy: ilk yükleme MANUEL):"
echo "     Play Console -> gooffgrid -> Test ve sürüm -> Internal testing -> Sürüm oluştur"
echo "     -> AAB yükle: build/app/outputs/bundle/release/app-release.aab"
echo "     -> Kaydet -> İncelemeye gönder"
echo
echo "  D) Sonraki yüklemeler otomatik (codemagic.yaml zaten ayarlı)"
