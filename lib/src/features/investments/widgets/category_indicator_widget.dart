import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../enums/category_enum.dart';

class CategoryIndicatorWidget extends StatelessWidget {
  final CategoryEnum category;
  final Color? textColor;
  final int? value;
  final bool hideText;
  const CategoryIndicatorWidget({
    super.key,
    required this.category,
    this.textColor,
    this.value,
    this.hideText = false,
  });

  @override
  Widget build(BuildContext context) {
    if (hideText) {
      return Padding(
        padding: const EdgeInsets.only(left: 5, right: 10),
        child: _indicatorWidget,
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _indicatorWidget,
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            '${category.getTitle(context)}${value != null ? ' - $value%' : ''}',
            style: TextStyle(
              color: textColor,
              fontSize: value != null ? 12.5 : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget get _indicatorWidget => Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: category.color,
        ),
      );
}
