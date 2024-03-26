import 'package:flutter/material.dart';

class GoalCardTile extends StatefulWidget {
  const GoalCardTile({super.key});

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
                      child: const Text(
                        'Aqui ficará a descrição da sua meta.',
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: LinearProgressIndicator(value: 0.75),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
