import 'package:flutter/material.dart';
import 'package:investhelper/src/l10n/l10n.dart';

/// GENERIC
class AppException implements Exception {
  final AppExceptionType type;
  AppException([this.type = AppExceptionType.generic]);

  void show(BuildContext context) {
    showDialog(
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
  // TODO: Add all titles/messages.

  String title(BuildContext context) {
    return "Error";
  }

  String message(BuildContext context) {
    return toString();
  }
}
