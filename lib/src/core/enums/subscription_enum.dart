import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';

enum SubscriptionEnum {
  freeWithAds,
  monthly,
  annual,
  unlimited,
}

extension SubscriptionEnumExtension on SubscriptionEnum {
  String getTitle(BuildContext context) {
    return switch (this) {
      SubscriptionEnum.freeWithAds =>
        AppLocalizations.of(context)!.freeWithAdsSubscription,
      SubscriptionEnum.monthly =>
        AppLocalizations.of(context)!.monthlySubscription,
      SubscriptionEnum.annual =>
        AppLocalizations.of(context)!.annualSubscription,
      SubscriptionEnum.unlimited =>
        AppLocalizations.of(context)!.unlimitedSubscription,
    };
  }
}
