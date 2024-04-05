import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:investhelper/src/features/investments/controllers/investments_controller.dart';
import '../../../core/widgets/empty_list_widget.dart';
import '../../../l10n/l10n.dart';
import '../widgets/goal_card_tile.dart';

class ManageMyGoalsPage extends StatelessWidget {
  static const routeName = "/manageMyGoals";
  final InvestmentsController controller;
  const ManageMyGoalsPage({super.key, required this.controller});

  void _addNewGoal() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.myGoals),
        actions: [
          IconButton(
            onPressed: _addNewGoal,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewGoal,
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
                    message:
                        AppLocalizations.of(context)!.emptyManageMyGoalsListing,
                  ),
                ),
                child: ListView(
                  children: controller.goals.map((goal) {
                    return GoalCardTile(goal: goal);
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
