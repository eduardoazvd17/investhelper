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

  static show(
    BuildContext context, {
    required String title,
    List<Widget>? actions,
    required List<Widget> children,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return ModalBottomSheetWidget(
          title: title,
          actions: actions,
          children: children,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 5),
              child: Container(
                width: 80,
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(children: children),
            ),
            if (actions != null && actions!.isNotEmpty)
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
        ),
      ),
    );
  }
}
