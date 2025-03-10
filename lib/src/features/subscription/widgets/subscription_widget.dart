import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
// ignore: depend_on_referenced_packages
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

import '../../../core/enums/subscription_enum.dart';

class SubscriptionWidget extends StatelessWidget {
  final SubscriptionEnum? currentSubscription;
  final PurchaseDetails? currentSubscriptionPurchaseDetails;
  final SubscriptionEnum subscription;
  final ProductDetails? productDetails;
  final void Function(SubscriptionEnum) onTap;

  const SubscriptionWidget({
    super.key,
    required this.currentSubscription,
    required this.currentSubscriptionPurchaseDetails,
    required this.subscription,
    required this.productDetails,
    required this.onTap,
  });

  bool get isAutoRenewing {
    if (currentSubscriptionPurchaseDetails is GooglePlayPurchaseDetails) {
      return (currentSubscriptionPurchaseDetails as GooglePlayPurchaseDetails)
          .billingClientPurchase
          .isAutoRenewing;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final bool isSelected = currentSubscription == subscription;

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
        onTap: () => onTap(subscription),
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
                subscription.getFeatures(context),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.color
                          ?.withValues(alpha: 0.8),
                    ),
              ),
              if (productDetails?.price != null) ...[
                const SizedBox(height: 12),
                Text(
                  productDetails!.price,
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
}
