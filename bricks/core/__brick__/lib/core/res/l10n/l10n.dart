import 'package:flutter/widgets.dart';
import '../l10n/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

extension FullName on Locale {
  String fullName() {
    switch (languageCode) {
      case 'en':
        return 'English';
      case 'es':
        return 'Español';
      case 'tr':
        return 'Türkçe';
    }
    return '';
  }
}
