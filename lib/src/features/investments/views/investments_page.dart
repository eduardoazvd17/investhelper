import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:investmentmanager/src/features/investments/widgets/diversity_chart_widget.dart';
import 'package:investmentmanager/src/features/investments/widgets/goal_card_tile.dart';
import 'package:investmentmanager/src/l10n/l10n.dart';

import '../widgets/investments_resume_card.dart';

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
                const InvestmentsResumeCard(),
                _titleWidget(
                  context,
                  AppLocalizations.of(context)!.myGoals,
                  actions: [
                    IconButton(
                      onPressed: () {},
                      visualDensity: VisualDensity.compact,
                      icon: const Icon(CupertinoIcons.pen),
                    ),
                  ],
                ),
                SizedBox(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      10,
                      (index) => const GoalCardTile(),
                    ),
                  ),
                ),
                _titleWidget(
                  context,
                  AppLocalizations.of(context)!.diversity,
                ),
                const DiversityChartWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleWidget(
    BuildContext context,
    String text, {
    List<Widget> actions = const [],
  }) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        const SizedBox(width: 10),
        ...actions,
      ],
    );
  }
}
