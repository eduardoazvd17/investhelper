import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:investhelper/src/core/exceptions/app_exception.dart';
import 'package:investhelper/src/core/widgets/dropdown_button_widget.dart';
import 'package:investhelper/src/core/widgets/text_field_widget.dart';
import 'package:investhelper/src/features/investments/controllers/investments_controller.dart';
import 'package:investhelper/src/features/investments/widgets/category_indicator_widget.dart';

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
  CategoryEnum? _selectedCategory;

  @override
  void initState() {
    _nameController = TextEditingController();
    _custodialPositionController = TextEditingController(text: '0');
    _averagePriceController = TextEditingController(text: '0');
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _custodialPositionController.dispose();
    _averagePriceController.dispose();
    super.dispose();
  }

  Future<void> _addNewInvestment() async {
    await ModalBottomSheetWidget.show(
      context,
      title: AppLocalizations.of(context)!.addNewInvestment,
      actions: [
        TextButton(
          onPressed: () async {
            try {
              LoadingWidget.dialog(context);

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
      ],
    );
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
                  scrollDirection: Axis.horizontal,
                  children: widget.controller.investments
                      .map((e) => InvestmentTileWidget(investment: e))
                      .toList(),
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
        controller: _custodialPositionController,
        keyboardType: const TextInputType.numberWithOptions(decimal: false),
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.done,
      );

  Widget get _averagePriceTextField => TextFieldWidget(
        label: AppLocalizations.of(context)!.startAveragePrice,
        controller: _averagePriceController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.done,
      );
}
