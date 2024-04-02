import 'package:flutter/material.dart';

class WidgetEventHandler extends WidgetsBindingObserver {
  final void Function() onResume;
  final void Function() onPause;

  WidgetEventHandler({
    required this.onResume,
    required this.onPause,
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      onResume.call();
    }
    if (state == AppLifecycleState.paused) {
      onPause.call();
    }
  }
}
