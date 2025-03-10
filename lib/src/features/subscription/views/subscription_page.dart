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
    super.initState();
    widget.controller.isLoading = true;
    widget.controller.lastSubscriptionCheck = null;
    widget.controller.restoreSubscription().then((_) {
      widget.controller.initSubscriptions(
        onPurchasePending: _onPurchasePending,
      );
    });
  }

  @override
  void dispose() {
    widget.controller.stopListeningPurchases();
    super.dispose();
  }

  void _onPurchasePending() {
    DialogWidget.show(
      context,
      title: AppLocalizations.of(context)!.subscriptionProcessingTitle,
      message: AppLocalizations.of(context)!.subscriptionProcessingMessage,
      actionType: DialogWidgetActionType.close,
    ).then((_) {
      if (mounted) {
        Navigator.of(context).popUntil((route) {
          return route.settings.name == SubscriptionPage.routeName;
        });
        Navigator.of(context).pop();
      }
    });
  }

  Future<void> _handleSubscriptionSelection(
    SubscriptionEnum subscription,
  ) async {
    final userData = widget.controller.user?.data;
    final currentSubscription = userData?.subscription;
    if (currentSubscription == subscription) return;

    if (subscription == SubscriptionEnum.free) {
      DialogWidget.show(
        context,
        title: AppLocalizations.of(context)!.cancelSubscriptionTitle,
        message: Platform.isIOS
            ? AppLocalizations.of(context)!.iosSubscriptionDisclaimer
            : AppLocalizations.of(context)!.androidSubscriptionDisclaimer,
        actionType: DialogWidgetActionType.close,
      );
      return;
    }

    try {
      LoadingWidget.dialog(context);
      await widget.controller.purchaseSubscription(
        subscription,
        onPurchaseSuccess: (SubscriptionEnum subscription) {
          if (mounted &&
              widget.controller.user?.data.subscription == subscription) {
            DialogWidget.show(
              context,
              title: AppLocalizations.of(context)!.success,
              message: AppLocalizations.of(context)!.planUpdated,
              actionType: DialogWidgetActionType.close,
            ).then((_) {
              if (!mounted) return;
              LoadingWidget.hide(context);
              Navigator.of(context).pop();
              return;
            });
          }
        },
        onPurchaseError: (AppException? error) {
          if (!mounted) return;
          LoadingWidget.hide(context);
          error?.show(context);
        },
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
                          subscription: subscription,
                          productDetails:
                              widget.controller.getProductDetails(subscription),
                          isSelected:
                              widget.controller.user?.data.subscription ==
                                  subscription,
                          onTap: _handleSubscriptionSelection,
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
