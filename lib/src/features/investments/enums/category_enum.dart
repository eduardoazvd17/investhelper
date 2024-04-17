import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';

enum CategoryEnum {
  stocks,
  mutualFunds,
  reits,
  fixedIncome,
  treasuryBonds,
  savingsAccount,
  cryptocurrencies,
  others,
}

extension CategoryEnumExtension on CategoryEnum {
  bool get isCrypto {
    return switch (this) {
      CategoryEnum.cryptocurrencies => true,
      CategoryEnum() => false,
    };
  }

  bool get hasQuotas {
    return switch (this) {
      CategoryEnum.stocks => true,
      CategoryEnum.mutualFunds => true,
      CategoryEnum.reits => true,
      CategoryEnum() => false,
    };
  }

  String getTitle(BuildContext context) {
    return switch (this) {
      CategoryEnum.stocks => AppLocalizations.of(context)!.stocks,
      CategoryEnum.mutualFunds => AppLocalizations.of(context)!.mutualFunds,
      CategoryEnum.fixedIncome => AppLocalizations.of(context)!.fixedIncome,
      CategoryEnum.reits => AppLocalizations.of(context)!.reits,
      CategoryEnum.treasuryBonds => AppLocalizations.of(context)!.treasuryBonds,
      CategoryEnum.savingsAccount =>
        AppLocalizations.of(context)!.savingsAccount,
      CategoryEnum.cryptocurrencies =>
        AppLocalizations.of(context)!.cryptocurrencies,
      CategoryEnum.others => AppLocalizations.of(context)!.others
    };
  }

  Color get color {
    return switch (this) {
      CategoryEnum.stocks => Colors.purple,
      CategoryEnum.mutualFunds => Colors.blue,
      CategoryEnum.fixedIncome => Colors.green,
      CategoryEnum.reits => Colors.brown,
      CategoryEnum.treasuryBonds => Colors.pink,
      CategoryEnum.savingsAccount => Colors.yellow,
      CategoryEnum.cryptocurrencies => Colors.orange,
      CategoryEnum.others => Colors.blueGrey
    };
  }
}
