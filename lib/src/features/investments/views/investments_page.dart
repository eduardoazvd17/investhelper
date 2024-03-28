import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:investhelper/src/core/widgets/button_tile_widget.dart';
import 'package:investhelper/src/features/investments/widgets/category_indicator_widget.dart';
import 'package:investhelper/src/features/investments/widgets/daily_tips_widget.dart';
import 'package:investhelper/src/features/investments/widgets/diversity_chart_widget.dart';
import 'package:investhelper/src/features/investments/widgets/goal_card_tile.dart';
import 'package:investhelper/src/features/investments/widgets/investment_tile_widget.dart';
import 'package:investhelper/src/features/investments/widgets/quick_actions_widget.dart';
import 'package:investhelper/src/features/settings/views/settings_page.dart';
import 'package:investhelper/src/l10n/l10n.dart';

import '../../../core/widgets/section_widget.dart';
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
            Image.asset("assets/images/logo.png", height: 40),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                AppLocalizations.of(context)!.hiUser('Teste'),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(SettingsPage.routeName);
            },
            icon: const Icon(CupertinoIcons.settings),
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
            icon: const Padding(
              padding: EdgeInsets.only(bottom: 2.5),
              child: Icon(Icons.dashboard_outlined),
            ),
            label: AppLocalizations.of(context)!.overview,
          ),
          BottomNavigationBarItem(
            icon: const Padding(
              padding: EdgeInsets.only(bottom: 2.5),
              child: Icon(CupertinoIcons.arrow_up_arrow_down),
            ),
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
              SectionWidget(
                title: AppLocalizations.of(context)!.overview,
                content: const [InvestmentsResumeCard()],
              ),
              SectionWidget(
                title: AppLocalizations.of(context)!.diversity,
                content: const [DiversityChartWidget()],
              ),
              SectionWidget(
                title: AppLocalizations.of(context)!.myGoals,
                content: [
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
                ],
              ),
              SectionWidget(
                title: AppLocalizations.of(context)!.quickActions,
                content: const [QuickActionsWidget()],
              ),
              SectionWidget(
                title: AppLocalizations.of(context)!.tips,
                content: const [DailyTipsWidget()],
              ),
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
              SectionWidget(
                title: AppLocalizations.of(context)!.investments,
                actions: [
                  IconButton(
                    onPressed: () {},
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(Icons.add),
                  ),
                ],
                content: [
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
                    child:
                        Text(AppLocalizations.of(context)!.accessMyInvestments),
                  ),
                ],
              ),
              SectionWidget(
                title: AppLocalizations.of(context)!.categories,
                actions: [
                  IconButton(
                    onPressed: () {},
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(Icons.add),
                  ),
                ],
                content: [
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
                ],
              ),
              SectionWidget(
                title: AppLocalizations.of(context)!.productsAndServices,
                content: [
                  ButtonTileWidget(
                    text: AppLocalizations.of(context)!.myGoals,
                    onTap: () {},
                  ),
                  ButtonTileWidget(
                    text: AppLocalizations.of(context)!
                        .operationsHistoryPerformed,
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
