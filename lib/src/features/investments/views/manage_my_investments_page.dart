import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:investhelper/src/features/investments/controllers/investments_controller.dart';

import '../../../core/widgets/empty_list_widget.dart';
import '../../../l10n/l10n.dart';
import '../widgets/investment_tile_widget.dart';

class ManageMyInvestmentsPage extends StatelessWidget {
  static const routeName = "/manageMyInvestments";
  final InvestmentsController controller;
  const ManageMyInvestmentsPage({super.key, required this.controller});

  void _addNewInvestment() {}

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
                visible: controller.goals.isNotEmpty,
                replacement: Center(
                  child: EmptyListWidget(
                    message: AppLocalizations.of(context)!
                        .emptyManageMyInvestmentsListing,
                  ),
                ),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: controller.investments
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
}
