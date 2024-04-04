import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:investhelper/src/features/investments/widgets/category_indicator_widget.dart';

import '../../../core/widgets/advise_message_widget.dart';
import '../../../l10n/l10n.dart';
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

  bool get hasData => investments.where((e) => e.hasData).isNotEmpty;

  Map<CategoryEnum, PieChartSectionData> getSections(BuildContext context) {
    Map<CategoryEnum, PieChartSectionData> result = {};
    if (hasData) {
      for (final category in CategoryEnum.values) {
        final investmentsByCategory =
            investments.where((e) => e.category == category);

        if (investmentsByCategory.isNotEmpty) {
          final double valueByCategory = investmentsByCategory
              .map((e) => e.amountInvested)
              .reduce((a, b) => a + b);

          result[category] = PieChartSectionData(
            color: category.color,
            value: ((valueByCategory / totalInvestments) * 100),
            title: category.getTitle(context),
            showTitle: false,
          );
        }
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      curve: Curves.ease,
      duration: const Duration(milliseconds: 300),
      child: SizedBox(
        height: hasData ? 160 : null,
        child: Visibility(
          visible: hasData,
          replacement: AdviseMessageWidget(
            message: AppLocalizations.of(context)!.emptyDiversityGraphText,
          ),
          child: Row(
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
        ),
      ),
    );
  }
}
