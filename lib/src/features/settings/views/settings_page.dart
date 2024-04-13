import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../core/widgets/button_tile_widget.dart';
import '../../../core/widgets/dropdown_button_widget.dart';
import '../../../core/widgets/section_widget.dart';
import '../../../core/enums/language_enum.dart';
import '../../auth/views/auth_page.dart';

import '../../../core/controllers/app_controller.dart';
import '../../../core/models/user_model.dart';
import '../../../core/widgets/dialog_widget.dart';
import '../../../l10n/l10n.dart';
import '../../../core/enums/theme_enum.dart';
import '../../investments/views/investments_page.dart';
import 'change_personal_data_page.dart';

class SettingsPage extends StatelessWidget {
  static const String routeName = "/settings";
  final AppController appController;
  const SettingsPage({super.key, required this.appController});

  Future<void> _endSession(BuildContext context) async {
    final bool? result = await DialogWidget.show(
      context,
      title: AppLocalizations.of(context)!.endSession,
      message: AppLocalizations.of(context)!.endSessionMessage,
      actionType: DialogWidgetActionType.yesOrNo,
    );

    if (result != null && result) {
      appController.logout();
      if (!context.mounted) return;
      Navigator.of(context)
          .popUntil(ModalRoute.withName(InvestmentsPage.routeName));
      Navigator.of(context).pushReplacementNamed(AuthPage.routeName);
    }
  }

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
                    if (appController.user == null) {
                      return const SizedBox();
                    }

                    return SectionWidget(
                      title: AppLocalizations.of(context)!.myProfile,
                      content: [
                        _myProfileSectionContent(
                          context,
                          appController.user!,
                        ),
                      ],
                    );
                  },
                ),
                Observer(
                  builder: (_) {
                    if (appController.user == null) {
                      return const SizedBox();
                    }

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
                                appController.canEnableBiometrics
                                    ? AppLocalizations.of(context)!
                                        .enableBiometricsHint
                                    : AppLocalizations.of(context)!
                                        .cantEnableBiometrics,
                              ),
                              onChanged: appController.canEnableBiometrics
                                  ? appController.changeIsBiometricsEnabled
                                  : null,
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
                        return DropdownButtonWidget<ThemeEnum>(
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
                      return DropdownButtonWidget<LanguageEnum>(
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
                      onTap: () {
                        showAboutDialog(
                          context: context,
                          applicationVersion: appController.appVersion,
                          children: [
                            Text(AppLocalizations.of(context)!.aboutAppText),
                          ],
                          applicationIcon: Image.asset(
                            'assets/images/logo.png',
                            height: 50,
                          ),
                        );
                      },
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
              onTap: () => Navigator.of(context).pushNamed(
                ChangePersonalDataPage.routeName,
              ),
            ),
            ButtonTileWidget(
              text: AppLocalizations.of(context)!.endSession,
              icon: Icons.exit_to_app,
              color: Theme.of(context).colorScheme.error,
              onTap: () => _endSession(context),
            ),
          ],
        ),
      ),
    );
  }
}
