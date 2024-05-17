import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';

import '../../features/investments/views/investments_page.dart';
import '../../l10n/l10n.dart';
import '../controllers/app_controller.dart';
import '../utils/widget_event_handler.dart';
import 'button_tile_widget.dart';
import 'dialog_widget.dart';

class AuthOverlay extends StatefulWidget {
  final AppController appController;
  const AuthOverlay({super.key, required this.appController});

  static Future<void> show(BuildContext context) async {
    final AppController appController = GetIt.I.get<AppController>();
    await showDialog(
      context: context,
      useSafeArea: false,
      barrierColor: Colors.black45,
      barrierDismissible: false,
      builder: (_) => AuthOverlay(appController: appController),
    );
  }

  @override
  State<AuthOverlay> createState() => _AuthOverlayState();
}

class _AuthOverlayState extends State<AuthOverlay> {
  late final WidgetEventHandler _widgetEventHandler;
  bool _autoCallAuthenticate = true;

  @override
  void initState() {
    _widgetEventHandler = WidgetEventHandler(
      onResumed: () {
        if (_autoCallAuthenticate) {
          _authenticate();
          setState(() => _autoCallAuthenticate = false);
        }
      },
      onPaused: () => setState(() => _autoCallAuthenticate = true),
    );
    WidgetsBinding.instance.addObserver(_widgetEventHandler);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _autoCallAuthenticate = true;
      _widgetEventHandler.onResumed?.call();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_widgetEventHandler);
    super.dispose();
  }

  Future<void> _authenticate() async {
    final bool result = await widget.appController.requestAuth(
      AppLocalizations.of(context)!.continueAs(
        widget.appController.user?.shortName ?? '',
      ),
    );
    if (result && mounted) Navigator.of(context).pop();
  }

  Future<void> _endSession(BuildContext context) async {
    final result = await DialogWidget.show(
      context,
      title: AppLocalizations.of(context)!.endSession,
      message: AppLocalizations.of(context)!.endSessionMessage,
      actionType: DialogWidgetActionType.yesOrNo,
    );

    if (result != null && result) {
      widget.appController.logout();
      if (!context.mounted) return;
      Navigator.of(context).popUntil(
        ModalRoute.withName(InvestmentsPage.routeName),
      );
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
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 250,
                          child: Lottie.asset('assets/animations/auth.json'),
                        ),
                        const SizedBox(height: 25),
                        Text(
                          AppLocalizations.of(context)!.authRequired,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          AppLocalizations.of(context)!.continueAs(
                            widget.appController.user?.shortName ?? '',
                          ),
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      ButtonTileWidget(
                        icon: CupertinoIcons.lock_open,
                        text: AppLocalizations.of(context)!.unlock,
                        showBorder: false,
                        backgroundColor: Theme.of(context)
                            .elevatedButtonTheme
                            .style
                            ?.backgroundColor
                            ?.resolve(WidgetState.values.toSet()),
                        color: Theme.of(context).scaffoldBackgroundColor,
                        onTap: _authenticate,
                      ),
                      ButtonTileWidget(
                        icon: Icons.exit_to_app,
                        text: AppLocalizations.of(context)!.endSession,
                        showBorder: false,
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
