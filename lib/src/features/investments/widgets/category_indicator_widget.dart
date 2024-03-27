import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryIndicatorWidget extends StatelessWidget {
  final Color color;
  final String text;
  final Color? textColor;
  const CategoryIndicatorWidget({
    super.key,
    required this.color,
    required this.text,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ],
    );
  }
}
