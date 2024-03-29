import 'package:flutter/material.dart';
import 'package:investhelper/src/l10n/l10n.dart';

/// GENERIC
class AppException implements Exception {
  final AppExceptionType type;
  AppException([this.type = AppExceptionType.generic]);

  Future<void> show(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(type.title(context)),
          content: Text(type.message(context)),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: Text(AppLocalizations.of(context)!.close),
            ),
          ],
        );
      },
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
    };
  }
}
