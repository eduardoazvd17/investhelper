import 'package:flutter/cupertino.dart';

import '../../../l10n/l10n.dart';

enum InvestmentsPageSubTabsEnum {
  overview,
  investments,
}

extension InvestmentsPageSubTabsEnumExtension on InvestmentsPageSubTabsEnum {
  String getTitle(BuildContext context) {
    return switch (this) {
      InvestmentsPageSubTabsEnum.overview =>
        AppLocalizations.of(context)!.overview,
      InvestmentsPageSubTabsEnum.investments =>
        AppLocalizations.of(context)!.investments,
    };
  }

  Widget get icon {
    return switch (this) {
      InvestmentsPageSubTabsEnum.overview =>
        const Icon(CupertinoIcons.chart_pie),
      InvestmentsPageSubTabsEnum.investments =>
        const Icon(CupertinoIcons.chart_bar),
    };
  }
}
