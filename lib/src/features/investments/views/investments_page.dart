import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:investhelper/src/core/widgets/button_tile_widget.dart';
import 'package:investhelper/src/features/investments/controllers/investments_controller.dart';
import 'package:investhelper/src/features/investments/widgets/category_indicator_widget.dart';
import 'package:investhelper/src/features/investments/widgets/daily_tips_widget.dart';
import 'package:investhelper/src/features/investments/widgets/diversity_chart_widget.dart';
import 'package:investhelper/src/features/investments/widgets/goal_card_tile.dart';
import 'package:investhelper/src/features/investments/widgets/investment_tile_widget.dart';
import 'package:investhelper/src/features/investments/widgets/quick_actions_widget.dart';
import 'package:investhelper/src/features/settings/views/settings_page.dart';
import 'package:investhelper/src/l10n/l10n.dart';

import '../../../core/widgets/advise_message_widget.dart';
import '../../../core/widgets/section_widget.dart';
import '../widgets/investments_resume_card.dart';

class InvestmentsPage extends StatefulWidget {
  static const String routeName = "/investments";
  final InvestmentsController controller;
  const InvestmentsPage({super.key, required this.controller});

  @override
  State<InvestmentsPage> createState() => _InvestmentsPageState();
}

class _InvestmentsPageState extends State<InvestmentsPage> {
  int _currentPage = 0;
  late final ScrollController _overviewScrollController;
  late final ScrollController _detailsScrollController;

  InvestmentsController get controller => widget.controller;

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

  void _onChangeCurrentPage(int? index) {
    setState(() => _currentPage = index ?? 0);
    if (_overviewScrollController.hasClients) {
      _overviewScrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
    if (_detailsScrollController.hasClients) {
      _detailsScrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
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
              child: Observer(
                builder: (_) {
                  return Text(
                    AppLocalizations.of(context)!.hiUser(
                      controller.user?.shortName ?? '',
                    ),
                  );
                },
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
        onTap: _onChangeCurrentPage,
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
                content: [
                  Observer(
                    builder: (_) {
                      return InvestmentsResumeCard(
                        totalInvestments: controller.totalInvestments,
                        thisMonthPurchasesTotal:
                            controller.thisMonthPurchasesTotal,
                        thisMonthSalesTotal: controller.thisMonthSalesTotal,
                        hideValues: controller.hideValues,
                        toggleHideValues: controller.toggleHideValues,
                      );
                    },
                  ),
                ],
              ),
              SectionWidget(
                title: AppLocalizations.of(context)!.diversity,
                content: [
                  Observer(
                    builder: (_) {
                      return DiversityChartWidget(
                        totalInvestments: controller.totalInvestments,
                        categories: controller.categories,
                        investments: controller.investments,
                      );
                    },
                  ),
                ],
              ),
              SectionWidget(
                title: AppLocalizations.of(context)!.myGoals,
                content: [
                  Observer(
                    builder: (_) {
                      final bool hasData = controller.goals.isNotEmpty;
                      return SizedBox(
                        height: hasData ? 120 : null,
                        child: Visibility(
                          visible: hasData,
                          replacement: AdviseMessageWidget(
                            message:
                                AppLocalizations.of(context)!.emptyMyGoalsText,
                          ),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: controller.goals.map((goal) {
                              return GoalCardTile(goal: goal);
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              SectionWidget(
                title: AppLocalizations.of(context)!.quickActions,
                content: const [QuickActionsWidget()],
              ),
              Observer(
                warnWhenNoObservables: false,
                builder: (_) {
                  if (controller.dailyTip == null) return const SizedBox();
                  return SectionWidget(
                    title: AppLocalizations.of(context)!.tips,
                    content: [
                      DailyTipsWidget(
                        dailyTip: controller.dailyTip!,
                      )
                    ],
                  );
                },
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
                title: AppLocalizations.of(context)!.categories,
                actions: [
                  IconButton(
                    onPressed: () {},
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(Icons.add),
                  ),
                ],
                content: [
                  Observer(
                    builder: (_) {
                      final bool hasData = controller.categories.isNotEmpty;
                      return SizedBox(
                        height: hasData ? 60 : null,
                        child: Visibility(
                          visible: hasData,
                          replacement: AdviseMessageWidget(
                            message: AppLocalizations.of(context)!
                                .emptyCategoriesText,
                          ),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: controller.categories.map((e) {
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: CategoryIndicatorWidget(category: e),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
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
                title: AppLocalizations.of(context)!.investments,
                actions: [
                  IconButton(
                    onPressed: () {},
                    visualDensity: VisualDensity.compact,
                    icon: const Icon(Icons.add),
                  ),
                ],
                content: [
                  Observer(builder: (_) {
                    final bool hasData = controller.investments.isNotEmpty;
                    return SizedBox(
                      height: hasData ? 150 : null,
                      child: Visibility(
                        visible: hasData,
                        replacement: AdviseMessageWidget(
                          message: AppLocalizations.of(context)!
                              .emptyInvestmentsText,
                        ),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: controller.investments
                              .map((e) => InvestmentTileWidget(investment: e))
                              .toList(),
                        ),
                      ),
                    );
                  }),
                  TextButton(
                    onPressed: () {},
                    child:
                        Text(AppLocalizations.of(context)!.accessMyInvestments),
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
