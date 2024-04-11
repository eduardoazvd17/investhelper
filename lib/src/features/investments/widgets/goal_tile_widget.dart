// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_formatter.dart';
import '../models/goal_model.dart';

class GoalTileWidget extends StatefulWidget {
  final GoalModel goal;
  final void Function(GoalModel)? onEdit;
  final void Function(GoalModel)? onDelete;

  const GoalTileWidget({
    super.key,
    required this.goal,
    this.onEdit,
    this.onDelete,
  });

  @override
  State<GoalTileWidget> createState() => _GoalTileWidgetState();
}

class _GoalTileWidgetState extends State<GoalTileWidget> {
  late final ScrollController _textScrollController;

  @override
  void initState() {
    _textScrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _textScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      width: 240,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.5),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Scrollbar(
                          controller: _textScrollController,
                          thumbVisibility: true,
                          child: SingleChildScrollView(
                            controller: _textScrollController,
                            child: Text(widget.goal.description),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          AppFormatter.date(context, widget.goal.creationDate),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.onEdit != null && widget.onDelete != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (widget.onEdit != null)
                          IconButton(
                            onPressed: () => widget.onEdit!.call(widget.goal),
                            visualDensity: VisualDensity.compact,
                            icon: const Icon(CupertinoIcons.pen),
                          ),
                        if (widget.onDelete != null)
                          IconButton(
                            onPressed: () => widget.onDelete!.call(widget.goal),
                            visualDensity: VisualDensity.compact,
                            icon: const Icon(CupertinoIcons.delete),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
