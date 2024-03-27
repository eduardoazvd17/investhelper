import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:investmentmanager/src/features/auth/views/auth_page.dart';
import 'package:investmentmanager/src/features/investments/widgets/category_indicator_widget.dart';
import 'package:investmentmanager/src/features/investments/widgets/daily_tips_widget.dart';
import 'package:investmentmanager/src/features/investments/widgets/diversity_chart_widget.dart';
import 'package:investmentmanager/src/features/investments/widgets/goal_card_tile.dart';
import 'package:investmentmanager/src/features/investments/widgets/investment_tile_widget.dart';
import 'package:investmentmanager/src/features/investments/widgets/quick_actions_widget.dart';
import 'package:investmentmanager/src/l10n/l10n.dart';

import '../widgets/investments_resume_card.dart';

class InvestmentsPage extends StatefulWidget {
  static const String routeName = "/investments";
  const InvestmentsPage({super.key});

  @override
  State<InvestmentsPage> createState() => _InvestmentsPageState();
}

class _InvestmentsPageState extends State<InvestmentsPage> {
  int _currentPage = 0;
  late final ScrollController _overviewScrollController;
  late final ScrollController _detailsScrollController;

  @override
  void initState() {
    _overviewScrollController = ScrollController();
    _detailsScrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _overviewScrollController.dispose();
    _detailsScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(
              CupertinoIcons.person_alt_circle,
              size: 45,
              color: Colors.grey,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                AppLocalizations.of(context)!.hiUser('Teste'),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(AuthPage.routeName);
            },
            child: Text(AppLocalizations.of(context)!.exit),
          ),
        ],
      ),
      body: SafeArea(
        child: switch (_currentPage) {
          0 => _overviewTabContent,
          1 => _detailsTabContent,
          int() => const SizedBox(),
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (int? index) => setState(() => _currentPage = index ?? 0),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.dashboard_outlined),
            label: AppLocalizations.of(context)!.overview,
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.arrow_up_arrow_down),
            label: AppLocalizations.of(context)!.investments,
          ),
        ],
      ),
    );
  }

  Widget get _overviewTabContent {
    return Scrollbar(
      controller: _overviewScrollController,
      thumbVisibility: true,
      child: SingleChildScrollView(
        controller: _overviewScrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titleWidget(AppLocalizations.of(context)!.overview),
              const InvestmentsResumeCard(),
              _titleWidget(AppLocalizations.of(context)!.diversity),
              const DiversityChartWidget(),
              _titleWidget(AppLocalizations.of(context)!.myGoals),
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
              _titleWidget(AppLocalizations.of(context)!.quickActions),
              const QuickActionsWidget(),
              _titleWidget(AppLocalizations.of(context)!.tips),
              const DailyTipsWidget(),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _detailsTabContent {
    return Scrollbar(
      controller: _detailsScrollController,
      thumbVisibility: true,
      child: SingleChildScrollView(
        controller: _detailsScrollController,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titleWidget(
                AppLocalizations.of(context)!.investments,
                actions: [
                  IconButton(
                    onPressed: () {},
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              SizedBox(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    10,
                    (index) => const InvestmentTileWidget(),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(AppLocalizations.of(context)!.accessMyInvestments),
              ),
              _titleWidget(
                AppLocalizations.of(context)!.categories,
                actions: [
                  IconButton(
                    onPressed: () {},
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    10,
                    (index) => const Card(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: CategoryIndicatorWidget(
                          color: Colors.purple,
                          text: 'Ações',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  AppLocalizations.of(context)!.personalizeCategories,
                ),
              ),
              _titleWidget(AppLocalizations.of(context)!.productsAndServices),
              _buttonTile(
                text: AppLocalizations.of(context)!.myGoals,
                onTap: () {},
              ),
              _buttonTile(
                text: AppLocalizations.of(context)!.operationsHistoryPerformed,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleWidget(
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

  Widget _buttonTile({
    required String text,
    required void Function() onTap,
  }) {
    final color = Theme.of(context).primaryColor;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: color),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Icon(Icons.arrow_forward_ios, color: color),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
