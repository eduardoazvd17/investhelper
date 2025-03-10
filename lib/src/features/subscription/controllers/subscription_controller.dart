import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:mobx/mobx.dart';

import '../../../core/controllers/app_controller.dart';
import '../../../core/enums/subscription_enum.dart';
import '../../../core/exceptions/app_exception.dart';
import '../../../core/models/user_model.dart';
import '../../../features/investments/controllers/investments_controller.dart';

part 'subscription_controller.g.dart';

class SubscriptionController = SubscriptionControllerBase
    with _$SubscriptionController;

abstract class SubscriptionControllerBase with Store {
  final AppController _appController;
  final InvestmentsController _investmentsController;
  SubscriptionControllerBase({
    required AppController appController,
    required InvestmentsController investmentsController,
  })  : _appController = appController,
        _investmentsController = investmentsController {
    reaction(
      (_) => _appController.user,
      (user) => restoreSubscription(),
    );
    restoreSubscription();
  }

  @computed
  UserModel? get user => _appController.user;

  @computed
  List<SubscriptionEnum> get availableSubscriptions {
    final subscriptions = List<SubscriptionEnum>.from(SubscriptionEnum.values);
    if (user?.data.subscription != SubscriptionEnum.unlimited) {
      subscriptions.remove(SubscriptionEnum.unlimited);
    }
    return subscriptions;
  }

  @computed
  bool get hasReachedFreeLimit =>
      !_investmentsController.canAddMoreInvestments &&
      _investmentsController.investments.length >= 3;

  @observable
  List<ProductDetails>? _products;

  @observable
  StreamSubscription<List<PurchaseDetails>>? _streamSubscription;

  @observable
  bool isLoading = false;

  @observable
  AppException? error;

  @observable
  DateTime? lastSubscriptionCheck;

  void Function(SubscriptionEnum)? onPurchaseSuccess;

  void Function(AppException?)? onPurchaseError;

  @action
  Future<void> initSubscriptions() async {
    try {
      isLoading = true;
      error = null;

      final bool available = await InAppPurchase.instance.isAvailable();
      if (!available) {
        throw AppException(AppExceptionType.storeNotAvailable);
      }

      _startListeningPurchases();

      final ProductDetailsResponse response =
          await InAppPurchase.instance.queryProductDetails(
        SubscriptionEnumExtension.productIds.values.toSet(),
      );

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

  void stopListeningPurchases() => _streamSubscription?.cancel();

  ProductDetails? getProductDetails(SubscriptionEnum subscription) {
    return _products?.where((product) {
      return product.id == subscription.productId;
    }).firstOrNull;
  }

  @action
  Future<void> purchaseSubscription(
    SubscriptionEnum subscription, {
    required void Function(SubscriptionEnum) onPurchaseSuccess,
    required void Function(AppException?) onPurchaseError,
  }) async {
    try {
      _appController.disableAuthOverlay = true;
      _appController.disableBlurOverlay = true;

      this.onPurchaseSuccess = onPurchaseSuccess;
      this.onPurchaseError = onPurchaseError;

      final ProductDetails? product = _products?.where((product) {
        return product.id == subscription.productId;
      }).firstOrNull;
      if (product == null) throw AppException(AppExceptionType.productNotFound);

      await InAppPurchase.instance.buyNonConsumable(
        purchaseParam: PurchaseParam(productDetails: product),
      );

      _appController.disableAuthOverlay = false;
      _appController.disableBlurOverlay = false;
    } on AppException catch (_) {
      _appController.disableAuthOverlay = false;
      _appController.disableBlurOverlay = false;
      rethrow;
    } catch (e) {
      _appController.disableAuthOverlay = false;
      _appController.disableBlurOverlay = false;
      throw AppException(AppExceptionType.purchaseError, e.toString());
    }
  }

  Future<void> restoreSubscription() async {
    try {
      if (user == null) return;
      final now = DateTime.now();
      if (lastSubscriptionCheck != null &&
          now.difference(lastSubscriptionCheck!).inHours < 1) {
        return;
      }
      lastSubscriptionCheck = now;

      final bool available = await InAppPurchase.instance.isAvailable();
      if (!available) return;

      late StreamSubscription subscription;
      subscription = InAppPurchase.instance.purchaseStream.listen(
        (data) {
          _restorePurchasesStreamListener(data);
          subscription.cancel();
        },
        onDone: () => subscription.cancel(),
        onError: (_) => subscription.cancel(),
      );
    } catch (_) {}
  }

  void _startListeningPurchases() {
    _streamSubscription?.cancel();
    _streamSubscription = InAppPurchase.instance.purchaseStream.listen(
      _purchaseStreamListener,
      onDone: () => _startListeningPurchases(),
      onError: (error) => _startListeningPurchases(),
    );
  }

  Future<void> _restorePurchasesStreamListener(
    List<PurchaseDetails> purchaseDetailsList,
  ) async {
    final PurchaseDetails? activeSubscription = purchaseDetailsList
        .where((purchase) =>
            purchase.status == PurchaseStatus.purchased ||
            purchase.status == PurchaseStatus.restored)
        .firstOrNull;

    if (activeSubscription == null) {
      await _appController.changeUserData(
        user!.data.copyWith(subscription: SubscriptionEnum.free),
      );
    }
  }

  Future<void> _purchaseStreamListener(
    List<PurchaseDetails> purchaseDetailsList,
  ) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.purchased) {
        final subscription = SubscriptionEnumExtension.fromProductId(
          purchaseDetails.productID,
        );
        await _appController.changeUserData(
          user!.data.copyWith(subscription: subscription),
        );
        if (purchaseDetails.pendingCompletePurchase) {
          InAppPurchase.instance.completePurchase(purchaseDetails);
        }
        onPurchaseSuccess?.call(subscription);
        return;
      }

      if (purchaseDetails.status == PurchaseStatus.error) {
        onPurchaseError?.call(
          AppException(
            AppExceptionType.purchaseError,
            purchaseDetails.error?.toString(),
          ),
        );
        return;
      }
    }
  }
}
