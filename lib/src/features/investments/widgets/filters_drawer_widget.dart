import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/widgets/date_range_picker_widget.dart';
import '../../../core/widgets/drawer_widget.dart';
import '../../../core/widgets/dropdown_button_widget.dart';
import '../../../l10n/l10n.dart';
import '../controllers/investments_controller.dart';
import '../enums/operation_type.dart';
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
      Observer(
        builder: (_) {
          return DropdownButtonWidget<String?>(
            label: AppLocalizations.of(context)!.investment,
            hint: AppLocalizations.of(context)!.investmentHint,
            value: controller.investmentIdFilter,
            onChanged: (investmentId) {
              controller.investmentIdFilter = investmentId;
            },
            items: [
              DropdownMenuItem(
                value: null,
                child: Text(
                  AppLocalizations.of(context)!.all,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ...controller.investments.map((element) {
                return DropdownMenuItem(
                  value: element.id,
                  child: Row(
                    children: [
                      CategoryIndicatorWidget(
                        category: element.category,
                        textColor: Colors.grey,
                        hideText: true,
                      ),
                      Expanded(child: Text(element.name)),
                    ],
                  ),
                );
              }),
            ],
          );
        },
      ),
      Observer(
        builder: (_) {
          return DropdownButtonWidget<OperationTypeEnum?>(
            label: AppLocalizations.of(context)!.operationType,
            hint: AppLocalizations.of(context)!.operationTypeHint,
            value: controller.operationTypeFilter,
            onChanged: (operationType) {
              controller.operationTypeFilter = operationType;
            },
            items: [
              DropdownMenuItem(
                value: null,
                child: Text(
                  AppLocalizations.of(context)!.any,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ...OperationTypeEnum.values.map(
                (element) {
                  return DropdownMenuItem(
                    value: element,
                    child: Row(
                      children: [
                        Icon(element.icon, color: element.color),
                        const SizedBox(width: 10),
                        Text(element.getTitle(context)),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
      Observer(
        builder: (_) {
          return DateRangePickerWidget(
            label: AppLocalizations.of(context)!.operationDate,
            startDate: controller.startDateFilter,
            endDate: controller.endDateFilter,
            onChange: (startDate, endDate) {
              controller.startDateFilter = startDate;
              controller.endDateFilter = endDate;
            },
          );
        },
      ),
    ];
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
