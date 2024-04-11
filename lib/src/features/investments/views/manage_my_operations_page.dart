import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:investhelper/src/features/investments/controllers/investments_controller.dart';
import 'package:investhelper/src/features/investments/models/operation_model.dart';
import 'package:investhelper/src/features/investments/widgets/operation_tile_widget.dart';
import '../../../core/widgets/empty_list_widget.dart';
import '../../../l10n/l10n.dart';

class ManageMyOperationsPage extends StatefulWidget {
  static const routeName = "/manageMyOperations";
  final InvestmentsController controller;
  const ManageMyOperationsPage({super.key, required this.controller});

  @override
  State<ManageMyOperationsPage> createState() => _ManageMyOperationsPageState();
}

class _ManageMyOperationsPageState extends State<ManageMyOperationsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _addNewOperation() async {}

  Future<void> _editOperation(OperationModel operationModel) async {}

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
}
