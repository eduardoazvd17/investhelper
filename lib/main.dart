import 'package:flutter/material.dart';
import 'package:investmentmanager/src/features/welcome/views/welcome_page.dart';
import 'src/features/auth/views/auth_page.dart';
import 'src/features/investments/views/investments_page.dart';
import 'src/l10n/l10n.dart';

void main() {
  runApp(const InvestmentManagerApp());
}

class InvestmentManagerApp extends StatelessWidget {
  const InvestmentManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Investments Manager',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
          brightness: Brightness.light,
          surfaceTint: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: WelcomePage.routeName,
      routes: {
        WelcomePage.routeName: (_) => const WelcomePage(),
        AuthPage.routeName: (_) => const AuthPage(),
        InvestmentsPage.routeName: (_) => const InvestmentsPage(),
      },
    );
  }
}
