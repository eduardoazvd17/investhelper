import 'package:flutter/material.dart';
import 'package:investhelper/src/features/investments/controllers/investments_controller.dart';

import '../../../l10n/l10n.dart';

class ManageMyGoalsPage extends StatelessWidget {
  static const routeName = "/manageMyGoals";
  final InvestmentsController controller;
  const ManageMyGoalsPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.myGoals),
      ),
      body: Container(),
    );
  }
}
