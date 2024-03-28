import 'package:flutter/material.dart';
import 'package:investhelper/src/core/widgets/button_tile_widget.dart';
import 'package:investhelper/src/core/widgets/drop_down_button_widget.dart';
import 'package:investhelper/src/core/widgets/section_widget.dart';
import 'package:investhelper/src/features/settings/enums/language_enum.dart';

import '../../../l10n/l10n.dart';
import '../enums/theme_enum.dart';

class SettingsPage extends StatelessWidget {
  static const String routeName = "/settings";
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
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
                  title: AppLocalizations.of(context)!.protection,
                  content: [
                    SwitchListTile.adaptive(
                      value: false,
                      activeColor: Colors.green,
                      title: Text(
                        AppLocalizations.of(context)!.enableBiometrics,
                      ),
                      subtitle: Text(
                        AppLocalizations.of(context)!.enableBiometricsHint,
                      ),
                      onChanged: (_) {},
                    ),
                  ],
                ),
                SectionWidget(
                  title: AppLocalizations.of(context)!.personalization,
                  content: [
                    DropDownButtonWidget<ThemeEnum>(
                      label: 'Tema do app:',
                      value: ThemeEnum.system,
                      items: ThemeEnum.values.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: e.icon,
                              ),
                              Text(e.getTitle(context)),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (theme) {},
                    ),
                    const Divider(),
                    DropDownButtonWidget<LanguageEnum>(
                      label: 'Idioma do app:',
                      value: LanguageEnum.system,
                      items: LanguageEnum.values.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: e.icon,
                              ),
                              Text(e.getTitle(context)),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (theme) {},
                    ),
                  ],
                ),
                SectionWidget(
                  title: AppLocalizations.of(context)!.others,
                  content: [
                    ButtonTileWidget(
                      text: AppLocalizations.of(context)!.aboutThisApp,
                      icon: Icons.info_outline,
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
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
