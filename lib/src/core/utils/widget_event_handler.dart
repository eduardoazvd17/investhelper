import 'dart:developer' as developer;
import 'package:flutter/material.dart';

class WidgetEventHandler extends WidgetsBindingObserver {
  final void Function()? onDetached;
  final void Function()? onResumed;
  final void Function()? onInactive;
  final void Function()? onHidden;
  final void Function()? onPaused;

  WidgetEventHandler({
    this.onDetached,
    this.onResumed,
    this.onInactive,
    this.onHidden,
    this.onPaused,
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.detached:
        onDetached?.call();
      case AppLifecycleState.resumed:
        onResumed?.call();
      case AppLifecycleState.inactive:
        onInactive?.call();
      case AppLifecycleState.hidden:
        onHidden?.call();
      case AppLifecycleState.paused:
        onPaused?.call();
    }

    developer.log(
      '${state.name} called.',
      name: 'AppLifecycleState',
      time: DateTime.now(),
    );
  }
}
