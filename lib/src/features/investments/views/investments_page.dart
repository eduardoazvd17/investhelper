import 'package:flutter/material.dart';

class InvestmentsPage extends StatelessWidget {
  static const String routeName = "/investments";
  const InvestmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Investments'),
      ),
      body: Container(),
    );
  }
}
