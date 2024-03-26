import 'package:flutter/cupertino.dart' show CupertinoIcons;
import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';

class InvestmentsResumeCard extends StatelessWidget {
  const InvestmentsResumeCard({super.key});

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
                  onPressed: () {},
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(CupertinoIcons.eye_slash),
                ),
              ],
            ),
            Text(
              'R\$ 0,00',
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
              tooltip: AppLocalizations.of(context)!.buyOperations,
              icon: CupertinoIcons.arrow_up_right,
              value: 'R\$ 0,00',
              color: Colors.green,
            ),
            const SizedBox(height: 5),
            _movimentationTile(
              context: context,
              tooltip: AppLocalizations.of(context)!.sellOperations,
              icon: CupertinoIcons.arrow_down_left,
              value: 'R\$ 0,00',
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(AppLocalizations.of(context)!.seeMyOperations),
              ),
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
