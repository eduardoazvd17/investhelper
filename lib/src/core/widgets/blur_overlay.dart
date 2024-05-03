import 'dart:ui';

import 'package:flutter/material.dart';

class BlurOverlay extends StatelessWidget {
  const BlurOverlay({super.key});

  static show(BuildContext context) {
    showDialog(
      context: context,
      useSafeArea: false,
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      builder: (_) => const BlurOverlay(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: const SizedBox(),
      ),
    );
  }
}
