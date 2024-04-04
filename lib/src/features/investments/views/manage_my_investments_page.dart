import 'package:flutter/material.dart';
import 'package:investhelper/src/features/investments/controllers/investments_controller.dart';

import '../../../l10n/l10n.dart';

class ManageMyInvestmentsPage extends StatelessWidget {
  static const routeName = "/manageMyInvestments";
  final InvestmentsController controller;
  const ManageMyInvestmentsPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.manageMyInvestments),
      ),
      body: Container(),
    );
  }
}
