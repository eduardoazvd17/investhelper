import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../enums/category_enum.dart';

class CategoryIndicatorWidget extends StatelessWidget {
  final CategoryEnum category;
  final Color? textColor;
  const CategoryIndicatorWidget({
    super.key,
    required this.category,
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
            color: category.color,
          ),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            category.getTitle(context),
            style: TextStyle(color: textColor),
          ),
        ),
      ],
    );
  }
}
