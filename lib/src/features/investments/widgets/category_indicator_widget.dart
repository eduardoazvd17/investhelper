import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/category_model.dart';

class CategoryIndicatorWidget extends StatelessWidget {
  final CategoryModel category;
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
            category.title,
            style: TextStyle(color: textColor),
          ),
        ),
      ],
    );
  }
}
