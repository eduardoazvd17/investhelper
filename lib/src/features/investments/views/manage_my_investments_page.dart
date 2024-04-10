import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:investhelper/src/core/exceptions/app_exception.dart';
import 'package:investhelper/src/core/utils/app_formatter.dart';
import 'package:investhelper/src/core/widgets/dropdown_button_widget.dart';
import 'package:investhelper/src/core/widgets/text_field_widget.dart';
import 'package:investhelper/src/features/investments/controllers/investments_controller.dart';
import 'package:investhelper/src/features/investments/models/create_investment_model.dart';
import 'package:investhelper/src/features/investments/models/investment_model.dart';
import 'package:investhelper/src/features/investments/widgets/category_indicator_widget.dart';

import '../../../core/widgets/dialog_widget.dart';
import '../../../core/widgets/empty_list_widget.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../core/widgets/modal_bottom_sheet_widget.dart';
import '../../../l10n/l10n.dart';
import '../enums/category_enum.dart';
import '../widgets/investment_tile_widget.dart';

class ManageMyInvestmentsPage extends StatefulWidget {
  static const routeName = "/manageMyInvestments";
  final InvestmentsController controller;
  const ManageMyInvestmentsPage({super.key, required this.controller});

  @override
  State<ManageMyInvestmentsPage> createState() =>
      _ManageMyInvestmentsPageState();
}

class _ManageMyInvestmentsPageState extends State<ManageMyInvestmentsPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _custodialPositionController;
  late final TextEditingController _averagePriceController;
  late final TextEditingController _amountInvestedController;
  CategoryEnum? _selectedCategory;

  @override
  void initState() {
    _nameController = TextEditingController();
    _custodialPositionController = TextEditingController();
    _averagePriceController = TextEditingController();
    _amountInvestedController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _custodialPositionController.dispose();
    _averagePriceController.dispose();
    _amountInvestedController.dispose();
    super.dispose();
  }

  Future<void> _addNewInvestment() async {
    _nameController.clear();
    _selectedCategory = null;
    _custodialPositionController.clear();
    _averagePriceController.clear();

    await ModalBottomSheetWidget.show(
      context,
      title: AppLocalizations.of(context)!.addNewInvestment,
      actions: [
        TextButton(
          onPressed: () async {
            try {
              LoadingWidget.dialog(context);

              if (_selectedCategory == null) {
                throw AppException(AppExceptionType.emptyFields);
              }

              await widget.controller.addNewInvestment(
                CreateInvestmentModel(
                  userId: widget.controller.user!.id,
                  name: _nameController.text.trim(),
                  category: _selectedCategory!,
                  custodialPosition:
                      int.tryParse(_custodialPositionController.text) ?? 0,
                  averagePrice:
                      double.tryParse(_averagePriceController.text) ?? 0,
                  amountInvested:
                      double.tryParse(_amountInvestedController.text) ?? 0,
                  creationDate: DateTime.now(),
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
        _nameTextField,
        const SizedBox(height: 10),
        _categoryDropDownButton,
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            AppLocalizations.of(context)!.addInvestmentsValuesAdvise,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Colors.grey),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: _custodialPositionTextField),
            Expanded(child: _averagePriceTextField),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            AppLocalizations.of(context)!.or,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Colors.grey),
          ),
        ),
        _amountInvestedTextField
      ],
    );
  }

  Future<void> _editInvestment(InvestmentModel investmentModel) async {
    _nameController.text = investmentModel.name;
    _selectedCategory = investmentModel.category;

    await ModalBottomSheetWidget.show(
      context,
      title: AppLocalizations.of(context)!.editInvestment,
      actions: [
        TextButton(
          onPressed: () async {
            try {
              LoadingWidget.dialog(context);

              if (_selectedCategory == null) {
                throw AppException(AppExceptionType.emptyFields);
              }

              await widget.controller.editInvestment(investmentModel.copyWith(
                name: _nameController.text.trim(),
                category: _selectedCategory,
              ));

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
          child: Text(AppLocalizations.of(context)!.save),
        ),
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
      ],
      children: [
        _nameTextField,
        const SizedBox(height: 10),
        _categoryDropDownButton,
      ],
    );
  }

  Future<void> _deleteInvestment(InvestmentModel investmentModel) async {
    try {
      final bool? result = await DialogWidget.show(
        context,
        title: AppLocalizations.of(context)!.remove,
        message: AppLocalizations.of(context)!.removeMessage(
          investmentModel.name,
        ),
        actionType: DialogWidgetActionType.yesOrNo,
      );
      if (result != null && result) {
        widget.controller.deleteInvestment(investmentModel);
      }
    } on AppException catch (error) {
      if (mounted) {
        LoadingWidget.hide(context);
        error.show(context);
      }
    }
  }

  void _onEditValues(bool isFromAmountInvested) {
    final int custodialPosition =
        int.tryParse(_custodialPositionController.text) ?? 0;
    final double averagePrice =
        double.tryParse(_averagePriceController.text) ?? 0;

    if (!isFromAmountInvested) {
      if (_amountInvestedController.text.isNotEmpty) {
        _amountInvestedController.clear();
      }
      if (custodialPosition > 0 && averagePrice > 0) {
        _amountInvestedController.text = AppFormatter.textFieldCurrency(
          (custodialPosition * averagePrice).toString(),
        );
      }
    } else {
      final double amountInvested =
          double.tryParse(_amountInvestedController.text) ?? 0;
      if (amountInvested != (custodialPosition * averagePrice)) {
        _custodialPositionController.clear();
        _averagePriceController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.myInvestments),
        actions: [
          IconButton(
            onPressed: _addNewInvestment,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewInvestment,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Observer(
            builder: (_) {
              return Visibility(
                visible: widget.controller.investments.isNotEmpty,
                replacement: Center(
                  child: EmptyListWidget(
                    message: AppLocalizations.of(context)!
                        .emptyManageMyInvestmentsListing,
                  ),
                ),
                child: ListView(
                  children: widget.controller.investments.map(
                    (e) {
                      return InvestmentTileWidget(
                        investment: e,
                        onEdit: _editInvestment,
                        onDelete: _deleteInvestment,
                      );
                    },
                  ).toList(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget get _nameTextField => TextFieldWidget(
        label: AppLocalizations.of(context)!.name,
        hint: AppLocalizations.of(context)!.investmentNameHint,
        controller: _nameController,
        onChanged: (value) {
          _nameController.text = AppFormatter.ticker(value);
        },
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.done,
      );

  Widget get _categoryDropDownButton => DropdownButtonWidget<CategoryEnum>(
        label: AppLocalizations.of(context)!.category,
        hint: AppLocalizations.of(context)!.selectCategory,
        value: _selectedCategory,
        items: CategoryEnum.values.map((e) {
          return DropdownMenuItem(
            value: e,
            child: CategoryIndicatorWidget(category: e),
          );
        }).toList(),
        onChanged: (category) => setState(() {
          _selectedCategory = category;
        }),
      );

  Widget get _custodialPositionTextField => TextFieldWidget(
        label: AppLocalizations.of(context)!.startCustodialPosition,
        prefix: const Padding(
          padding: EdgeInsets.only(right: 5),
          child: Text('x'),
        ),
        hint: '0',
        controller: _custodialPositionController,
        onChanged: (value) {
          _custodialPositionController.text =
              AppFormatter.textFieldInteger(value);
          _onEditValues(false);
        },
        keyboardType: const TextInputType.numberWithOptions(decimal: false),
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.done,
      );

  Widget get _averagePriceTextField => TextFieldWidget(
        label: AppLocalizations.of(context)!.startAveragePrice,
        prefix: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Text(AppFormatter.currencyPrefix),
        ),
        hint: '0.00',
        controller: _averagePriceController,
        onChanged: (value) {
          _averagePriceController.text = AppFormatter.textFieldCurrency(value);
          _onEditValues(false);
        },
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.done,
      );

  Widget get _amountInvestedTextField => TextFieldWidget(
        label: AppLocalizations.of(context)!.amountInvested,
        prefix: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Text(AppFormatter.currencyPrefix),
        ),
        hint: '0.00',
        controller: _amountInvestedController,
        onChanged: (value) {
          _amountInvestedController.text =
              AppFormatter.textFieldCurrency(value);
          _onEditValues(true);
        },
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.done,
      );
}
