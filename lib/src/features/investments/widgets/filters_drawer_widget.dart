import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/widgets/drawer_widget.dart';
import '../../../core/widgets/dropdown_button_widget.dart';
import '../../../l10n/l10n.dart';
import '../controllers/investments_controller.dart';
import '../models/investment_model.dart';
import 'category_indicator_widget.dart';

class FiltersDrawerWidget extends StatelessWidget {
  final FiltersDrawerWidgetType type;
  final InvestmentsController controller;
  const FiltersDrawerWidget({
    super.key,
    required this.type,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return DrawerWidget(
      icon: Icons.filter_list,
      title: type.getTitle(context),
      children: switch (type) {
        FiltersDrawerWidgetType.operations => _operationsFilters(context),
      },
    );
  }

  List<Widget> _operationsFilters(BuildContext context) {
    return [
      _filterItemTile(
        context,
        title: AppLocalizations.of(context)!.investment,
        onRemove: () => controller.investmentIdFilter = null,
        child: Observer(
          builder: (_) {
            return DropdownButtonWidget<InvestmentModel?>(
              hint: AppLocalizations.of(context)!.investmentHint,
              value: null,
              onChanged: (investment) {
                controller.investmentIdFilter = investment?.id;
              },
              items: controller.investments.map((element) {
                return DropdownMenuItem(
                  value: element,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(child: Text(element.name)),
                      FittedBox(
                        child: CategoryIndicatorWidget(
                          category: element.category,
                          textColor: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    ];
  }

  Widget _filterItemTile(
    BuildContext context, {
    required String title,
    required void Function() onRemove,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            TextButton.icon(
              onPressed: onRemove,
              icon: const Icon(Icons.close),
              label: Text(AppLocalizations.of(context)!.remove),
            ),
          ],
        ),
        child,
      ],
    );
  }
}

enum FiltersDrawerWidgetType {
  operations,
}

extension FiltersDrawerWidgetTypeExtension on FiltersDrawerWidgetType {
  String getTitle(BuildContext context) {
    return switch (this) {
      FiltersDrawerWidgetType.operations =>
        AppLocalizations.of(context)!.operationsFiltersTitle,
    };
  }
}
