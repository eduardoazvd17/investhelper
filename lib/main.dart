import 'package:credentials_manager/credentials_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:investhelper/firebase_options.dart';
import 'package:investhelper/src/features/welcome/views/welcome_page.dart';
import 'src/core/services/app_service.dart';
import 'src/core/utils/app_theme.dart';
import 'src/features/auth/views/auth_page.dart';
import 'src/features/investments/views/investments_page.dart';
import 'src/features/settings/views/settings_page.dart';
import 'src/features/splash_screen/views/splash_screen.dart';
import 'src/l10n/l10n.dart';

Future<void> main() async {
  runApp(const SplashScreen());
  WidgetsFlutterBinding.ensureInitialized();
  await _loadDependencies();
  runApp(InvestHelperApp(initialRoute: await _getInitialRoute()));
}

Future<void> _loadDependencies() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  GetIt.I.registerSingleton(CredentialsManager(
    storageKey: await AppService.getAppID(),
    useAndroidEncryptedSharedPreferences: true,
  ));
}

Future<String> _getInitialRoute() async {
  final bool isFirstRun = await AppService.didShowWelcomePage();
  return isFirstRun ? WelcomePage.routeName : AuthPage.routeName;
}

class InvestHelperApp extends StatelessWidget {
  final String initialRoute;
  const InvestHelperApp({super.key, required this.initialRoute});

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
      initialRoute: initialRoute,
      routes: {
        WelcomePage.routeName: (_) => const WelcomePage(
              neverShowWelcomePage: AppService.neverShowWelcomePage,
            ),
        AuthPage.routeName: (_) => const AuthPage(),
        InvestmentsPage.routeName: (_) => const InvestmentsPage(),
        SettingsPage.routeName: (_) => const SettingsPage(),
      },
    );
  }
}
