import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';

enum SubscriptionEnum {
  free,
  monthly,
  annual,
  unlimited,
}

extension SubscriptionEnumExtension on SubscriptionEnum {
  String getTitle(BuildContext context) {
    return switch (this) {
      SubscriptionEnum.free => AppLocalizations.of(context)!.freeSubscription,
      SubscriptionEnum.monthly =>
        AppLocalizations.of(context)!.monthlySubscription,
      SubscriptionEnum.annual =>
        AppLocalizations.of(context)!.annualSubscription,
      SubscriptionEnum.unlimited =>
        AppLocalizations.of(context)!.unlimitedSubscription,
    };
  }

  String getFeatures(BuildContext context) {
    return switch (this) {
      SubscriptionEnum.free =>
        AppLocalizations.of(context)!.freeSubscriptionFeatures,
      SubscriptionEnum.monthly =>
        AppLocalizations.of(context)!.monthlySubscriptionFeatures,
      SubscriptionEnum.annual =>
        AppLocalizations.of(context)!.annualSubscriptionFeatures,
      SubscriptionEnum.unlimited =>
        AppLocalizations.of(context)!.monthlySubscriptionFeatures,
    };
  }

  String get productId {
    return switch (this) {
      SubscriptionEnum.free => '',
      SubscriptionEnum.monthly => 'investhelper_monthly_plan',
      SubscriptionEnum.annual => 'investhelper_annual_plan',
      SubscriptionEnum.unlimited => '',
    };
  }

  static Map<SubscriptionEnum, String> get productIds => {
        SubscriptionEnum.monthly: 'investhelper_monthly_plan',
        SubscriptionEnum.annual: 'investhelper_annual_plan',
      };

  static SubscriptionEnum fromProductId(String productId) {
    return productIds.entries.firstWhere((entry) {
      return entry.value == productId;
    }, orElse: () => const MapEntry(SubscriptionEnum.free, '')).key;
  }
}
