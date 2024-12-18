import 'en_us/en_us_translations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';

import 'es/es_translations.dart';

class AppLocalization {
  AppLocalization(this.locale);

  Locale locale;

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': enUs,
    'es': es
  };

  // static AppLocalization of() {
  //   return Localizations.of<AppLocalization>(
  //       NavigatorService.navigatorKey.currentContext!, AppLocalization)!;
  // }
  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization)!;
  }

  static List<String> languages() => _localizedValues.keys.toList();

  String getString(String text) =>
      _localizedValues[locale.languageCode]![text] ?? text;
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppLocalization.languages().contains(locale.languageCode);

  //Returning a SynchronousFuture here because an async "load" operation
  //cause an async "load" operation
  @override
  Future<AppLocalization> load(Locale locale) {
    return SynchronousFuture<AppLocalization>(AppLocalization(locale));
  }

  @override
  bool shouldReload(AppLocalizationDelegate old) => false;
}

extension LocalizationExtension on String {
  String tr(BuildContext context) =>
      AppLocalization.of(context).getString(this);
}
