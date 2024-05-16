import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';

class DialogWidget extends StatelessWidget {
  final String title;
  final String message;
  final Widget? messageWidget;
  final List<TextButton>? actions;
  const DialogWidget({
    super.key,
    required this.title,
    required this.message,
    this.messageWidget,
    this.actions,
  });

  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String message,
    Widget? messageWidget,
    required DialogWidgetActionType actionType,
  }) async {
    return await showDialog<bool?>(
      context: context,
      builder: (_) {
        return DialogWidget(
          title: title,
          message: message,
          messageWidget: messageWidget,
          actions: switch (actionType) {
            DialogWidgetActionType.close => [
                TextButton(
                  onPressed: Navigator.of(context).pop,
                  child: Text(AppLocalizations.of(context)!.close),
                )
              ],
            DialogWidgetActionType.yesOrNo => [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.error),
                  ),
                  child: Text(AppLocalizations.of(context)!.yes),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(AppLocalizations.of(context)!.no),
                ),
              ],
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message),
          if (messageWidget != null)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: messageWidget!,
            ),
        ],
      ),
      actions: actions ??
          [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: Text(AppLocalizations.of(context)!.close),
            ),
          ],
    );
  }
}

enum DialogWidgetActionType {
  close,
  yesOrNo,
}
