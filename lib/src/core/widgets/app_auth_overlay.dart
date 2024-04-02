import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:investhelper/src/core/widgets/button_tile_widget.dart';
import 'package:investhelper/src/features/investments/views/investments_page.dart';

import '../../features/auth/views/auth_page.dart';
import '../../l10n/l10n.dart';
import '../controllers/app_controller.dart';
import '../utils/widget_event_handler.dart';
import 'dialog_widget.dart';

class AppAuthOverlay extends StatefulWidget {
  final AppController appController;
  const AppAuthOverlay({super.key, required this.appController});

  static Future<void> show(BuildContext context) async {
    final AppController appController = GetIt.I.get<AppController>();
    if (appController.isRequestAuthOverlayShowing) return;

    appController.shouldRequestAuth = false;
    appController.isRequestAuthOverlayShowing = true;
    await showDialog(
      context: context,
      useSafeArea: false,
      barrierColor: Colors.black38,
      barrierDismissible: false,
      builder: (_) => AppAuthOverlay(appController: appController),
    );
    appController.isRequestAuthOverlayShowing = false;
  }

  @override
  State<AppAuthOverlay> createState() => _AppAuthOverlayState();
}

class _AppAuthOverlayState extends State<AppAuthOverlay> {
  late final WidgetEventHandler _widgetEventHandler;
  bool _autoCallAuthenticate = true;

  @override
  void initState() {
    _widgetEventHandler = WidgetEventHandler(
      onResume: () {
        if (_autoCallAuthenticate) {
          _authenticate();
          setState(() => _autoCallAuthenticate = false);
        }
      },
      onPause: () => setState(() => _autoCallAuthenticate = true),
    );
    WidgetsBinding.instance.addObserver(_widgetEventHandler);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _autoCallAuthenticate = true;
      _widgetEventHandler.onResume?.call();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_widgetEventHandler);
    super.dispose();
  }

  Future<void> _authenticate() async {
    final bool result = await widget.appController.requestAuth();
    if (result && mounted) Navigator.of(context).pop();
  }

  Future<void> _endSession(BuildContext context) async {
    final result = await DialogWidget.show(
      context,
      title: AppLocalizations.of(context)!.endSession,
      message: AppLocalizations.of(context)!.endSessionMessage,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(AppLocalizations.of(context)!.yes),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(AppLocalizations.of(context)!.no),
        ),
      ],
    );

    if (result != null && result) {
      widget.appController.logout();
      if (!context.mounted) return;
      Navigator.of(context)
          .popUntil(ModalRoute.withName(InvestmentsPage.routeName));
      Navigator.of(context).pushReplacementNamed(AuthPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: Column(
                      children: [
                        const Icon(CupertinoIcons.lock, size: 100),
                        const SizedBox(height: 20),
                        Text(
                          AppLocalizations.of(context)!.authRequired,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      ButtonTileWidget(
                        icon: CupertinoIcons.lock_open,
                        text: AppLocalizations.of(context)!.unlock,
                        backgroundColor: Theme.of(context)
                            .elevatedButtonTheme
                            .style
                            ?.backgroundColor
                            ?.resolve(MaterialState.values.toSet()),
                        color: Theme.of(context).scaffoldBackgroundColor,
                        onTap: _authenticate,
                      ),
                      ButtonTileWidget(
                        icon: Icons.exit_to_app,
                        text: AppLocalizations.of(context)!.endSession,
                        backgroundColor: Theme.of(context).colorScheme.error,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        onTap: () => _endSession(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
