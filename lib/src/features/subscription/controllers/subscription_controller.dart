import 'dart:async';
import 'dart:io';

import 'package:in_app_purchase/in_app_purchase.dart';
// ignore: depend_on_referenced_packages
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher.dart';

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
  List<PurchaseDetails>? _purchases;

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

  void Function()? onPurchasePending;

  @action
  Future<void> initSubscriptions({
    required void Function() onPurchasePending,
  }) async {
    try {
      isLoading = true;
      error = null;
      this.onPurchasePending = onPurchasePending;

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

  PurchaseDetails? getPurchaseDetails(SubscriptionEnum? subscription) {
    if (subscription == null) return null;
    return _purchases?.where((purchase) {
      return purchase.productID == subscription.productId;
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

      final ProductDetails? productDetails = _products?.where((product) {
        return product.id == subscription.productId;
      }).firstOrNull;
      if (productDetails == null) {
        throw AppException(AppExceptionType.productNotFound);
      }

      final oldPurchaseDetails = getPurchaseDetails(user?.data.subscription);
      if (oldPurchaseDetails != null && Platform.isAndroid) {
        await InAppPurchase.instance.buyNonConsumable(
          purchaseParam: GooglePlayPurchaseParam(
            productDetails: productDetails,
            applicationUserName: user!.id,
            changeSubscriptionParam: ChangeSubscriptionParam(
              oldPurchaseDetails:
                  oldPurchaseDetails as GooglePlayPurchaseDetails,
            ),
          ),
        );
      } else {
        await InAppPurchase.instance.buyNonConsumable(
          purchaseParam: PurchaseParam(
            productDetails: productDetails,
            applicationUserName: user!.id,
          ),
        );
      }

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

  Future<void> restoreSubscription({bool force = false}) async {
    try {
      if (user == null) return;
      final now = DateTime.now();
      if (!force &&
          lastSubscriptionCheck != null &&
          now.difference(lastSubscriptionCheck!).inMinutes < 1) {
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

      InAppPurchase.instance.restorePurchases();
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
    _purchases = purchaseDetailsList;

    final activeProductDetails = purchaseDetailsList.where((purchase) {
      return purchase.status == PurchaseStatus.purchased ||
          purchase.status == PurchaseStatus.restored;
    }).firstOrNull;

    final activeSubscription = SubscriptionEnumExtension.fromProductId(
      activeProductDetails?.productID ?? '',
    );

    if (user?.data.subscription != activeSubscription) {
      if (activeProductDetails?.pendingCompletePurchase == true) {
        await InAppPurchase.instance.completePurchase(activeProductDetails!);
      }
      await _appController.changeUserData(
        user!.data.copyWith(subscription: activeSubscription),
      );
    }

    final PurchaseDetails? pendingPurchase = purchaseDetailsList
        .where((purchase) => purchase.status == PurchaseStatus.pending)
        .firstOrNull;
    if (pendingPurchase != null) onPurchasePending?.call();
  }

  Future<void> _purchaseStreamListener(
    List<PurchaseDetails> purchaseDetailsList,
  ) async {
    _purchases = purchaseDetailsList;

    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.purchased) {
        final subscription = SubscriptionEnumExtension.fromProductId(
          purchaseDetails.productID,
        );
        await _appController.changeUserData(
          user!.data.copyWith(subscription: subscription),
        );
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchase.instance.completePurchase(purchaseDetails);
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

      if (purchaseDetails.status == PurchaseStatus.canceled) {
        onPurchaseError?.call(null);
        return;
      }

      if (purchaseDetails.status == PurchaseStatus.pending) {
        onPurchasePending?.call();
        return;
      }
    }
  }

  Future<void> openSubscriptionsManager() async {
    try {
      final Uri url;
      if (Platform.isAndroid) {
        url = Uri.parse('https://play.google.com/store/account/subscriptions');
      } else if (Platform.isIOS) {
        url = Uri.parse('itms-apps://apps.apple.com/account/subscriptions');
      } else {
        return;
      }
      await launchUrl(url, mode: LaunchMode.externalApplication);
      await Future.delayed(const Duration(seconds: 1));
      await restoreSubscription(force: true);
    } catch (_) {}
  }
}
