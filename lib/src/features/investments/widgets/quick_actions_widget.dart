import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';

class QuickActionsWidget extends StatelessWidget {
  const QuickActionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.arrow_up_right),
          label: Text(AppLocalizations.of(context)!.insertBuyOperation),
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.arrow_down_left),
          label: Text(AppLocalizations.of(context)!.insertSellOperation),
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.pen),
          label: Text(AppLocalizations.of(context)!.editMyGoals),
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.arrow_up_arrow_down),
          label: Text(AppLocalizations.of(context)!.seeMyOperations),
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.dashboard_outlined),
          label: Text(AppLocalizations.of(context)!.investmentOverview),
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.doc),
          label: Text(AppLocalizations.of(context)!.generatedReports),
        ),
      ],
    );
  }
}
