import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../../core/enums/subscription_enum.dart';
import '../../../core/exceptions/app_exception.dart';
import '../../../core/widgets/dialog_widget.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../l10n/l10n.dart';
import '../controllers/subscription_controller.dart';

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
    widget.controller.verifySubscriptionStatus().then((_) {
      widget.controller.initSubscriptions();
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
      await widget.controller.purchaseSubscription(subscription);
      if (widget.controller.user?.data.subscription == subscription) {
        if (!mounted) return;
        await DialogWidget.show(
          context,
          title: AppLocalizations.of(context)!.success,
          message: AppLocalizations.of(context)!.planUpdated,
          actionType: DialogWidgetActionType.close,
        );

        if (!mounted) return;
        LoadingWidget.hide(context);
        Navigator.of(context).pop();
        return;
      }

      if (mounted) LoadingWidget.hide(context);
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
                onRetryCallback: () => widget.controller.initSubscriptions(),
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
                        final subscription =
                            widget.controller.availableSubscriptions[index];
                        return _buildSubscriptionCard(subscription);
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

  Widget _buildSubscriptionCard(SubscriptionEnum subscription) {
    final bool isSelected =
        widget.controller.user?.data.subscription == subscription;
    final bool isFree = subscription == SubscriptionEnum.free;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      elevation: isSelected ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isSelected
            ? BorderSide(color: Theme.of(context).primaryColor, width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _handleSubscriptionSelection(subscription),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    subscription.getTitle(context),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  if (isSelected)
                    Icon(
                      Icons.check_circle,
                      color: Theme.of(context).primaryColor,
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                _getSubscriptionFeatures(subscription),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.color
                          ?.withValues(alpha: 0.8),
                    ),
              ),
              if (!isFree && subscription != SubscriptionEnum.unlimited) ...[
                const SizedBox(height: 12),
                Text(
                  _getSubscriptionPrice(subscription),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _getSubscriptionFeatures(SubscriptionEnum subscription) {
    return switch (subscription) {
      SubscriptionEnum.free =>
        AppLocalizations.of(context)!.freeSubscriptionFeatures,
      SubscriptionEnum.monthly =>
        AppLocalizations.of(context)!.monthlySubscriptionFeatures,
      SubscriptionEnum.annual =>
        AppLocalizations.of(context)!.annualSubscriptionFeatures,
      SubscriptionEnum.unlimited =>
        AppLocalizations.of(context)!.monthlySubscriptionFeatures,
    };
  }

  String _getSubscriptionPrice(SubscriptionEnum subscription) {
    final ProductDetails? product =
        widget.controller.getProductForSubscription(subscription);
    if (product == null) return '';
    return product.price;
  }
}
