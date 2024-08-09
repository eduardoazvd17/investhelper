import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/exceptions/app_exception.dart';
import '../../../core/utils/app_formatter.dart';
import '../../../core/widgets/date_picker_widget.dart';
import '../../../core/widgets/dialog_widget.dart';
import '../../../core/widgets/dropdown_button_widget.dart';
import '../../../core/widgets/empty_list_widget.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../core/widgets/modal_bottom_sheet_widget.dart';
import '../../../core/widgets/text_field_widget.dart';
import '../../../l10n/l10n.dart';
import '../controllers/investments_controller.dart';
import '../enums/category_enum.dart';
import '../enums/operation_type_enum.dart';
import '../models/create_operation_model.dart';
import '../models/investment_model.dart';
import '../models/operation_model.dart';
import '../widgets/category_indicator_widget.dart';
import '../widgets/filters_drawer_widget.dart';
import '../widgets/filters_indicator_bar_widget.dart';
import '../widgets/operation_tile_widget.dart';
import 'manage_my_investments_page.dart';

class ManageMyOperationsPage extends StatefulWidget {
  static const routeName = "/manageMyOperations";
  final InvestmentsController controller;
  const ManageMyOperationsPage({super.key, required this.controller});

  @override
  State<ManageMyOperationsPage> createState() => _ManageMyOperationsPageState();
}

class _ManageMyOperationsPageState extends State<ManageMyOperationsPage> {
  late final ValueNotifier<InvestmentModel?> _selectedInvestment;
  OperationTypeEnum? _selectedOperationType;
  late DateTime _selectedOperationDate;
  late final TextEditingController _quantityController;
  late final TextEditingController _unitPriceController;
  late final TextEditingController _totalPriceController;
  late final TextEditingController _cryptoQuantityController;

  @override
  void initState() {
    _selectedInvestment = ValueNotifier<InvestmentModel?>(null);
    _quantityController = TextEditingController();
    _unitPriceController = TextEditingController();
    _totalPriceController = TextEditingController();
    _cryptoQuantityController = TextEditingController();
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args != null && args is bool && args) {
        _addNewOperation();
      }
    });
  }

  @override
  void dispose() {
    _selectedInvestment.dispose();
    _quantityController.dispose();
    _unitPriceController.dispose();
    _totalPriceController.dispose();
    _cryptoQuantityController.dispose();
    super.dispose();
  }

  Future<void> _addNewOperation() async {
    if (_checkIfInvestmentsIsEmpty()) return;

    onAddNewOperation() async {
      try {
        LoadingWidget.dialog(context);

        if (_selectedInvestment.value == null ||
            _selectedOperationType == null) {
          throw AppException(AppExceptionType.emptyFields);
        }

        await widget.controller.addNewOperation(
          CreateOperationModel(
            userId: widget.controller.user!.id,
            investmentId: _selectedInvestment.value!.id,
            type: _selectedOperationType!,
            date: _selectedOperationDate,
            quantity: int.tryParse(_quantityController.text) ?? 0,
            unitPrice: double.tryParse(_unitPriceController.text) ?? 0,
            totalPrice: double.tryParse(_totalPriceController.text) ?? 0,
            lastCustodialPosition: _selectedInvestment.value!.custodialPosition,
            lastAveragePrice: _selectedInvestment.value!.averagePrice,
            category: _selectedInvestment.value!.category,
            cryptoQuantity:
                double.tryParse(_cryptoQuantityController.text) ?? 0,
            lastCryptoPosition: _selectedInvestment.value!.cryptoPosition,
            lastAmountInvested: _selectedInvestment.value!.amountInvested,
          ),
          _selectedInvestment.value!,
        );

        if (mounted) {
          LoadingWidget.hide(context);
          Navigator.of(context).pop();
        }
      } on AppException catch (error) {
        if (mounted) {
          LoadingWidget.hide(context);
          error.show(context);
        }
      }
    }

    _selectedInvestment.value = null;
    _selectedOperationType = null;
    _selectedOperationDate = DateTime.now();
    _quantityController.clear();
    _unitPriceController.clear();
    _totalPriceController.clear();
    _cryptoQuantityController.clear();
    await ModalBottomSheetWidget.show(
      context,
      title: AppLocalizations.of(context)!.addNewOperation,
      actions: [
        TextButton(
          onPressed: onAddNewOperation,
          child: Text(AppLocalizations.of(context)!.send),
        ),
        TextButton(
          onPressed: Navigator.of(context).pop,
          style: ButtonStyle(
            foregroundColor:
                WidgetStateProperty.all(Theme.of(context).colorScheme.error),
          ),
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
      ],
      children: [
        _investmentDropDownButton,
        ValueListenableBuilder(
          valueListenable: _selectedInvestment,
          builder: (_, selectedInvestment, ___) {
            if (selectedInvestment != null) {
              return Column(
                children: [
                  const SizedBox(height: 10),
                  _operationTypeDropDownButton(selectedInvestment),
                  const SizedBox(height: 10),
                  _operationDatePicker(selectedInvestment),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      AppLocalizations.of(context)!
                          .operationsCronologicalOrderAdvise,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Colors.grey),
                    ),
                  ),
                  if (selectedInvestment.category.hasQuotas) ...[
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(child: _quantityTextField),
                        Expanded(child: _unitPriceTextField),
                      ],
                    ),
                  ] else ...[
                    if (selectedInvestment.category.isCrypto) ...[
                      const SizedBox(height: 10),
                      _cryptoQuantityTextField,
                    ],
                    const SizedBox(height: 10),
                    _totalPriceTextField,
                  ],
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }

  Future<void> _deleteOperation(OperationModel operationModel) async {
    try {
      LoadingWidget.dialog(context);

      final InvestmentModel investmentModel = widget.controller.investments
          .firstWhere((e) => e.id == operationModel.investmentId);

      final String operationName =
          AppLocalizations.of(context)!.operationDescription(
        operationModel.type.getTitle(context).toLowerCase(),
        AppFormatter.currency(operationModel.value),
        investmentModel.name,
      );

      final bool? result = await DialogWidget.show(
        context,
        title: AppLocalizations.of(context)!.remove,
        message: AppLocalizations.of(context)!.removeMessage(operationName),
        actionType: DialogWidgetActionType.yesOrNo,
      );

      if (result != null && result) {
        await widget.controller.deleteOperation(
          operationModel,
          investmentModel,
        );
      }

      if (mounted) LoadingWidget.hide(context);
    } on AppException catch (error) {
      if (mounted) {
        LoadingWidget.hide(context);
        error.show(context);
      }
    }
  }

  bool _checkIfInvestmentsIsEmpty() {
    final bool isEmpty = widget.controller.investments.isEmpty;
    if (isEmpty) {
      DialogWidget.show(
        context,
        title: AppLocalizations.of(context)!.dontHaveInvestmentsTitle,
        message: AppLocalizations.of(context)!.dontHaveInvestmentsMessage,
        messageWidget: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(
                ManageMyInvestmentsPage.routeName,
                arguments: true,
              );
            },
            child: Text(AppLocalizations.of(context)!.addNewInvestment),
          ),
        ),
        actionType: DialogWidgetActionType.close,
      );
    }
    return isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      onEndDrawerChanged: (isOpenning) {
        if (!isOpenning) {
          widget.controller.onChangeOperationsFilters().catchError((error) {
            if (error is AppException && context.mounted) error.show(context);
          });
        }
      },
      endDrawer: FiltersDrawerWidget(
        type: FiltersDrawerWidgetType.operations,
        controller: widget.controller,
      ),
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.myOperations),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                icon: const Icon(Icons.filter_list),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewOperation,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Observer(
            builder: (_) {
              return Column(
                children: [
                  _enabledFiltersWidget,
                  Expanded(
                    child: Visibility(
                      visible: widget.controller.filteredOperations.isNotEmpty,
                      replacement: Center(
                        child: EmptyListWidget(
                          message: AppLocalizations.of(context)!
                              .emptyManageMyOperationsText,
                        ),
                      ),
                      child: ListView(
                        children: widget.controller.filteredOperations
                            .map((operation) {
                          final InvestmentModel investment =
                              widget.controller.investments.firstWhere(
                            (e) => e.id == operation.investmentId,
                          );

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: OperationTileWidget(
                              operation: operation,
                              investment: investment,
                              onDelete: operation.date
                                      .isBefore(investment.lastOperationDate!)
                                  ? null
                                  : _deleteOperation,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget get _investmentDropDownButton => DropdownButtonWidget<InvestmentModel>(
        label: AppLocalizations.of(context)!.investment,
        hint: AppLocalizations.of(context)!.investmentHint,
        value: _selectedInvestment.value,
        onChanged: (investment) {
          if (investment != _selectedInvestment.value) {
            _selectedInvestment.value = investment;
            _quantityController.clear();
            _unitPriceController.clear();
            _totalPriceController.clear();
          }
        },
        items: widget.controller.investments.map((element) {
          return DropdownMenuItem(
            value: element,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(element.category.hasQuotas ||
                          element.category.isCrypto
                      ? '${element.name} - ${AppLocalizations.of(context)!.positionDisplay(element.category.isCrypto ? element.cryptoPosition.toString() : element.custodialPosition.toString())}'
                      : '${element.name} - ${AppLocalizations.of(context)!.totalDisplay(AppFormatter.currency(element.amountInvested))}'),
                ),
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

  Widget _operationTypeDropDownButton(InvestmentModel selectedInvestment) {
    return DropdownButtonWidget<OperationTypeEnum>(
      label: AppLocalizations.of(context)!.operationType,
      hint: AppLocalizations.of(context)!.operationTypeHint,
      value: _selectedOperationType,
      onChanged: (operationType) {
        setState(() => _selectedOperationType = operationType);
        if (operationType == OperationTypeEnum.sale) {
          if (selectedInvestment.category.hasQuotas) {
            final int quantity =
                int.tryParse(_quantityController.text.trim()) ?? 0;
            if (quantity > selectedInvestment.custodialPosition) {
              _quantityController.clear();
              _unitPriceController.clear();
            }
          } else if (selectedInvestment.category.isCrypto) {
            final double cryptoQuantity =
                double.tryParse(_cryptoQuantityController.text.trim()) ?? 0;
            if (cryptoQuantity > selectedInvestment.cryptoPosition) {
              _quantityController.clear();
              _totalPriceController.clear();
            }
          }
        }
      },
      items: OperationTypeEnum.values.map((e) {
        final bool disableSale = (selectedInvestment.category.hasQuotas
            ? selectedInvestment.custodialPosition <= 0
            : (selectedInvestment.category.isCrypto
                ? selectedInvestment.cryptoPosition <= 0
                : selectedInvestment.amountInvested <= 0));
        final bool isEnabled = disableSale ? e != OperationTypeEnum.sale : true;

        return DropdownMenuItem(
          value: e,
          enabled: isEnabled,
          child: Opacity(
            opacity: isEnabled ? 1.0 : 0.5,
            child: Row(
              children: [
                Icon(e.icon, color: e.color),
                const SizedBox(width: 10),
                Text(e.getTitle(context)),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget get _enabledFiltersWidget {
    return Builder(
      builder: (context) {
        return Observer(
          builder: (_) {
            return FiltersIndicatorBarWidget(
              onOpenFilters: Scaffold.of(context).openEndDrawer,
              [
                if (widget.controller.investmentIdFilter != null)
                  FiltersIndicatorBarItem(
                    icon: const Icon(CupertinoIcons.chart_bar),
                    title: widget.controller.investments
                        .firstWhere(
                          (e) => e.id == widget.controller.investmentIdFilter!,
                        )
                        .name,
                  ),
                if (widget.controller.operationTypeFilter != null)
                  FiltersIndicatorBarItem(
                    icon: const Icon(CupertinoIcons.arrow_up_arrow_down),
                    title: widget.controller.operationTypeFilter!
                        .getTitle(context),
                  ),
                FiltersIndicatorBarItem(
                  icon: const Icon(CupertinoIcons.calendar),
                  title: widget.controller.startDateFilter != null &&
                          widget.controller.endDateFilter != null
                      ? '${AppLocalizations.of(context)!.fromDisplay(
                          AppFormatter.date(
                            context,
                            widget.controller.startDateFilter!,
                          ),
                        )} - ${AppLocalizations.of(context)!.toDisplay(
                          AppFormatter.date(
                            context,
                            widget.controller.endDateFilter!,
                          ),
                        )}'
                      : AppLocalizations.of(context)!.all,
                ),
                FiltersIndicatorBarItem(
                  icon: widget.controller.descendingFilter
                      ? const Icon(CupertinoIcons.sort_down)
                      : const Icon(CupertinoIcons.sort_up),
                  title: widget.controller.descendingFilter
                      ? AppLocalizations.of(context)!.descending
                      : AppLocalizations.of(context)!.ascending,
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _operationDatePicker(InvestmentModel? selectedInvestment) {
    return DatePickerWidget(
      label: AppLocalizations.of(context)!.operationDate,
      value: _selectedOperationDate,
      minDate: selectedInvestment?.lastOperationDate,
      onChange: (date) => setState(() {
        _selectedOperationDate = date;
      }),
    );
  }

  Widget get _quantityTextField => TextFieldWidget(
        label: AppLocalizations.of(context)!.quantity,
        prefix: const Padding(
          padding: EdgeInsets.only(right: 5),
          child: Text('x'),
        ),
        hint: '0',
        controller: _quantityController,
        onChanged: (value) {
          final int position =
              _selectedInvestment.value?.custodialPosition ?? 0;
          final int intValue =
              int.tryParse(AppFormatter.textFieldInteger(value)) ?? 0;

          final String newValue;
          if (intValue > position &&
              _selectedOperationType == OperationTypeEnum.sale) {
            newValue = AppFormatter.textFieldInteger(position.toString());
          } else {
            newValue = AppFormatter.textFieldInteger(value);
          }

          final offset = _quantityController.selection.baseOffset;
          _quantityController.value = TextEditingValue(
            text: newValue,
            selection: TextSelection.collapsed(
              offset: min(offset, newValue.characters.length),
            ),
          );
        },
        keyboardType: const TextInputType.numberWithOptions(decimal: false),
        textInputAction: TextInputAction.done,
      );

  Widget get _unitPriceTextField => TextFieldWidget(
        label: AppLocalizations.of(context)!.unitPrice,
        prefix: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Text(AppFormatter.currencyPrefix),
        ),
        hint: '0.00',
        controller: _unitPriceController,
        onChanged: (value) {
          final newValue = AppFormatter.textFieldCurrency(value);
          final offset = _unitPriceController.selection.baseOffset;
          _unitPriceController.value = TextEditingValue(
            text: newValue,
            selection: TextSelection.collapsed(
              offset: min(offset, newValue.characters.length),
            ),
          );
        },
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        textInputAction: TextInputAction.done,
      );

  Widget get _totalPriceTextField => TextFieldWidget(
        label: AppLocalizations.of(context)!.totalPrice,
        prefix: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Text(AppFormatter.currencyPrefix),
        ),
        hint: '0.00',
        controller: _totalPriceController,
        onChanged: (value) {
          final newValue = AppFormatter.textFieldCurrency(value);
          final offset = _totalPriceController.selection.baseOffset;
          _totalPriceController.value = TextEditingValue(
            text: newValue,
            selection: TextSelection.collapsed(
              offset: min(offset, newValue.characters.length),
            ),
          );
        },
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        textInputAction: TextInputAction.done,
      );

  Widget get _cryptoQuantityTextField => TextFieldWidget(
        label: AppLocalizations.of(context)!.quantity,
        prefix: const Padding(
          padding: EdgeInsets.only(right: 5),
          child: Text('x'),
        ),
        hint: '0',
        controller: _cryptoQuantityController,
        onChanged: (value) {
          final double cryptoPosition =
              _selectedInvestment.value?.cryptoPosition ?? 0;
          final double doubleValue =
              double.tryParse(AppFormatter.cryptoFloat(value)) ?? 0;
          final String newValue;

          if (doubleValue > cryptoPosition &&
              _selectedOperationType == OperationTypeEnum.sale) {
            newValue = AppFormatter.cryptoFloat(cryptoPosition.toString());
          } else {
            newValue = AppFormatter.cryptoFloat(value);
          }

          final offset = _cryptoQuantityController.selection.baseOffset;
          _cryptoQuantityController.value = TextEditingValue(
            text: newValue,
            selection: TextSelection.collapsed(
              offset: min(offset, newValue.characters.length),
            ),
          );
        },
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        textInputAction: TextInputAction.done,
      );
}
