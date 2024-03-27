import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';

class SettingsPage extends StatelessWidget {
  static const String routeName = "/settings";
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: Container(),
    );
  }
}
