import 'dart:async';
import 'dart:io';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:mobx/mobx.dart';

import '../../../core/controllers/app_controller.dart';
import '../../../core/enums/subscription_enum.dart';
import '../../../core/exceptions/app_exception.dart';
import '../../../core/models/user_model.dart';

part 'subscription_controller.g.dart';

class SubscriptionController = SubscriptionControllerBase
    with _$SubscriptionController;

abstract class SubscriptionControllerBase with Store {
  final AppController _appController;
  final Map<SubscriptionEnum, String> _productIds = {
    SubscriptionEnum.monthly: 'investhelper_monthly_plan',
    SubscriptionEnum.annual: 'investhelper_annual_plan',
  };

  StreamSubscription<List<PurchaseDetails>>? _subscription;
  List<ProductDetails>? _products;

  SubscriptionControllerBase({
    required AppController appController,
  }) : _appController = appController {
    // Verify subscription status periodically
    Timer.periodic(const Duration(days: 1), (_) {
      verifySubscriptionStatus();
    });
  }

  @computed
  UserModel? get user => _appController.user;

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

    // Verify subscription status on initialization
    await verifySubscriptionStatus();
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

  Future<void> cancelSubscription() async {
    try {
      final subscription = _appController.user?.data.subscription;
      if (subscription == null || subscription == SubscriptionEnum.free) return;

      // Mark subscription for cancellation at the end of the current period
      // This is handled differently on iOS and Android
      if (Platform.isIOS) {
        // On iOS, we need to show the user how to cancel in Settings
        throw AppException(
          AppExceptionType.purchaseError,
          'To cancel your subscription, please go to Settings > Apple ID > Subscriptions',
        );
      } else {
        // On Android, we can cancel through the Play Store
        throw AppException(
          AppExceptionType.purchaseError,
          'To cancel your subscription, please go to the Google Play Store > Subscriptions',
        );
      }
    } on AppException catch (_) {
      rethrow;
    }
  }

  Future<void> verifySubscriptionStatus() async {
    try {
      if (_appController.user == null) return;

      final currentSubscription = _appController.user!.data.subscription;
      if (currentSubscription == SubscriptionEnum.free) return;

      final subscriptionEndDate = _appController.user!.data.subscriptionEndDate;
      if (subscriptionEndDate == null) return;

      // Check if subscription has expired
      if (DateTime.now().isAfter(subscriptionEndDate)) {
        await _appController.changeUserData(
          _appController.user!.data.copyWith(
            subscription: SubscriptionEnum.free,
            subscriptionStartDate: null,
            subscriptionEndDate: null,
          ),
        );
        return;
      }

      // Verify purchase status with store
      final String? productId = _productIds[currentSubscription];
      if (productId == null) return;

      final bool available = await InAppPurchase.instance.isAvailable();
      if (!available) return;

      // Get active purchases
      final Stream<List<PurchaseDetails>> purchaseStream =
          InAppPurchase.instance.purchaseStream;

      await for (final List<PurchaseDetails> purchases in purchaseStream) {
        final PurchaseDetails? subscription = purchases
            .where((purchase) => purchase.productID == productId)
            .firstOrNull;

        // If subscription not found or was refunded/cancelled, revert to free plan
        if (subscription == null ||
            subscription.status == PurchaseStatus.error ||
            subscription.status == PurchaseStatus.canceled) {
          await _appController.changeUserData(
            _appController.user!.data.copyWith(
              subscription: SubscriptionEnum.free,
              subscriptionStartDate: null,
              subscriptionEndDate: null,
            ),
          );
          break;
        }
      }
    } catch (_) {
      // Fail silently - will try again next time
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
