import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'category_indicator_widget.dart';

import '../enums/category_enum.dart';
import '../models/investment_model.dart';

class DiversityChartWidget extends StatelessWidget {
  final double totalInvestments;
  final List<InvestmentModel> investments;
  const DiversityChartWidget({
    super.key,
    required this.totalInvestments,
    required this.investments,
  });

  Map<CategoryEnum, PieChartSectionData> getSections(BuildContext context) {
    final Map<CategoryEnum, PieChartSectionData> result = {};
    for (final category in CategoryEnum.values) {
      final investmentsByCategory =
          investments.where((e) => e.category == category);

      if (investmentsByCategory.isNotEmpty) {
        final double valueByCategory =
            investmentsByCategory.map((e) => e.value).reduce((a, b) => a + b);

        result.putIfAbsent(
          category,
          () => PieChartSectionData(
            color: category.color,
            value: ((valueByCategory / totalInvestments) * 100),
            title: category.getTitle(context),
            showTitle: false,
          ),
        );
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: PieChart(
            PieChartData(
              centerSpaceRadius: 35,
              sectionsSpace: 5,
              sections: getSections(context).values.toList(),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...getSections(context).keys.map(
                  (category) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.5),
                      child: CategoryIndicatorWidget(
                        category: category,
                        value: getSections(context)[category]!.value.round(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
