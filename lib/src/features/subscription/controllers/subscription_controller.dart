import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:mobx/mobx.dart';

import '../../../core/controllers/app_controller.dart';
import '../../../core/enums/subscription_enum.dart';
import '../../../core/exceptions/app_exception.dart';

part 'subscription_controller.g.dart';

class SubscriptionController = SubscriptionControllerBase
    with _$SubscriptionController;

abstract class SubscriptionControllerBase with Store {
  final AppController _appController;
  final Map<SubscriptionEnum, String> _productIds = {
    SubscriptionEnum.monthly: 'investhelper_monthly_subscription',
    SubscriptionEnum.annual: 'investhelper_annual_subscription',
  };

  StreamSubscription<List<PurchaseDetails>>? _subscription;
  List<ProductDetails>? _products;

  SubscriptionControllerBase({
    required AppController appController,
  }) : _appController = appController;

  @action
  Future<void> initSubscriptions() async {
    final bool available = await InAppPurchase.instance.isAvailable();
    if (!available) {
      throw AppException(AppExceptionType.storeNotAvailable);
    }

    _subscription ??= InAppPurchase.instance.purchaseStream.listen(
      _handlePurchaseUpdate,
      onDone: () => _subscription?.cancel(),
      onError: (error) => throw AppException(
        AppExceptionType.purchaseError,
        error.toString(),
      ),
    );

    final Set<String> ids = _productIds.values.toSet();
    final ProductDetailsResponse response =
        await InAppPurchase.instance.queryProductDetails(ids);

    if (response.error != null) {
      throw AppException(
        AppExceptionType.productNotFound,
        response.error.toString(),
      );
    }

    if (response.productDetails.isEmpty) {
      throw AppException(AppExceptionType.productNotFound);
    }

    _products = response.productDetails;
  }

  Future<void> purchaseSubscription(SubscriptionEnum subscription) async {
    final String? productId = _productIds[subscription];
    if (productId == null) return;

    final ProductDetails? product = _products?.firstWhere(
      (product) => product.id == productId,
    );

    if (product == null) {
      throw AppException(AppExceptionType.productNotFound);
    }

    final PurchaseParam purchaseParam = PurchaseParam(
      productDetails: product,
    );

    await InAppPurchase.instance.buyNonConsumable(
      purchaseParam: purchaseParam,
    );
  }

  void _handlePurchaseUpdate(List<PurchaseDetails> purchaseDetailsList) {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        throw AppException(AppExceptionType.purchasePending);
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          throw AppException(
            AppExceptionType.purchaseError,
            purchaseDetails.error?.toString(),
          );
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          _verifyPurchase(purchaseDetails);
        }

        if (purchaseDetails.pendingCompletePurchase) {
          InAppPurchase.instance.completePurchase(purchaseDetails);
        }
      }
    }
  }

  Future<void> _verifyPurchase(PurchaseDetails purchaseDetails) async {
    try {
      final SubscriptionEnum subscription = _getSubscriptionFromProductId(
        purchaseDetails.productID,
      );

      await _appController.changeUserData(
        _appController.user!.data.copyWith(
          subscriptionStartDate: DateTime.now(),
          subscription: subscription,
          subscriptionEndDate: DateTime.now().add(
            subscription == SubscriptionEnum.monthly
                ? const Duration(days: 30)
                : const Duration(days: 365),
          ),
        ),
      );
    } on AppException catch (_) {
      rethrow;
    }
  }

  SubscriptionEnum _getSubscriptionFromProductId(String productId) {
    return _productIds.entries
        .firstWhere(
          (entry) => entry.value == productId,
          orElse: () => const MapEntry(
            SubscriptionEnum.free,
            '',
          ),
        )
        .key;
  }

  ProductDetails? getProductForSubscription(SubscriptionEnum subscription) {
    final String? productId = _productIds[subscription];
    if (productId == null) return null;

    try {
      return _products?.firstWhere(
        (product) => product.id == productId,
      );
    } catch (_) {
      return null;
    }
  }
}
