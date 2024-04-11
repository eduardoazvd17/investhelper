import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:investhelper/src/core/widgets/dropdown_button_widget.dart';
import 'package:investhelper/src/features/investments/controllers/investments_controller.dart';
import 'package:investhelper/src/features/investments/enums/category_enum.dart';
import 'package:investhelper/src/features/investments/models/create_operation_model.dart';
import 'package:investhelper/src/features/investments/models/investment_model.dart';
import 'package:investhelper/src/features/investments/models/operation_model.dart';
import 'package:investhelper/src/features/investments/widgets/category_indicator_widget.dart';
import 'package:investhelper/src/features/investments/widgets/operation_tile_widget.dart';
import '../../../core/exceptions/app_exception.dart';
import '../../../core/utils/app_formatter.dart';
import '../../../core/widgets/date_picker_widget.dart';
import '../../../core/widgets/empty_list_widget.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../core/widgets/modal_bottom_sheet_widget.dart';
import '../../../core/widgets/text_field_widget.dart';
import '../../../l10n/l10n.dart';
import '../enums/operation_type.dart';

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

  @override
  void initState() {
    _selectedInvestment = ValueNotifier<InvestmentModel?>(null);
    _quantityController = TextEditingController();
    _unitPriceController = TextEditingController();
    _totalPriceController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _selectedInvestment.dispose();
    _quantityController.dispose();
    _unitPriceController.dispose();
    _totalPriceController.dispose();
    super.dispose();
  }

  Future<void> _addNewOperation() async {
    _selectedInvestment.value = null;
    _selectedOperationType = null;
    _selectedOperationDate = DateTime.now();
    _quantityController.clear();
    _unitPriceController.clear();
    _totalPriceController.clear();

    await ModalBottomSheetWidget.show(
      context,
      title: AppLocalizations.of(context)!.addNewOperation,
      actions: [
        TextButton(
          onPressed: () async {
            try {
              LoadingWidget.dialog(context);

              if (_selectedInvestment.value == null ||
                  _selectedOperationType == null) {
                throw AppException(AppExceptionType.emptyFields);
              }

              final bool needQuantityAndUnitPrice = _selectedInvestment
                  .value!.category.needPositionAndAveragePrice;
              final quantity = int.tryParse(_quantityController.text) ?? 0;
              final unitPrice = double.tryParse(_unitPriceController.text) ?? 0;
              final totalPrice =
                  double.tryParse(_totalPriceController.text) ?? 0;

              if (needQuantityAndUnitPrice &&
                  (quantity <= 0 || unitPrice <= 0)) {
                throw AppException(AppExceptionType.emptyFields);
              }

              if (needQuantityAndUnitPrice && totalPrice <= 0) {
                throw AppException(AppExceptionType.emptyFields);
              }

              await widget.controller.addNewOperation(
                CreateOperationModel(
                  userId: widget.controller.user!.id,
                  investmentId: _selectedInvestment.value!.id,
                  type: _selectedOperationType!,
                  date: _selectedOperationDate,
                  quantity: quantity,
                  unitPrice: unitPrice,
                  totalPrice: totalPrice,
                ),
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
          },
          child: Text(AppLocalizations.of(context)!.send),
        ),
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
      ],
      children: [
        _investmentDropDownButton,
        const SizedBox(height: 10),
        _operationTypeDropDownButton,
        const SizedBox(height: 10),
        _operationDatePicker,
        const SizedBox(height: 10),
        ValueListenableBuilder(
          valueListenable: _selectedInvestment,
          builder: (_, __, ___) {
            if (_selectedInvestment.value != null) {
              if (_selectedInvestment
                  .value!.category.needPositionAndAveragePrice) {
                return Column(children: [
                  Row(
                    children: [
                      Expanded(child: _quantityTextField),
                      Expanded(child: _unitPriceTextField),
                    ],
                  ),
                  const SizedBox(height: 10),
                ]);
              } else {
                return Column(children: [
                  _totalPriceTextField,
                  const SizedBox(height: 10),
                ]);
              }
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }

  Future<void> _editOperation(OperationModel operationModel) async {
    _selectedOperationType = operationModel.type;
    _selectedOperationDate = operationModel.date;
    _quantityController.text = operationModel.quantity.toString();
    _unitPriceController.text = operationModel.unitPrice.toString();
    _totalPriceController.text = operationModel.totalPrice.toString();
  }

  Future<void> _deleteOperation(OperationModel operationModel) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.myOperations),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewOperation,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Observer(
            builder: (_) {
              return Visibility(
                visible: widget.controller.thisMonthOperations.isNotEmpty,
                replacement: Center(
                  child: EmptyListWidget(
                    message: AppLocalizations.of(context)!
                        .emptyManageMyOperationsText,
                  ),
                ),
                child: ListView(
                  children:
                      widget.controller.thisMonthOperations.map((operation) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: OperationTileWidget(
                        operation: operation,
                        investment: widget.controller.investments.firstWhere(
                          (e) => e.id == operation.investmentId,
                        ),
                        onEdit: _editOperation,
                        onDelete: _deleteOperation,
                      ),
                    );
                  }).toList(),
                ),
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
                Text(element.name),
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

  Widget get _operationTypeDropDownButton =>
      DropdownButtonWidget<OperationTypeEnum>(
        label: AppLocalizations.of(context)!.operationType,
        hint: AppLocalizations.of(context)!.operationTypeHint,
        value: _selectedOperationType,
        onChanged: (operationType) => setState(() {
          _selectedOperationType = operationType;
        }),
        items: OperationTypeEnum.values.map((e) {
          return DropdownMenuItem(
            value: e,
            child: Row(
              children: [
                Icon(e.icon, color: e.color),
                const SizedBox(width: 10),
                Text(e.getTitle(context)),
              ],
            ),
          );
        }).toList(),
      );

  Widget get _operationDatePicker => DatePickerWidget(
        label: AppLocalizations.of(context)!.operationDate,
        value: _selectedOperationDate,
        onChange: (date) => setState(() {
          _selectedOperationDate = date;
        }),
      );

  Widget get _quantityTextField => TextFieldWidget(
        label: AppLocalizations.of(context)!.quantity,
        prefix: const Padding(
          padding: EdgeInsets.only(right: 5),
          child: Text('x'),
        ),
        hint: '0',
        controller: _quantityController,
        onChanged: (value) {
          _quantityController.text = AppFormatter.textFieldInteger(value);
        },
        keyboardType: const TextInputType.numberWithOptions(decimal: false),
        textCapitalization: TextCapitalization.words,
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
          _unitPriceController.text = AppFormatter.textFieldCurrency(value);
        },
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        textCapitalization: TextCapitalization.words,
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
          _totalPriceController.text = AppFormatter.textFieldCurrency(value);
        },
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.done,
      );
}
