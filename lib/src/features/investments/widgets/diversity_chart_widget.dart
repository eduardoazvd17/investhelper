import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:investhelper/src/features/investments/widgets/category_indicator_widget.dart';

import '../models/category_model.dart';
import '../models/investment_model.dart';

class DiversityChartWidget extends StatelessWidget {
  final double totalInvestments;
  final List<CategoryModel> categories;
  final List<InvestmentModel> investments;
  const DiversityChartWidget({
    super.key,
    required this.totalInvestments,
    required this.categories,
    required this.investments,
  });

  List<PieChartSectionData> get sections {
    return categories.map((c) {
      final investmentsByCategory =
          investments.where((e) => e.category.id == c.id);

      final double valueByCategory = investmentsByCategory.isEmpty
          ? 0.0
          : investmentsByCategory
              .map((e) => e.amountInvested)
              .reduce((a, b) => a + b);

      return PieChartSectionData(
        color: c.color,
        value: ((valueByCategory / totalInvestments) * 100),
        title: c.title,
        showTitle: false,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PieChart(
              PieChartData(
                centerSpaceRadius: 35,
                sectionsSpace: 5,
                sections: sections,
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
                  ...sections.map(
                    (section) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.5),
                        child: CategoryIndicatorWidget(
                          color: section.color,
                          text: '${section.title} - ${section.value.round()}%',
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
