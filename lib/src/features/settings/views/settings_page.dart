import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:investhelper/src/core/widgets/button_tile_widget.dart';
import 'package:investhelper/src/core/widgets/drop_down_button_widget.dart';
import 'package:investhelper/src/core/widgets/section_widget.dart';
import 'package:investhelper/src/core/enums/language_enum.dart';
import 'package:investhelper/src/features/auth/views/auth_page.dart';

import '../../../core/controllers/app_controller.dart';
import '../../../core/models/user_model.dart';
import '../../../l10n/l10n.dart';
import '../../../core/enums/theme_enum.dart';

class SettingsPage extends StatelessWidget {
  static const String routeName = "/settings";
  final AppController appController;
  const SettingsPage({super.key, required this.appController});

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
                Observer(
                  builder: (_) {
                    if (appController.user == null) return const SizedBox();
                    return SectionWidget(
                      title: AppLocalizations.of(context)!.myProfile,
                      content: [
                        _myProfileSectionContent(context, appController.user!),
                      ],
                    );
                  },
                ),
                Observer(
                  builder: (_) {
                    if (appController.user == null) return const SizedBox();
                    return SectionWidget(
                      title: AppLocalizations.of(context)!.protection,
                      content: [
                        Observer(
                          builder: (_) {
                            return SwitchListTile.adaptive(
                              value: appController.isBiometricsEnabled,
                              activeColor: Colors.green,
                              title: Text(
                                AppLocalizations.of(context)!.enableBiometrics,
                              ),
                              subtitle: Text(
                                AppLocalizations.of(context)!
                                    .enableBiometricsHint,
                              ),
                              onChanged:
                                  appController.changeIsBiometricsEnabled,
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
                SectionWidget(
                  title: AppLocalizations.of(context)!.personalization,
                  content: [
                    Observer(
                      builder: (_) {
                        return DropDownButtonWidget<ThemeEnum>(
                          label: AppLocalizations.of(context)!.appTheme,
                          value: appController.theme,
                          items: ThemeEnum.values.map((e) {
                            return DropdownMenuItem(
                              value: e,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: e.icon,
                                  ),
                                  Text(e.getTitle(context)),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: appController.changeTheme,
                        );
                      },
                    ),
                    const Divider(),
                    Observer(builder: (_) {
                      return DropDownButtonWidget<LanguageEnum>(
                        label: AppLocalizations.of(context)!.appLanguage,
                        value: appController.language,
                        items: LanguageEnum.values.map((e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: e.icon,
                                ),
                                Text(e.getTitle(context)),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: appController.changeLanguage,
                      );
                    }),
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
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _myProfileSectionContent(BuildContext context, UserModel user) {
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
                    user.name,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    user.email,
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
              onTap: () {
                appController.logout();
                Navigator.of(context).pushReplacementNamed(AuthPage.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
