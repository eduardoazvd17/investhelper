import 'dart:io';

import 'package:flutter/material.dart';
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
  final List<SubscriptionEnum> _availableSubscriptions = [
    SubscriptionEnum.free,
    SubscriptionEnum.monthly,
    SubscriptionEnum.annual,
  ];

  @override
  void initState() {
    super.initState();
    _initSubscriptions();
  }

  Future<void> _initSubscriptions() async {
    try {
      await widget.controller.initSubscriptions();
    } catch (e) {
      if (!mounted) return;
      await DialogWidget.show(
        context,
        title: AppLocalizations.of(context)!.error,
        message: e.toString(),
        actionType: DialogWidgetActionType.close,
      );
    }
  }

  Future<void> _handleSubscriptionSelection(
      SubscriptionEnum subscription) async {
    if (subscription == SubscriptionEnum.free) {
      Navigator.of(context).pop();
      return;
    }

    try {
      LoadingWidget.dialog(context);
      await widget.controller.purchaseSubscription(subscription);
      if (!mounted) return;
      LoadingWidget.hide(context);
      Navigator.of(context).pop();
    } on AppException catch (e) {
      if (!mounted) return;
      LoadingWidget.hide(context);
      await e.show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.subscription),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppLocalizations.of(context)!.chooseYourPlan,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: _availableSubscriptions.length,
                  itemBuilder: (context, index) {
                    final subscription = _availableSubscriptions[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 4,
                      ),
                      child: ListTile(
                        title: Text(subscription.getTitle(context)),
                        subtitle: Text(_getSubscriptionFeatures(subscription)),
                        trailing: subscription == SubscriptionEnum.free
                            ? const Icon(Icons.check)
                            : Text(
                                _getSubscriptionPrice(subscription),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                        onTap: () => _handleSubscriptionSelection(subscription),
                      ),
                    );
                  },
                ),
              ),
              if (Platform.isIOS) ...[
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.iosSubscriptionDisclaimer,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
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
      _ => '',
    };
  }

  String _getSubscriptionPrice(SubscriptionEnum subscription) {
    final ProductDetails? product =
        widget.controller.getProductForSubscription(subscription);
    if (product == null) return '';
    return product.price;
  }
}
