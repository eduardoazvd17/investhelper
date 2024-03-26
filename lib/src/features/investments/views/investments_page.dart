import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:investmentmanager/src/l10n/l10n.dart';

class InvestmentsPage extends StatelessWidget {
  static const String routeName = "/investments";
  const InvestmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _titleWidget(
                  context,
                  AppLocalizations.of(context)!.myInvestments,
                ),
                _investmentsTotalCard(context),
                _titleWidget(
                  context,
                  AppLocalizations.of(context)!.myGoals,
                ),
                _myGoalsListing(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _investmentsTotalCard(context) {
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
                AppLocalizations.of(context)!.monthsMovements,
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
          ],
        ),
      ),
    );
  }

  Widget _myGoalsListing(context) {
    return SizedBox(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
          10,
          (index) {
            return const Card(
              child: SizedBox(width: 180),
            );
          },
        ),
      ),
    );
  }

  Widget _titleWidget(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge,
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
