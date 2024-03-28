import 'package:flutter/cupertino.dart';
import 'package:investhelper/src/l10n/l10n.dart';

enum LanguageEnum {
  system,
  english,
  portuguese,
}

extension ThemeEnumExtension on LanguageEnum {
  String getTitle(BuildContext context) {
    return switch (this) {
      LanguageEnum.system => AppLocalizations.of(context)!.system,
      LanguageEnum.english => AppLocalizations.of(context)!.english,
      LanguageEnum.portuguese => AppLocalizations.of(context)!.portuguese,
    };
  }

  Widget get icon {
    return switch (this) {
      LanguageEnum.system => const Icon(CupertinoIcons.settings),
      LanguageEnum.english => const Text(
          'EN',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      LanguageEnum.portuguese => const Text(
          'PT',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
    };
  }

  Locale? get locale {
    final String? countryCode =
        WidgetsBinding.instance.platformDispatcher.locale.countryCode;
    return switch (this) {
      LanguageEnum.system => null,
      LanguageEnum.english => Locale('en', countryCode),
      LanguageEnum.portuguese => Locale('pt', countryCode),
    };
  }
}
