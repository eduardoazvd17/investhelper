import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:investhelper/src/features/investments/widgets/category_indicator_widget.dart';

class DiversityChartWidget extends StatelessWidget {
  const DiversityChartWidget({super.key});

  List<PieChartSectionData> get sections => [
        PieChartSectionData(
          color: Colors.purple,
          value: 10,
          title: 'Ações',
          showTitle: false,
        ),
        PieChartSectionData(
          color: Colors.blue,
          value: 30,
          title: 'Fii\'s',
          showTitle: false,
        ),
        PieChartSectionData(
          color: Colors.blueGrey[800],
          value: 50,
          title: 'Crypto',
          showTitle: false,
        ),
      ];

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
                          text: '${section.title} - ${section.value.toInt()}%',
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
