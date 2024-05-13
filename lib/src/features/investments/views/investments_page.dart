import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/enums/subscription_enum.dart';
import '../../../core/exceptions/app_exception.dart';
import '../../../core/utils/widget_event_handler.dart';
import '../../../core/widgets/advise_message_widget.dart';
import '../../../core/widgets/auth_overlay.dart';
import '../../../core/widgets/blur_overlay.dart';
import '../../../core/widgets/button_tile_widget.dart';
import '../../../core/widgets/dialog_widget.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../core/widgets/section_widget.dart';
import '../../../l10n/l10n.dart';
import '../../auth/views/auth_page.dart';
import '../../monetization/widgets/banner_ad_widget.dart';
import '../../settings/views/settings_page.dart';
import '../controllers/investments_controller.dart';
import '../widgets/category_listing_widget.dart';
import '../widgets/daily_tips_widget.dart';
import '../widgets/diversity_chart_widget.dart';
import '../widgets/goal_tile_widget.dart';
import '../widgets/investment_tile_widget.dart';
import '../widgets/investments_resume_card.dart';
import '../widgets/operation_tile_widget.dart';
import 'manage_my_goals_page.dart';
import 'manage_my_investments_page.dart';
import 'manage_my_operations_page.dart';

class InvestmentsPage extends StatefulWidget {
  static const String routeName = "/investments";
  final InvestmentsController controller;
  const InvestmentsPage({super.key, required this.controller});

  @override
  State<InvestmentsPage> createState() => _InvestmentsPageState();
}

class _InvestmentsPageState extends State<InvestmentsPage> {
  bool _blurContent = false;
  int _currentPage = 0;
  late final WidgetEventHandler _widgetEventHandler;
  late final ScrollController _overviewScrollController;
  late final ScrollController _detailsScrollController;

  InvestmentsController get controller => widget.controller;

  @override
  void initState() {
    _widgetEventHandler = WidgetEventHandler(
      onResumed: () async {
        if (_blurContent) {
          Navigator.of(context).pop();
          _blurContent = false;
        }
        if (controller.shouldRequestAuth) {
          AuthOverlay.show(context);
        }
      },
      onInactive: () {
        if (!_blurContent) {
          _blurContent = true;
          BlurOverlay.show(context);
        }
      },
    );
    WidgetsBinding.instance.addObserver(_widgetEventHandler);
    _overviewScrollController = ScrollController();
    _detailsScrollController = ScrollController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _widgetEventHandler.onResumed?.call();
    });
  }

  @override
  void dispose() {
    _overviewScrollController.dispose();
    _detailsScrollController.dispose();
    WidgetsBinding.instance.removeObserver(_widgetEventHandler);
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
        elevation: 1,
        shadowColor: Colors.grey.withOpacity(0.25),
        title: Row(
          children: [
            Image.asset("assets/images/logo.png", height: 40),
            const SizedBox(width: 10),
            Expanded(
              child: Observer(
                builder: (_) {
                  if (controller.user == null) {
                    return TextButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed(AuthPage.routeName),
                      child: Text(
                        AppLocalizations.of(context)!.authPageLoginTitle,
                      ),
                    );
                  } else {
                    return Text(
                      AppLocalizations.of(context)!
                          .hiUser(controller.user?.shortName ?? '')
                          .replaceAll(', .', ''),
                    );
                  }
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
          ).animate().rotate(duration: const Duration(milliseconds: 300)),
        ],
      ),
      body: SafeArea(
        child: AnimatedSize(
          curve: Curves.ease,
          duration: const Duration(milliseconds: 300),
          child: Column(
            children: [
              Expanded(
                child: Observer(
                  builder: (_) {
                    if (widget.controller.isLoading) {
                      return const Center(child: LoadingWidget());
                    }

                    if (widget.controller.loadUserDataError != null) {
                      return AppExceptionWidget(
                        error: widget.controller.loadUserDataError!,
                        onRetryCallback: widget.controller.loadUserData,
                      );
                    }

                    return switch (_currentPage) {
                      0 => _overviewTabContent,
                      1 => _detailsTabContent,
                      int() => const SizedBox(),
                    };
                  },
                ),
              ),
              Observer(
                builder: (_) {
                  if (controller.user?.data.subscription ==
                      SubscriptionEnum.freeWithAds) {
                    return const BannerAdWidget();
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
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
                        thisMonthProfitTotal: controller.thisMonthProfitTotal,
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
                    onPressed: () {
                      if (controller.user == null) {
                        Navigator.of(context).pushNamed(AuthPage.routeName);
                        return;
                      }

                      Navigator.of(context).pushNamed(
                        ManageMyInvestmentsPage.routeName,
                        arguments: true,
                      );
                    },
                    icon: const Icon(CupertinoIcons.chart_bar),
                    label: Text(
                      AppLocalizations.of(context)!.addNewInvestment,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      if (controller.user == null) {
                        Navigator.of(context).pushNamed(AuthPage.routeName);
                        return;
                      }

                      Navigator.of(context).pushNamed(
                        ManageMyOperationsPage.routeName,
                        arguments: true,
                      );
                    },
                    icon: const Icon(CupertinoIcons.arrow_up_arrow_down),
                    label: Text(
                      AppLocalizations.of(context)!.addNewOperation,
                    ),
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
                  // TextButton(
                  //   onPressed: () => Navigator.of(context)
                  //       .pushNamed(ManageMyInvestmentsPage.routeName),
                  //   child:
                  //       Text(AppLocalizations.of(context)!.accessMyInvestments),
                  // ),
                ],
              ),
              SectionWidget(
                title: AppLocalizations.of(context)!.myGoals,
                content: [
                  Observer(
                    builder: (_) {
                      final bool hasData = controller.goals.isNotEmpty;

                      return SizedBox(
                        height: hasData
                            ? MediaQuery.of(context).textScaler.scale(150)
                            : null,
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
                            children: controller.goals.map((e) {
                              return GoalTileWidget(goal: e).animate().fade(
                                    duration: const Duration(milliseconds: 400),
                                  );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      if (controller.user == null) {
                        Navigator.of(context).pushNamed(AuthPage.routeName);
                        return;
                      }

                      Navigator.of(context)
                          .pushNamed(ManageMyGoalsPage.routeName);
                    },
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
                    onPressed: controller.toggleHideValues,
                    visualDensity: VisualDensity.compact,
                    icon: controller.hideValues
                        ? const Icon(CupertinoIcons.eye_slash)
                        : const Icon(CupertinoIcons.eye),
                  ),
                ],
                content: [
                  Observer(builder: (_) {
                    final bool hasData = controller.investments.isNotEmpty;

                    return SizedBox(
                      height: hasData
                          ? MediaQuery.of(context).textScaler.scale(190)
                          : null,
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
                          children: controller.investments.map((e) {
                            return InvestmentTileWidget(
                              investment: e,
                              hideValues: controller.hideValues,
                            ).animate().fade(
                                  duration: const Duration(milliseconds: 400),
                                );
                          }).toList(),
                        ),
                      ),
                    );
                  }),
                  TextButton(
                    onPressed: () {
                      if (controller.user == null) {
                        Navigator.of(context).pushNamed(AuthPage.routeName);
                        return;
                      }

                      Navigator.of(context)
                          .pushNamed(ManageMyInvestmentsPage.routeName);
                    },
                    child:
                        Text(AppLocalizations.of(context)!.accessMyInvestments),
                  ),
                ],
              ),
              SectionWidget(
                title: AppLocalizations.of(context)!.monthsOperations,
                content: [
                  Observer(
                    builder: (_) {
                      final bool hasData =
                          controller.thisMonthOperations.isNotEmpty;

                      return SizedBox(
                        height: hasData
                            ? MediaQuery.of(context).textScaler.scale(237)
                            : null,
                        child: Visibility(
                          visible: hasData,
                          replacement: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: AdviseMessageWidget(
                              message: AppLocalizations.of(context)!
                                  .emptyThisMonthOperations,
                            ),
                          ),
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: controller.thisMonthOperations.map((e) {
                              return OperationTileWidget(
                                operation: e,
                                investment: controller.investments.firstWhere(
                                  (i) => i.id == e.investmentId,
                                ),
                                hideValues: controller.hideValues,
                              ).animate().fade(
                                    duration: const Duration(milliseconds: 400),
                                  );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      if (controller.user == null) {
                        Navigator.of(context).pushNamed(AuthPage.routeName);
                        return;
                      }

                      Navigator.of(context).pushNamed(
                        ManageMyOperationsPage.routeName,
                      );
                    },
                    child:
                        Text(AppLocalizations.of(context)!.accessMyOperations),
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
                    icon: CupertinoIcons.doc_chart,
                    text: AppLocalizations.of(context)!.exportInvestmentReport,
                    onTap: () {
                      DialogWidget.show(
                        context,
                        title: AppLocalizations.of(context)!
                            .functionNotImplementedTitle,
                        message: AppLocalizations.of(context)!
                            .functionNotImplementedMessage,
                        actionType: DialogWidgetActionType.close,
                      );
                    },
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
