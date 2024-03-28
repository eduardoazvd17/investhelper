import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:investhelper/src/core/widgets/button_tile_widget.dart';
import 'package:investhelper/src/core/widgets/drop_down_button_widget.dart';
import 'package:investhelper/src/core/widgets/section_widget.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SectionWidget(
              title: AppLocalizations.of(context)!.myProfile,
              content: [
                _myProfileCardWidget(context),
              ],
            ),
            SectionWidget(
              title: AppLocalizations.of(context)!.options,
              content: [
                SwitchListTile.adaptive(
                  value: false,
                  title: const Text('Option title'),
                  subtitle: const Text('Description'),
                  activeColor: Colors.green,
                  onChanged: (_) {},
                ),
                const Divider(),
                DropDownButtonWidget<int>(
                  value: 0,
                  items: const [
                    DropdownMenuItem(
                      value: 0,
                      child: Text('Opção 1'),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child: Text('Opção 2'),
                    ),
                  ],
                  onChanged: (_) {},
                ),
                const Divider(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _myProfileCardWidget(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nome do usuário',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    'email@dousuario.com',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
            ButtonTileWidget(
              text: AppLocalizations.of(context)!.changePersonalData,
              onTap: () {},
            ),
            ButtonTileWidget(
              text: AppLocalizations.of(context)!.endSession,
              icon: Icons.exit_to_app,
              color: Theme.of(context).colorScheme.error,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
