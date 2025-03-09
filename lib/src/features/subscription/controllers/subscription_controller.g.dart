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

  late final _$initSubscriptionsAsyncAction = AsyncAction(
      'SubscriptionControllerBase.initSubscriptions',
      context: context);

  @override
  Future<void> initSubscriptions() {
    return _$initSubscriptionsAsyncAction.run(() => super.initSubscriptions());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
error: ${error},
user: ${user},
availableSubscriptions: ${availableSubscriptions}
    ''';
  }
}
