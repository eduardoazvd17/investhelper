import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';

enum CategoryEnum {
  stocks,
  mutualFunds,
  reits,
  fixedIncome,
  treasuryBonds,
  savingsAccount,
  privatePensionPlans,
  commodities,
  etfs,
  cryptocurrencies,
}

extension CategoryEnumExtension on CategoryEnum {
  String getTitle(BuildContext context) {
    switch (this) {
      case CategoryEnum.stocks:
        return AppLocalizations.of(context)!.stocks;
      case CategoryEnum.mutualFunds:
        return AppLocalizations.of(context)!.mutualFunds;
      case CategoryEnum.fixedIncome:
        return AppLocalizations.of(context)!.fixedIncome;
      case CategoryEnum.reits:
        return AppLocalizations.of(context)!.reits;
      case CategoryEnum.treasuryBonds:
        return AppLocalizations.of(context)!.treasuryBonds;
      case CategoryEnum.savingsAccount:
        return AppLocalizations.of(context)!.savingsAccount;
      case CategoryEnum.privatePensionPlans:
        return AppLocalizations.of(context)!.privatePensionPlans;
      case CategoryEnum.commodities:
        return AppLocalizations.of(context)!.commodities;
      case CategoryEnum.etfs:
        return AppLocalizations.of(context)!.etfs;
      case CategoryEnum.cryptocurrencies:
        return AppLocalizations.of(context)!.cryptocurrencies;
    }
  }

  Color get color {
    switch (this) {
      case CategoryEnum.stocks:
        return Colors.purple;
      case CategoryEnum.mutualFunds:
        return Colors.blue;
      case CategoryEnum.fixedIncome:
        return Colors.green;
      case CategoryEnum.reits:
        return Colors.brown;
      case CategoryEnum.treasuryBonds:
        return Colors.pink;
      case CategoryEnum.savingsAccount:
        return Colors.yellow;
      case CategoryEnum.privatePensionPlans:
        return Colors.grey;
      case CategoryEnum.commodities:
        return Colors.red;
      case CategoryEnum.etfs:
        return Colors.indigo;
      case CategoryEnum.cryptocurrencies:
        return Colors.orange;
    }
  }
}
