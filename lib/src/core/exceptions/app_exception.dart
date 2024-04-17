import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import '../../l10n/l10n.dart';

import '../widgets/dialog_widget.dart';

class AppException implements Exception {
  final AppExceptionType type;
  AppException([this.type = AppExceptionType.generic, String? exception]) {
    if (exception != null) {
      developer.log(
        exception,
        name: 'AppExcepion',
        time: DateTime.now(),
      );
    }
  }

  Future<void> show(BuildContext context) async {
    await DialogWidget.show(
      context,
      title: type.getTitle(context),
      message: type.getMessage(context),
      actionType: DialogWidgetActionType.close,
    );
  }
}

class AppExceptionWidget extends StatelessWidget {
  final AppExceptionType error;
  final void Function() onRetryCallback;
  const AppExceptionWidget({
    super.key,
    required this.error,
    required this.onRetryCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              error.getTitle(context),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 2.5),
            Text(
              error.getMessage(context),
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 10),
            TextButton.icon(
              onPressed: onRetryCallback,
              icon: const Icon(Icons.refresh),
              label: Text(AppLocalizations.of(context)!.tryAgain),
            ),
          ],
        ),
      ),
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
  invalidValue,
}

extension AppExceptionTypeExtension on AppExceptionType {
  String getTitle(BuildContext context) {
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
      AppExceptionType.invalidValue =>
        AppLocalizations.of(context)!.invalidValueErrorTitle,
    };
  }

  String getMessage(BuildContext context) {
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
      AppExceptionType.invalidValue =>
        AppLocalizations.of(context)!.invalidValueErrorMessage,
    };
  }
}
