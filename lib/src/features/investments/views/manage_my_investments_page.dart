import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../core/exceptions/app_exception.dart';
import '../../../core/utils/app_formatter.dart';
import '../../../core/widgets/dropdown_button_widget.dart';
import '../../../core/widgets/text_field_widget.dart';
import '../controllers/investments_controller.dart';
import '../models/create_investment_model.dart';
import '../models/investment_model.dart';
import '../widgets/category_indicator_widget.dart';

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
  late final ValueNotifier<CategoryEnum?> _selectedCategory;

  @override
  void initState() {
    _nameController = TextEditingController();
    _custodialPositionController = TextEditingController();
    _averagePriceController = TextEditingController();
    _amountInvestedController = TextEditingController();
    _selectedCategory = ValueNotifier<CategoryEnum?>(null);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args != null && args is bool && args) {
        _addNewInvestment();
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _custodialPositionController.dispose();
    _averagePriceController.dispose();
    _amountInvestedController.dispose();
    _selectedCategory.dispose();
    super.dispose();
  }

  Future<void> _addNewInvestment() async {
    _nameController.clear();
    _selectedCategory.value = null;
    _custodialPositionController.clear();
    _averagePriceController.clear();
    _amountInvestedController.clear();

    await ModalBottomSheetWidget.show(
      context,
      title: AppLocalizations.of(context)!.addNewInvestment,
      actions: [
        TextButton(
          onPressed: () async {
            try {
              LoadingWidget.dialog(context);

              if (_selectedCategory.value == null) {
                throw AppException(AppExceptionType.emptyFields);
              }

              await widget.controller.addNewInvestment(
                CreateInvestmentModel(
                  userId: widget.controller.user!.id,
                  name: _nameController.text.trim(),
                  category: _selectedCategory.value!,
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
        ValueListenableBuilder(
          valueListenable: _selectedCategory,
          builder: (_, category, ___) {
            if (category != null) {
              return Column(
                children: [
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
                  category.needPositionAndAveragePrice
                      ? Row(
                          children: [
                            Expanded(child: _custodialPositionTextField),
                            Expanded(child: _averagePriceTextField),
                          ],
                        )
                      : _amountInvestedTextField,
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

  Future<void> _editInvestment(InvestmentModel investmentModel) async {
    _nameController.text = investmentModel.name;

    await ModalBottomSheetWidget.show(
      context,
      title: AppLocalizations.of(context)!.editInvestment,
      actions: [
        TextButton(
          onPressed: () async {
            try {
              LoadingWidget.dialog(context);

              await widget.controller.editInvestment(investmentModel.copyWith(
                name: _nameController.text.trim(),
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
      children: [_nameTextField],
    );
  }

  Future<void> _deleteInvestment(InvestmentModel investmentModel) async {
    try {
      LoadingWidget.dialog(context);
      final bool? result = await DialogWidget.show(
        context,
        title: AppLocalizations.of(context)!.remove,
        message: AppLocalizations.of(context)!.removeMessage(
          investmentModel.name,
        ),
        actionType: DialogWidgetActionType.yesOrNo,
      );
      if (result != null && result) {
        await widget.controller.deleteInvestment(investmentModel);
      }
      if (mounted) LoadingWidget.hide(context);
    } on AppException catch (error) {
      if (mounted) {
        LoadingWidget.hide(context);
        error.show(context);
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
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: InvestmentTileWidget(
                          investment: e,
                          onEdit: _editInvestment,
                          onDelete: _deleteInvestment,
                        ),
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
        value: _selectedCategory.value,
        items: CategoryEnum.values.map((e) {
          return DropdownMenuItem(
            value: e,
            child: CategoryIndicatorWidget(category: e),
          );
        }).toList(),
        onChanged: (category) {
          if (category != _selectedCategory.value) {
            _selectedCategory.value = category;
            _custodialPositionController.clear();
            _averagePriceController.clear();
            _amountInvestedController.clear();
          }
        },
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
        },
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.done,
      );
}
