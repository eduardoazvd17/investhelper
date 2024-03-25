import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  static const String routeName = "/auth";
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth'),
      ),
      body: Container(),
    );
  }
}
