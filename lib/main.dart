import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:investhelper/firebase_options.dart';
import 'package:investhelper/src/features/welcome/views/welcome_page.dart';
import 'src/core/utils/app_theme.dart';
import 'src/features/auth/views/auth_page.dart';
import 'src/features/investments/views/investments_page.dart';
import 'src/l10n/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const InvestHelperApp());
}

class InvestHelperApp extends StatelessWidget {
  const InvestHelperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InvestHelper',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: (locale, supportedLocales) {
        final languageCode = locale?.languageCode ?? 'en';
        return supportedLocales.firstWhere(
          (e) => e.languageCode == languageCode,
          orElse: () => const Locale('en'),
        );
      },
      initialRoute: WelcomePage.routeName,
      routes: {
        WelcomePage.routeName: (_) => const WelcomePage(),
        AuthPage.routeName: (_) => const AuthPage(),
        InvestmentsPage.routeName: (_) => const InvestmentsPage(),
      },
    );
  }
}
