import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import 'firebase_options.dart';
import 'src/core/controllers/app_controller.dart';
import 'src/core/enums/language_enum.dart';
import 'src/core/enums/theme_enum.dart';
import 'src/core/services/app_service.dart';
import 'src/core/utils/app_theme.dart';
import 'src/core/utils/custom_scroll_behavior.dart';
import 'src/core/widgets/web_frame_widget.dart';
import 'src/features/auth/controllers/auth_controller.dart';
import 'src/features/auth/services/auth_service.dart';
import 'src/features/auth/views/auth_page.dart';
import 'src/features/investments/controllers/investments_controller.dart';
import 'src/features/investments/services/investments_service.dart';
import 'src/features/investments/views/investments_page.dart';
import 'src/features/investments/views/manage_my_goals_page.dart';
import 'src/features/investments/views/manage_my_investments_page.dart';
import 'src/features/investments/views/manage_my_operations_page.dart';
import 'src/features/settings/views/change_personal_data_page.dart';
import 'src/features/settings/views/settings_page.dart';
import 'src/features/splash_screen/views/splash_screen.dart';
import 'src/features/subscription/controllers/subscription_controller.dart';
import 'src/features/subscription/views/subscription_page.dart';
import 'src/features/welcome/views/welcome_page.dart';
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
    InvestmentsController(
      appController: appController,
      service: InvestmentsService(),
    ),
  );
  GetIt.I.registerSingleton(
    AuthController(
      appController: appController,
      service: AuthService(),
    ),
  );
  GetIt.I.registerSingleton(
    SubscriptionController(
      appController: appController,
    ),
  );
  return appController;
}

class InvestHelperApp extends StatelessWidget {
  final AppController appController;
  const InvestHelperApp({super.key, required this.appController});

  String get _initialRoute {
    final bool showWelcomePage =
        appController.showWelcomePage && appController.user == null;
    return showWelcomePage ? WelcomePage.routeName : InvestmentsPage.routeName;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final app = MaterialApp(
          title: 'InvestHelper',
          debugShowCheckedModeBanner: false,
          scrollBehavior: CustomScrollBehavior(),
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: MediaQuery.of(context).textScaler.clamp(
                    minScaleFactor: 0.8,
                    maxScaleFactor: 1.2,
                  ),
            ),
            child: child ?? const SizedBox(),
          ),
          theme: kIsWeb
              ? AppTheme.lightTheme.copyWith(
                  pageTransitionsTheme: PageTransitionsTheme(
                    builders: {
                      for (final platform in TargetPlatform.values)
                        platform: const FadeUpwardsPageTransitionsBuilder(),
                    },
                  ),
                )
              : AppTheme.lightTheme,
          darkTheme: kIsWeb
              ? AppTheme.darkTheme.copyWith(
                  pageTransitionsTheme: PageTransitionsTheme(
                    builders: {
                      for (final platform in TargetPlatform.values)
                        platform: const FadeUpwardsPageTransitionsBuilder(),
                    },
                  ),
                )
              : AppTheme.darkTheme,
          themeMode: appController.theme.themeMode,
          locale: appController.language.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          localeResolutionCallback: (locale, supportedLocales) {
            final languageCode = locale?.languageCode ?? 'en';
            final countryCode =
                WidgetsBinding.instance.platformDispatcher.locale.countryCode;

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
            InvestmentsPage.routeName: (_) {
              return InvestmentsPage(
                controller: GetIt.I.get<InvestmentsController>(),
              );
            },
            SettingsPage.routeName: (_) {
              return SettingsPage(appController: appController);
            },
            ChangePersonalDataPage.routeName: (_) {
              return ChangePersonalDataPage(appController: appController);
            },
            AuthPage.routeName: (_) {
              return AuthPage(controller: GetIt.I.get<AuthController>());
            },
            ManageMyGoalsPage.routeName: (_) {
              return ManageMyGoalsPage(
                controller: GetIt.I.get<InvestmentsController>(),
              );
            },
            ManageMyInvestmentsPage.routeName: (_) {
              return ManageMyInvestmentsPage(
                controller: GetIt.I.get<InvestmentsController>(),
              );
            },
            ManageMyOperationsPage.routeName: (_) {
              return ManageMyOperationsPage(
                controller: GetIt.I.get<InvestmentsController>(),
              );
            },
            SubscriptionPage.routeName: (_) {
              return SubscriptionPage(
                controller: GetIt.I.get<SubscriptionController>(),
              );
            },
          },
        );

        return kIsWeb
            ? WebFrameWidget(
                themeMode: appController.theme.themeMode,
                child: app,
              )
            : app;
      },
    );
  }
}
