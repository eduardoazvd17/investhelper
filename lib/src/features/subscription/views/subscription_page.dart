import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/enums/subscription_enum.dart';
import '../../../core/exceptions/app_exception.dart';
import '../../../core/widgets/dialog_widget.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../l10n/l10n.dart';
import '../controllers/subscription_controller.dart';
import '../widgets/subscription_widget.dart';

class SubscriptionPage extends StatefulWidget {
  static const String routeName = "/subscription";
  final SubscriptionController controller;

  const SubscriptionPage({super.key, required this.controller});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  @override
  void initState() {
    widget.controller.isLoading = true;
    widget.controller.lastSubscriptionCheck = null;
    super.initState();

    widget.controller.restoreSubscription().then((_) {
      widget.controller.initSubscriptions(
        onPurchasePending: _onPurchasePending,
      );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted &&
          widget.controller.user?.data.subscription ==
              SubscriptionEnum.unlimited) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    widget.controller.stopListeningPurchases();
    super.dispose();
  }

  Future<void> _onPurchaseSuccess(SubscriptionEnum subscription) async {
    await Future.delayed(const Duration(seconds: 1));

    if (widget.controller.user?.data.subscription == subscription) {
      if (!mounted) return;
      await DialogWidget.show(
        context,
        title: AppLocalizations.of(context)!.success,
        message: AppLocalizations.of(context)!.planUpdated,
        actionType: DialogWidgetActionType.close,
      );

      if (!mounted) return;
      Navigator.of(context).popUntil((route) {
        return route.settings.name == SubscriptionPage.routeName;
      });
      Navigator.of(context).pop();
    }
  }

  Future<void> _onPurchaseError(AppException? error) async {
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    Navigator.of(context).popUntil((route) {
      return route.settings.name == SubscriptionPage.routeName;
    });
    error?.show(context);
  }

  Future<void> _onPurchasePending() async {
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    await DialogWidget.show(
      context,
      title: AppLocalizations.of(context)!.subscriptionProcessingTitle,
      message: AppLocalizations.of(context)!.subscriptionProcessingMessage,
      actionType: DialogWidgetActionType.close,
    );

    if (!mounted) return;
    Navigator.of(context).popUntil((route) {
      return route.settings.name == SubscriptionPage.routeName;
    });
    Navigator.of(context).pop();
  }

  Future<void> _onTapSubscription(
    SubscriptionEnum subscription,
    bool currentIsAutoRenewing,
  ) async {
    final userData = widget.controller.user?.data;
    final currentSubscription = userData?.subscription;

    if (subscription == SubscriptionEnum.free && currentIsAutoRenewing) {
      final bool? shouldRedirect = await DialogWidget.show(
        context,
        title: AppLocalizations.of(context)!.cancelSubscriptionTitle,
        message:
            '${AppLocalizations.of(context)!.cancelSubscriptionConfirmation}\n\n${Platform.isIOS ? AppLocalizations.of(context)!.cancelSubscriptionRedirectIOS : AppLocalizations.of(context)!.cancelSubscriptionRedirectAndroid}',
        actionType: DialogWidgetActionType.yesOrNo,
      );
      if (shouldRedirect == true) widget.controller.openSubscriptionsManager();
      return;
    }

    if (subscription != SubscriptionEnum.free &&
        currentSubscription == subscription &&
        !currentIsAutoRenewing) {
      widget.controller.openSubscriptionsManager();
      return;
    }

    if (!mounted) return;
    if (currentSubscription == subscription) return;
    if (subscription == SubscriptionEnum.free) return;

    try {
      LoadingWidget.dialog(context);
      await widget.controller.purchaseSubscription(
        subscription,
        onPurchaseSuccess: _onPurchaseSuccess,
        onPurchaseError: _onPurchaseError,
      );
    } on AppException catch (e) {
      if (!mounted) return;
      LoadingWidget.hide(context);
      e.show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.subscription),
      ),
      body: SafeArea(
        child: Observer(
          builder: (_) {
            if (widget.controller.isLoading) {
              return const Center(child: LoadingWidget());
            }

            if (widget.controller.error != null) {
              return AppExceptionWidget(
                error: widget.controller.error!.type,
                onRetryCallback: () => widget.controller.initSubscriptions(
                  onPurchasePending: _onPurchasePending,
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    AppLocalizations.of(context)!.chooseYourPlan,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.choosePlanDescription,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.color
                              ?.withValues(alpha: 0.7),
                        ),
                    textAlign: TextAlign.center,
                  ),
                  if (widget.controller.hasReachedFreeLimit) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.freePlanLimitWarning,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.builder(
                      itemCount:
                          widget.controller.availableSubscriptions.length,
                      itemBuilder: (context, index) {
                        final SubscriptionEnum subscription =
                            widget.controller.availableSubscriptions[index];

                        return SubscriptionWidget(
                          currentSubscription:
                              widget.controller.user?.data.subscription,
                          currentSubscriptionPurchaseDetails:
                              widget.controller.getPurchaseDetails(
                            widget.controller.user?.data.subscription,
                          ),
                          subscription: subscription,
                          productDetails: widget.controller.getProductDetails(
                            subscription,
                          ),
                          onTap: _onTapSubscription,
                        );
                      },
                    ),
                  ),
                  if (Platform.isIOS) ...[
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.iosSubscriptionDisclaimer,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.color
                                ?.withValues(alpha: 0.7),
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
