// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SubscriptionController on SubscriptionControllerBase, Store {
  Computed<UserModel?>? _$userComputed;

  @override
  UserModel? get user =>
      (_$userComputed ??= Computed<UserModel?>(() => super.user,
              name: 'SubscriptionControllerBase.user'))
          .value;
  Computed<List<SubscriptionEnum>>? _$availableSubscriptionsComputed;

  @override
  List<SubscriptionEnum> get availableSubscriptions =>
      (_$availableSubscriptionsComputed ??= Computed<List<SubscriptionEnum>>(
              () => super.availableSubscriptions,
              name: 'SubscriptionControllerBase.availableSubscriptions'))
          .value;
  Computed<bool>? _$hasReachedFreeLimitComputed;

  @override
  bool get hasReachedFreeLimit => (_$hasReachedFreeLimitComputed ??=
          Computed<bool>(() => super.hasReachedFreeLimit,
              name: 'SubscriptionControllerBase.hasReachedFreeLimit'))
      .value;
  Computed<PurchaseDetails?>? _$currentSubscriptionPurchaseDetailsComputed;

  @override
  PurchaseDetails? get currentSubscriptionPurchaseDetails =>
      (_$currentSubscriptionPurchaseDetailsComputed ??= Computed<
                  PurchaseDetails?>(
              () => super.currentSubscriptionPurchaseDetails,
              name:
                  'SubscriptionControllerBase.currentSubscriptionPurchaseDetails'))
          .value;

  late final _$_productsAtom =
      Atom(name: 'SubscriptionControllerBase._products', context: context);

  @override
  List<ProductDetails>? get _products {
    _$_productsAtom.reportRead();
    return super._products;
  }

  @override
  set _products(List<ProductDetails>? value) {
    _$_productsAtom.reportWrite(value, super._products, () {
      super._products = value;
    });
  }

  late final _$_purchasesAtom =
      Atom(name: 'SubscriptionControllerBase._purchases', context: context);

  @override
  List<PurchaseDetails>? get _purchases {
    _$_purchasesAtom.reportRead();
    return super._purchases;
  }

  @override
  set _purchases(List<PurchaseDetails>? value) {
    _$_purchasesAtom.reportWrite(value, super._purchases, () {
      super._purchases = value;
    });
  }

  late final _$_streamSubscriptionAtom = Atom(
      name: 'SubscriptionControllerBase._streamSubscription', context: context);

  @override
  StreamSubscription<List<PurchaseDetails>>? get _streamSubscription {
    _$_streamSubscriptionAtom.reportRead();
    return super._streamSubscription;
  }

  @override
  set _streamSubscription(StreamSubscription<List<PurchaseDetails>>? value) {
    _$_streamSubscriptionAtom.reportWrite(value, super._streamSubscription, () {
      super._streamSubscription = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'SubscriptionControllerBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorAtom =
      Atom(name: 'SubscriptionControllerBase.error', context: context);

  @override
  AppException? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(AppException? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$lastSubscriptionCheckAtom = Atom(
      name: 'SubscriptionControllerBase.lastSubscriptionCheck',
      context: context);

  @override
  DateTime? get lastSubscriptionCheck {
    _$lastSubscriptionCheckAtom.reportRead();
    return super.lastSubscriptionCheck;
  }

  @override
  set lastSubscriptionCheck(DateTime? value) {
    _$lastSubscriptionCheckAtom.reportWrite(value, super.lastSubscriptionCheck,
        () {
      super.lastSubscriptionCheck = value;
    });
  }

  late final _$initSubscriptionsAsyncAction = AsyncAction(
      'SubscriptionControllerBase.initSubscriptions',
      context: context);

  @override
  Future<void> initSubscriptions({required void Function() onPurchasePending}) {
    return _$initSubscriptionsAsyncAction.run(
        () => super.initSubscriptions(onPurchasePending: onPurchasePending));
  }

  late final _$purchaseSubscriptionAsyncAction = AsyncAction(
      'SubscriptionControllerBase.purchaseSubscription',
      context: context);

  @override
  Future<void> purchaseSubscription(SubscriptionEnum subscription,
      {required void Function(SubscriptionEnum) onPurchaseSuccess,
      required void Function(AppException?) onPurchaseError}) {
    return _$purchaseSubscriptionAsyncAction.run(() => super
        .purchaseSubscription(subscription,
            onPurchaseSuccess: onPurchaseSuccess,
            onPurchaseError: onPurchaseError));
  }

  late final _$restoreSubscriptionAsyncAction = AsyncAction(
      'SubscriptionControllerBase.restoreSubscription',
      context: context);

  @override
  Future<void> restoreSubscription({bool force = false}) {
    return _$restoreSubscriptionAsyncAction
        .run(() => super.restoreSubscription(force: force));
  }

  late final _$openSubscriptionsManagerAsyncAction = AsyncAction(
      'SubscriptionControllerBase.openSubscriptionsManager',
      context: context);

  @override
  Future<void> openSubscriptionsManager() {
    return _$openSubscriptionsManagerAsyncAction
        .run(() => super.openSubscriptionsManager());
  }

  late final _$SubscriptionControllerBaseActionController =
      ActionController(name: 'SubscriptionControllerBase', context: context);

  @override
  void stopListeningPurchases() {
    final _$actionInfo = _$SubscriptionControllerBaseActionController
        .startAction(name: 'SubscriptionControllerBase.stopListeningPurchases');
    try {
      return super.stopListeningPurchases();
    } finally {
      _$SubscriptionControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  ProductDetails? getProductDetails(SubscriptionEnum subscription) {
    final _$actionInfo = _$SubscriptionControllerBaseActionController
        .startAction(name: 'SubscriptionControllerBase.getProductDetails');
    try {
      return super.getProductDetails(subscription);
    } finally {
      _$SubscriptionControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
error: ${error},
lastSubscriptionCheck: ${lastSubscriptionCheck},
user: ${user},
availableSubscriptions: ${availableSubscriptions},
hasReachedFreeLimit: ${hasReachedFreeLimit},
currentSubscriptionPurchaseDetails: ${currentSubscriptionPurchaseDetails}
    ''';
  }
}
