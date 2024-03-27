import 'package:flutter/material.dart';

class SectionWidget extends StatelessWidget {
  final String title;
  final List<Widget> actions;
  final List<Widget> content;
  final CrossAxisAlignment contentAlign;
  const SectionWidget({
    super.key,
    required this.title,
    this.actions = const [],
    required this.content,
    this.contentAlign = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: contentAlign,
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            const SizedBox(width: 10),
            ...actions,
          ],
        ),
        ...content,
      ],
    );
  }
}
