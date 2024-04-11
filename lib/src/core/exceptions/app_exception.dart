import 'package:flutter/material.dart';
import 'package:investhelper/src/l10n/l10n.dart';

import '../widgets/dialog_widget.dart';

class AppException implements Exception {
  final AppExceptionType type;
  AppException([this.type = AppExceptionType.generic, String? exception]) {
    if (exception != null) {
      debugPrint('[AppExcepion] $exception');
    }
  }

  Future<void> show(BuildContext context) async {
    await DialogWidget.show(
      context,
      title: type.title(context),
      message: type.message(context),
      actionType: DialogWidgetActionType.close,
    );
  }
}

enum AppExceptionType {
  generic,
  emptyFields,
  incorrectUserOrPassword,
  userAlreadyExists,
  invalidEmail,
  invalidPassword,
  passwordsDontMatch,
  invalidRecoveryEmail,
  connectionError,
}

extension AppExceptionTypeExtension on AppExceptionType {
  String title(BuildContext context) {
    return switch (this) {
      AppExceptionType.generic =>
        AppLocalizations.of(context)!.genericErrorTitle,
      AppExceptionType.emptyFields =>
        AppLocalizations.of(context)!.emptyFieldsErrorTitle,
      AppExceptionType.incorrectUserOrPassword =>
        AppLocalizations.of(context)!.incorrectUserOrPasswordErrorTitle,
      AppExceptionType.userAlreadyExists =>
        AppLocalizations.of(context)!.userAlreadyExistsErrorTitle,
      AppExceptionType.invalidEmail =>
        AppLocalizations.of(context)!.invalidEmailErrorTitle,
      AppExceptionType.invalidPassword =>
        AppLocalizations.of(context)!.invalidPasswordErrorTitle,
      AppExceptionType.passwordsDontMatch =>
        AppLocalizations.of(context)!.passwordsDontMatchErrorTitle,
      AppExceptionType.invalidRecoveryEmail =>
        AppLocalizations.of(context)!.invalidRecoveryEmailErrorTitle,
      AppExceptionType.connectionError =>
        AppLocalizations.of(context)!.connectionErrorTitle,
    };
  }

  String message(BuildContext context) {
    return switch (this) {
      AppExceptionType.generic =>
        AppLocalizations.of(context)!.genericErrorMessage,
      AppExceptionType.emptyFields =>
        AppLocalizations.of(context)!.emptyFieldsErrorMessage,
      AppExceptionType.incorrectUserOrPassword =>
        AppLocalizations.of(context)!.incorrectUserOrPasswordErrorMessage,
      AppExceptionType.userAlreadyExists =>
        AppLocalizations.of(context)!.userAlreadyExistsErrorMessage,
      AppExceptionType.invalidEmail =>
        AppLocalizations.of(context)!.invalidEmailErrorMessage,
      AppExceptionType.invalidPassword =>
        AppLocalizations.of(context)!.invalidPasswordErrorMessage,
      AppExceptionType.passwordsDontMatch =>
        AppLocalizations.of(context)!.passwordsDontMatchErrorMessage,
      AppExceptionType.invalidRecoveryEmail =>
        AppLocalizations.of(context)!.invalidRecoveryEmailErrorMessage,
      AppExceptionType.connectionError =>
        AppLocalizations.of(context)!.connectionErrorMessage,
    };
  }
}
