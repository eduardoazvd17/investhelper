import 'package:flutter/material.dart';

import '../enums/category_enum.dart';
import 'category_indicator_widget.dart';

class CategoryListingWidget extends StatelessWidget {
  const CategoryListingWidget({super.key});

  List<CategoryEnum> get firstRowItems =>
      CategoryEnum.values.sublist(0, (CategoryEnum.values.length / 2).round());

  List<CategoryEnum> get secondRowItems =>
      CategoryEnum.values.sublist((CategoryEnum.values.length / 2).round());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).textScaler.scale(110),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: firstRowItems.map((e) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: CategoryIndicatorWidget(category: e),
                  ),
                );
              }).toList(),
            ),
            Row(
              children: secondRowItems.map((e) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: CategoryIndicatorWidget(category: e),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
