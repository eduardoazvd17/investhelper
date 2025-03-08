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

  bool _isLoading = true;
  AppException? _error;

  @override
  void initState() {
    super.initState();
    _initSubscriptions();
  }

  Future<void> _initSubscriptions() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      await widget.controller.initSubscriptions();

      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _error = AppException();
      });
    }
  }

  Future<void> _handleSubscriptionSelection(
    SubscriptionEnum subscription,
  ) async {
    if (subscription == SubscriptionEnum.free) {
      Navigator.of(context).pop();
      return;
    }

    try {
      LoadingWidget.dialog(context);
      await widget.controller.purchaseSubscription(subscription);
      if (!mounted) return;
      LoadingWidget.hide(context);

      await DialogWidget.show(
        context,
        title: AppLocalizations.of(context)!.success,
        message: AppLocalizations.of(context)!.planUpdated,
        actionType: DialogWidgetActionType.close,
      );

      if (!mounted) return;
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
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: LoadingWidget());
    }

    if (_error != null) {
      return AppExceptionWidget(
        error: _error!.type,
        onRetryCallback: _initSubscriptions,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
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
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              itemCount: _availableSubscriptions.length,
              itemBuilder: (context, index) {
                final subscription = _availableSubscriptions[index];
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
                        ?.withOpacity(0.7),
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSubscriptionCard(SubscriptionEnum subscription) {
    final bool isSelected =
        widget.controller.user?.data.subscription == subscription;

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
                          ?.withOpacity(0.8),
                    ),
              ),
              if (subscription != SubscriptionEnum.free) ...[
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
