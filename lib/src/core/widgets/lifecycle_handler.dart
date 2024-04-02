import 'package:flutter/material.dart';

import '../controllers/app_controller.dart';

class LifecycleHandler extends StatefulWidget {
  final AppController appController;
  final Widget? child;
  const LifecycleHandler({
    required this.appController,
    required this.child,
    super.key,
  });

  @override
  State<LifecycleHandler> createState() => _LifecycleHandlerState();
}

class _LifecycleHandlerState extends State<LifecycleHandler>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _showAuthOverlay(state);
    super.didChangeAppLifecycleState(state);
  }

  void _showAuthOverlay(AppLifecycleState state) {
    if (widget.appController.isBiometricsEnabled &&
        !widget.appController.isRequestAuthOverlayShowing &&
        state == AppLifecycleState.paused) {
      widget.appController.shouldRequestAuth = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox();
  }
}
