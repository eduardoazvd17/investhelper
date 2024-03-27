import 'package:flutter/material.dart';
import 'package:investhelper/src/features/investments/widgets/category_indicator_widget.dart';
import 'package:investhelper/src/l10n/l10n.dart';

class InvestmentTileWidget extends StatelessWidget {
  const InvestmentTileWidget({super.key});

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
                  'MGLU3',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(width: 20),
                const CategoryIndicatorWidget(
                  color: Colors.purple,
                  text: 'Ações',
                  textColor: Colors.grey,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(AppLocalizations.of(context)!.custodialPosition('100')),
            const SizedBox(height: 2.5),
            Text(AppLocalizations.of(context)!.amountInvested('R\$ 299,90')),
            const SizedBox(height: 2.5),
            Text(AppLocalizations.of(context)!.averagePrice('R\$ 2,99')),
          ],
        ),
      ),
    );
  }
}
