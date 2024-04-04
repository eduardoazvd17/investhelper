import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:investhelper/src/core/widgets/app_auth_overlay.dart';
import 'package:investhelper/src/core/widgets/button_tile_widget.dart';
import 'package:investhelper/src/features/investments/controllers/investments_controller.dart';
import 'package:investhelper/src/features/investments/widgets/daily_tips_widget.dart';
import 'package:investhelper/src/features/investments/widgets/diversity_chart_widget.dart';
import 'package:investhelper/src/features/investments/widgets/goal_card_tile.dart';
import 'package:investhelper/src/features/investments/widgets/investment_tile_widget.dart';
import 'package:investhelper/src/features/settings/views/settings_page.dart';
import 'package:investhelper/src/l10n/l10n.dart';

import '../../../core/utils/widget_event_handler.dart';
import '../../../core/widgets/advise_message_widget.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../core/widgets/section_widget.dart';
import '../widgets/category_listing_widget.dart';
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
  late final WidgetEventHandler _widgetEventHandler;
  late final ScrollController _overviewScrollController;
  late final ScrollController _detailsScrollController;

  InvestmentsController get controller => widget.controller;

  @override
  void initState() {
    _widgetEventHandler = WidgetEventHandler(
      onResume: () {
        if (controller.shouldRequestAuth) {
          AppAuthOverlay.show(context);
        }
      },
    );
    WidgetsBinding.instance.addObserver(_widgetEventHandler);
    _overviewScrollController = ScrollController();
    _detailsScrollController = ScrollController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _widgetEventHandler.onResume?.call();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_widgetEventHandler);
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
        child: Observer(
          builder: (_) {
            return Visibility(
              visible: !controller.isLoading,
              replacement: const Center(child: LoadingWidget()),
              child: switch (_currentPage) {
                0 => _overviewTabContent,
                1 => _detailsTabContent,
                int() => const SizedBox(),
              },
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: _onChangeCurrentPage,
        items: [
          BottomNavigationBarItem(
            icon: const Padding(
              padding: EdgeInsets.only(bottom: 2.5),
              child: Icon(CupertinoIcons.chart_pie),
            ),
            label: AppLocalizations.of(context)!.overview,
          ),
          BottomNavigationBarItem(
            icon: const Padding(
              padding: EdgeInsets.only(bottom: 2.5),
              child: Icon(CupertinoIcons.chart_bar),
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
                title: AppLocalizations.of(context)!.quickActions,
                content: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.arrow_up_right),
                    label: Text(
                        AppLocalizations.of(context)!.insertPurchaseOperation),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.arrow_down_left),
                    label:
                        Text(AppLocalizations.of(context)!.insertSaleOperation),
                  ),
                ],
              ),
              SectionWidget(
                title: AppLocalizations.of(context)!.diversity,
                content: [
                  Observer(
                    builder: (_) {
                      final bool hasData = controller.investments
                          .where((e) => e.hasData)
                          .isNotEmpty;

                      return Observer(
                        builder: (_) {
                          return SizedBox(
                            height: hasData ? 160 : null,
                            child: Visibility(
                              visible: hasData,
                              replacement: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: AdviseMessageWidget(
                                  message: AppLocalizations.of(context)!
                                      .emptyDiversityGraphText,
                                ),
                              ),
                              child: DiversityChartWidget(
                                totalInvestments: controller.totalInvestments,
                                investments: controller.investments,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () {},
                    child:
                        Text(AppLocalizations.of(context)!.accessMyInvestments),
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
                          replacement: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: AdviseMessageWidget(
                              message: AppLocalizations.of(context)!
                                  .emptyMyGoalsText,
                            ),
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
                  TextButton(
                    onPressed: () {},
                    child: Text(AppLocalizations.of(context)!.editMyGoals),
                  ),
                ],
              ),
              Observer(
                warnWhenNoObservables: false,
                builder: (_) {
                  if (controller.dailyTip == null) return const SizedBox();
                  return SectionWidget(
                    title: AppLocalizations.of(context)!.tips,
                    content: [DailyTipsWidget(dailyTip: controller.dailyTip!)],
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
                        replacement: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: AdviseMessageWidget(
                            message: AppLocalizations.of(context)!
                                .emptyInvestmentsText,
                          ),
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
                title: AppLocalizations.of(context)!.categories,
                content: const [CategoryListingWidget()],
              ),
              SectionWidget(
                title: AppLocalizations.of(context)!.productsAndServices,
                content: [
                  ButtonTileWidget(
                    icon: CupertinoIcons.arrow_up_arrow_down,
                    text: AppLocalizations.of(context)!
                        .operationsHistoryPerformed,
                    onTap: () {},
                  ),
                  ButtonTileWidget(
                    icon: CupertinoIcons.doc_chart,
                    text: AppLocalizations.of(context)!.exportInvestmentReport,
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
