import 'package:flutter/material.dart';
import 'src/l10n/l10n.dart';

void main() {
  runApp(const InvestmentManagerApp());
}

class InvestmentManagerApp extends StatelessWidget {
  const InvestmentManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Investment Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: Text(AppLocalizations.of(context)!.test),
      ),
    );
  }
}
