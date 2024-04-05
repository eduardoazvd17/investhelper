import 'package:flutter/material.dart';

import '../../../core/utils/app_formatter.dart';
import '../models/goal_model.dart';

class GoalCardTile extends StatefulWidget {
  final GoalModel goal;
  const GoalCardTile({super.key, required this.goal});

  @override
  State<GoalCardTile> createState() => _GoalCardTileState();
}

class _GoalCardTileState extends State<GoalCardTile> {
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
      height: 120,
      width: 225,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.5),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10),
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
        ),
      ),
    );
  }
}
