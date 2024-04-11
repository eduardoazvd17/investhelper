import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';

enum CategoryEnum {
  stocks,
  mutualFunds,
  reits,
  fixedIncome,
  treasuryBonds,
  savingsAccount,
  // privatePensionPlans,
  // commodities,
  // etfs,
  cryptocurrencies,
  others,
}

extension CategoryEnumExtension on CategoryEnum {
  String getTitle(BuildContext context) {
    return switch (this) {
      CategoryEnum.stocks => AppLocalizations.of(context)!.stocks,
      CategoryEnum.mutualFunds => AppLocalizations.of(context)!.mutualFunds,
      CategoryEnum.fixedIncome => AppLocalizations.of(context)!.fixedIncome,
      CategoryEnum.reits => AppLocalizations.of(context)!.reits,
      CategoryEnum.treasuryBonds => AppLocalizations.of(context)!.treasuryBonds,
      CategoryEnum.savingsAccount =>
        AppLocalizations.of(context)!.savingsAccount,
      // CategoryEnum.privatePensionPlans => AppLocalizations.of(context)!.privatePensionPlans;
      // CategoryEnum.commodities => AppLocalizations.of(context)!.commodities;
      // CategoryEnum.etfs => AppLocalizations.of(context)!.etfs;
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
      // CategoryEnum.privatePensionPlans => Colors.grey;
      // CategoryEnum.commodities => Colors.red;
      // CategoryEnum.etfs => Colors.indigo;
      CategoryEnum.cryptocurrencies => Colors.orange,
      CategoryEnum.others => Colors.blueGrey
    };
  }
}
