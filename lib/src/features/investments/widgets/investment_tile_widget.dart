import 'package:flutter/material.dart';
import 'package:investhelper/src/features/investments/widgets/category_indicator_widget.dart';
import 'package:investhelper/src/l10n/l10n.dart';

import '../../../core/utils/app_formatter.dart';
import '../models/investment_model.dart';

class InvestmentTileWidget extends StatelessWidget {
  final InvestmentModel investment;
  const InvestmentTileWidget({super.key, required this.investment});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  investment.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(width: 20),
                CategoryIndicatorWidget(
                  category: investment.category,
                  textColor: Colors.grey,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(AppLocalizations.of(context)!
                .custodialPosition(investment.custodialPosition.toString())),
            const SizedBox(height: 2.5),
            Text(
              AppLocalizations.of(context)!.amountInvested(
                AppFormatter.currency(investment.amountInvested),
              ),
            ),
            const SizedBox(height: 2.5),
            Text(
              AppLocalizations.of(context)!.averagePrice(
                AppFormatter.currency(investment.averagePrice),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
