import 'package:flutter/material.dart';
import 'package:investmentmanager/src/l10n/l10n.dart';

class InvestmentsPage extends StatelessWidget {
  static const String routeName = "/investments";
  const InvestmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.myInvestments),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                Text('Olá Eduardo, aqui estão seus investimentos:'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
