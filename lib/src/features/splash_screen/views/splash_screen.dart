import 'package:flutter/material.dart';

import '../../../core/utils/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InvestHelper',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: Center(
        child: Image.asset(
          'assets/images/logo.png',
          height: 180,
        ),
      ),
    );
  }
}
