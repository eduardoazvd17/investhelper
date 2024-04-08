import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:investhelper/src/core/widgets/loading_widget.dart';
import 'package:investhelper/src/core/widgets/modal_bottom_sheet_widget.dart';
import 'package:investhelper/src/features/investments/controllers/investments_controller.dart';
import 'package:investhelper/src/features/investments/models/create_goal_model.dart';
import '../../../core/exceptions/app_exception.dart';
import '../../../core/widgets/dialog_widget.dart';
import '../../../core/widgets/empty_list_widget.dart';
import '../../../l10n/l10n.dart';
import '../models/goal_model.dart';
import '../widgets/goal_card_tile.dart';

class ManageMyGoalsPage extends StatefulWidget {
  static const routeName = "/manageMyGoals";
  final InvestmentsController controller;
  const ManageMyGoalsPage({super.key, required this.controller});

  @override
  State<ManageMyGoalsPage> createState() => _ManageMyGoalsPageState();
}

class _ManageMyGoalsPageState extends State<ManageMyGoalsPage> {
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _addNewGoal() async {
    _descriptionController.clear();

    await ModalBottomSheetWidget.show(
      context,
      title: AppLocalizations.of(context)!.addNewGoal,
      actions: [
        TextButton(
          onPressed: () async {
            try {
              LoadingWidget.dialog(context);
              await widget.controller.addNewGoal(
                CreateGoalModel(
                  userId: widget.controller.user!.id,
                  description: _descriptionController.text.trim(),
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
      children: [_descriptionTextField],
    );
  }

  Future<void> _editGoal(GoalModel goalModel) async {
    _descriptionController.text = goalModel.description;

    await ModalBottomSheetWidget.show(
      context,
      title: AppLocalizations.of(context)!.editGoal,
      actions: [
        TextButton(
          onPressed: () async {
            try {
              LoadingWidget.dialog(context);

              await widget.controller.editGoal(
                goalModel.copyWith(
                  description: _descriptionController.text.trim(),
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
          child: Text(AppLocalizations.of(context)!.save),
        ),
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
      ],
      children: [_descriptionTextField],
    );
  }

  Future<void> _deleteGoal(GoalModel goalModel) async {
    final bool? result = await DialogWidget.show(
      context,
      title: AppLocalizations.of(context)!.remove,
      message:
          AppLocalizations.of(context)!.removeMessage(goalModel.description),
      actionType: DialogWidgetActionType.yesOrNo,
    );
    if (result != null && result) widget.controller.deleteGoal(goalModel);
  }

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
                visible: widget.controller.goals.isNotEmpty,
                replacement: Center(
                  child: EmptyListWidget(
                    message:
                        AppLocalizations.of(context)!.emptyManageMyGoalsListing,
                  ),
                ),
                child: ListView(
                  children: widget.controller.goals.map((goal) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: GoalCardTile(
                        goal: goal,
                        onEdit: _editGoal,
                        onDelete: _deleteGoal,
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

  Widget get _descriptionTextField => TextFormField(
        controller: _descriptionController,
        maxLines: 3,
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          label: Text(AppLocalizations.of(context)!.description),
          hintText: AppLocalizations.of(context)!.goalDescriptionHint,
          border: const OutlineInputBorder(),
        ),
        textInputAction: TextInputAction.done,
      );
}
