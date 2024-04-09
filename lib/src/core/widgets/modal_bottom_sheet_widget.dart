import 'package:flutter/material.dart';

class ModalBottomSheetWidget extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  final List<Widget> children;
  const ModalBottomSheetWidget({
    super.key,
    required this.title,
    required this.children,
    this.actions,
  });

  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    List<Widget>? actions,
    required List<Widget> children,
  }) async {
    return await showModalBottomSheet<T>(
      elevation: 0,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return GestureDetector(
          onTap: _hideKeyboard,
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).viewPadding.top,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              color: Theme.of(context).bottomSheetTheme.backgroundColor,
              child: ModalBottomSheetWidget(
                title: title,
                actions: actions,
                children: children,
              ),
            ),
          ),
        );
      },
    );
  }

  static void _hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: Container(
              width: 80,
              height: 3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const Divider(),
          Flexible(
            fit: FlexFit.tight,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(children: children),
              ),
            ),
          ),
          if (actions != null && actions!.isNotEmpty) ...[
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: actions!,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
