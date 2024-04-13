import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../l10n/l10n.dart';

enum ThemeEnum {
  system,
  light,
  dark,
}

extension ThemeEnumExtension on ThemeEnum {
  String getTitle(BuildContext context) {
    return switch (this) {
      ThemeEnum.system => AppLocalizations.of(context)!.system,
      ThemeEnum.light => AppLocalizations.of(context)!.lightMode,
      ThemeEnum.dark => AppLocalizations.of(context)!.darkMode,
    };
  }

  Icon get icon {
    return switch (this) {
      ThemeEnum.system => const Icon(CupertinoIcons.settings),
      ThemeEnum.light =>
        const Icon(CupertinoIcons.sun_max, color: Colors.orange),
      ThemeEnum.dark => Icon(CupertinoIcons.moon, color: Colors.purple[300]),
    };
  }

  ThemeMode get themeMode {
    return switch (this) {
      ThemeEnum.system => ThemeMode.system,
      ThemeEnum.light => ThemeMode.light,
      ThemeEnum.dark => ThemeMode.dark,
    };
  }
}
