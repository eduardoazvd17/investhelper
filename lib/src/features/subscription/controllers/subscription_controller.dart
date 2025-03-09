import 'dart:async';

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
  SubscriptionControllerBase({
    required AppController appController,
  }) : _appController = appController {
    reaction(
      (_) => _appController.user,
      (user) => verifySubscriptionStatus(),
    );
    verifySubscriptionStatus();
  }

  final Map<SubscriptionEnum, String> _productIds = {
    SubscriptionEnum.monthly: 'investhelper_monthly_plan',
    SubscriptionEnum.annual: 'investhelper_annual_plan',
  };

  @observable
  StreamSubscription<List<PurchaseDetails>>? _subscription;

  @observable
  List<ProductDetails>? _products;

  @computed
  UserModel? get user => _appController.user;

  @observable
  bool isLoading = false;

  @observable
  AppException? error;

  @computed
  List<SubscriptionEnum> get availableSubscriptions {
    final subscriptions = List<SubscriptionEnum>.from(SubscriptionEnum.values);
    if (user?.data.subscription != SubscriptionEnum.unlimited) {
      subscriptions.remove(SubscriptionEnum.unlimited);
    }
    return subscriptions;
  }

  @action
  Future<void> initSubscriptions() async {
    error = null;
    isLoading = true;

    try {
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
    } on AppException catch (e) {
      error = e;
    } catch (e) {
      error = AppException();
    }
    isLoading = false;
  }

  @action
  Future<void> purchaseSubscription(SubscriptionEnum subscription) async {
    try {
      final String? productId = _productIds[subscription];
      if (productId == null) {
        throw AppException(AppExceptionType.productNotFound);
      }

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
    } catch (e) {
      rethrow;
    }
  }

  void _handlePurchaseUpdate(List<PurchaseDetails> purchaseDetailsList) {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        isLoading = true;
      } else {
        isLoading = false;

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
          subscription: subscription,
        ),
      );
    } on AppException catch (_) {
      rethrow;
    }
  }

  Future<void> verifySubscriptionStatus() async {
    try {
      if (_appController.user == null) return;

      final bool available = await InAppPurchase.instance.isAvailable();
      if (!available) return;

      final List<PurchaseDetails> purchases = await _getPurchases();
      final PurchaseDetails? activeSubscription = purchases
          .where((purchase) =>
              purchase.status == PurchaseStatus.purchased ||
              purchase.status == PurchaseStatus.restored)
          .firstOrNull;

      if (activeSubscription == null &&
              user?.data.subscription == SubscriptionEnum.monthly ||
          user?.data.subscription == SubscriptionEnum.annual) {
        await _appController.changeUserData(
          _appController.user!.data.copyWith(
            subscription: SubscriptionEnum.free,
          ),
        );
        return;
      }
    } catch (_) {}
  }

  Future<List<PurchaseDetails>> _getPurchases() async {
    final Completer<List<PurchaseDetails>> completer = Completer();
    late StreamSubscription subscription;
    subscription = InAppPurchase.instance.purchaseStream.listen(
      (purchases) {
        subscription.cancel();
        completer.complete(purchases);
      },
      onError: (error) {
        subscription.cancel();
        completer.complete([]);
      },
    );

    await InAppPurchase.instance.restorePurchases();
    return await completer.future;
  }

  SubscriptionEnum _getSubscriptionFromProductId(String productId) {
    return _productIds.entries.firstWhere((entry) {
      return entry.value == productId;
    }, orElse: () => const MapEntry(SubscriptionEnum.free, '')).key;
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
