import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:investhelper/firebase_options.dart';
import 'package:investhelper/src/core/enums/language_enum.dart';
import 'package:investhelper/src/core/enums/theme_enum.dart';
import 'package:investhelper/src/features/investments/controllers/investments_controller.dart';
import 'package:investhelper/src/features/welcome/views/welcome_page.dart';
import 'src/core/services/app_service.dart';
import 'src/core/utils/app_theme.dart';
import 'src/core/widgets/lifecycle_handler.dart';
import 'src/features/auth/controllers/auth_controller.dart';
import 'src/features/auth/services/auth_service.dart';
import 'src/features/auth/views/auth_page.dart';
import 'src/features/investments/services/investments_service.dart';
import 'src/features/investments/views/investments_page.dart';
import 'src/core/controllers/app_controller.dart';
import 'src/features/settings/views/settings_page.dart';
import 'src/features/splash_screen/views/splash_screen.dart';
import 'src/l10n/l10n.dart';

Future<void> main() async {
  runApp(const SplashScreen());
  WidgetsFlutterBinding.ensureInitialized();
  final AppController appController = await _loadDependencies();
  runApp(InvestHelperApp(appController: appController));
}

Future<AppController> _loadDependencies() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final appController = GetIt.I.registerSingleton(
    AppController(service: AppService()),
  );
  await appController.initialize();
  GetIt.I.registerSingleton(
    AuthController(
      appController: appController,
      service: AuthService(),
    ),
  );
  GetIt.I.registerLazySingleton(
    () => InvestmentsController(
      appController: appController,
      service: InvestmentsService(),
    ),
  );
  return appController;
}

class InvestHelperApp extends StatelessWidget {
  final AppController appController;
  const InvestHelperApp({super.key, required this.appController});

  String get _initialRoute {
    final bool userIsLoggedIn = appController.user != null;
    if (userIsLoggedIn) return InvestmentsPage.routeName;
    final bool showWelcomePage = appController.showWelcomePage;
    return showWelcomePage ? WelcomePage.routeName : AuthPage.routeName;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return MaterialApp(
          title: 'InvestHelper',
          builder: (context, child) => LifecycleHandler(
            appController: appController,
            child: child,
          ),
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: appController.theme.themeMode,
          locale: appController.language.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          localeResolutionCallback: (locale, supportedLocales) {
            final languageCode = locale?.languageCode ?? 'en';
            final countryCode = Platform.localeName.split('_')[1];
            return supportedLocales.firstWhere(
              (e) => e.languageCode == languageCode,
              orElse: () => Locale('en', countryCode),
            );
          },
          initialRoute: _initialRoute,
          routes: {
            WelcomePage.routeName: (_) {
              return WelcomePage(appController: appController);
            },
            AuthPage.routeName: (_) {
              return AuthPage(controller: GetIt.I.get<AuthController>());
            },
            InvestmentsPage.routeName: (_) {
              return InvestmentsPage(
                controller: GetIt.I.get<InvestmentsController>(),
              );
            },
            SettingsPage.routeName: (_) {
              return SettingsPage(appController: appController);
            },
          },
        );
      },
    );
  }
}
