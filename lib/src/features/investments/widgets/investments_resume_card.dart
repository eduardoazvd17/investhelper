import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';

import '../../../core/utils/app_formatter.dart';
import '../../../l10n/l10n.dart';

class InvestmentsResumeCard extends StatelessWidget {
  final double totalInvestments;
  final double thisMonthPurchasesTotal;
  final double thisMonthSalesTotal;
  final bool hideValues;
  final void Function() toggleHideValues;

  const InvestmentsResumeCard({
    super.key,
    required this.totalInvestments,
    required this.thisMonthPurchasesTotal,
    required this.thisMonthSalesTotal,
    required this.hideValues,
    required this.toggleHideValues,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.totalInvestment,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                IconButton(
                  onPressed: toggleHideValues,
                  visualDensity: VisualDensity.compact,
                  icon: hideValues
                      ? const Icon(CupertinoIcons.eye_slash)
                      : const Icon(CupertinoIcons.eye),
                ),
              ],
            ),
            Text(
              hideValues
                  ? '${AppFormatter.currencyPrefix} ••••••'
                  : AppFormatter.currency(totalInvestments),
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.green),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Text(
                AppLocalizations.of(context)!.monthsOperations,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            _movimentationTile(
              context: context,
              tooltip: AppLocalizations.of(context)!.purchaseOperations,
              icon: CupertinoIcons.arrow_up_right,
              value: hideValues
                  ? '${AppFormatter.currencyPrefix} ••••••'
                  : AppFormatter.currency(thisMonthPurchasesTotal),
              color: Colors.green,
            ),
            const SizedBox(height: 5),
            _movimentationTile(
              context: context,
              tooltip: AppLocalizations.of(context)!.salesOperations,
              icon: CupertinoIcons.arrow_down_left,
              value: hideValues
                  ? '${AppFormatter.currencyPrefix} ••••••'
                  : AppFormatter.currency(thisMonthSalesTotal),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _movimentationTile({
    required BuildContext context,
    required String tooltip,
    required IconData icon,
    required String value,
    required Color color,
  }) {
    return Tooltip(
      message: tooltip,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            size: 30,
            color: color,
          ),
          Text(
            value,
            style:
                Theme.of(context).textTheme.titleLarge?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
