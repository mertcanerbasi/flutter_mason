# app_name

## Projeyi Başlatma

**flutter paketlerini yükleme**

    flutter clean
    flutter pub get
    flutter gen-l10n

**build runner ile dosyaları oluşturma**

    flutter pub run build_runner build --delete-conflicting-outputs

**Flavor (Çalışma ortamları)**

> Çalışma ortamları detayı için [tıklayınız.](/readme/flavor.md)

**flavor run (Çalışma ortamıa göre yürütme Android-IOS)**

> Fiziksel cihazda, Emulatorde ya da simulatorde projeyi yürütmek için cihazı bilgisayara bağlayın ya da simulator,emulatoru çalıştırın ve ortamlardan biri için projeyi yürütün

    flutter run --flavor development --target lib/main_development.dart

    flutter run --flavor staging --target lib/main_staging.dart

    flutter run --flavor production --target lib/main_production.dart

**Flavor Build (Çalışma Ortamına göre derleme Android-IOS)**

> Apk,appbundle ya da ipa dosyası oluşturmak için kullanın
> version numarası eklemek için alltaki komutları ekleyebilirsiniz.

    --build-name 3.4.60 --build-number 113

_android build apk_

    flutter build apk --flavor development --target lib/main_development.dart

    flutter build apk --flavor staging --target lib/main_staging.dart

    flutter build apk --flavor production --target lib/main_production.dart

_android build appbundle_

    flutter build appbundle --flavor development --target lib/main_development.dart

    flutter build appbundle --flavor staging --target lib/main_staging.dart

    flutter build appbundle --flavor production --target lib/main_production.dart

_ios build ipa_

    flutter build ipa --flavor development --target lib/main_development.dart

    flutter build ipa --flavor staging --target lib/main_staging.dart

    flutter build ipa --flavor production --target lib/main_production.dart

**Android Release AppBundle**

> Kod güvenliği sağlamak ve uygulama boyutunu küçültmek için stora yükenecek appbundle dosyası aşağıdaki komutla alınır.

    flutter clean

    flutter pub get

    flutter gen-l10n

    flutter pub run build_runner build --delete-conflicting-outputs

    flutter build appbundle --obfuscate --split-debug-info=./app_name_mobile/build/outputs  --release  --flavor production --target lib/main_production.dart

    flutter build appbundle --obfuscate --split-debug-info=./app_name_mobile/build/outputs  --release  --flavor productionApi19 --target lib/main_production.dart

**ios Release ipa**

> Kod güvenliği sağlamak ve uygulama boyutunu küçültmek için stora yükenecek appbundle dosyası aşağıdaki komutla alınır.

    flutter clean

    flutter pub get

    flutter pub run build_runner build --delete-conflicting-outputs

    flutter build ipa --obfuscate --split-debug-info=./app_name_mobile/build/outputs  --release  --flavor production --target lib/main_production.dart

> ipa dosyasını stora yüklemek için

    xcrun altool --upload-app --type ios -f build/ios/ipa/*.ipa --apiKey your_api_key --apiIssuer your_issuer_id

---

---

---

# Notlar

**detaylı log**

> termianl işlemlerinde logları detaylandırmak için kullanılır

    --verbose

**scrpit**

> build dosyalarının analizini görmek için

    flutter build appbundle --analyze-size --flavor productionApi19 --target lib/main_production.dart
    flutter build appbundle --analyze-size --flavor productionApi19 --target lib/main_production.dart --target-platform android-x64 // android-arm, android-arm64, or android-x64

    flutter build ios --analyze-size --flavor production --target lib/main_production.dart
