import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../core/controllers/app_controller.dart';
import '../../../core/enums/language_enum.dart';
import '../../../core/enums/subscription_enum.dart';
import '../../../core/enums/theme_enum.dart';
import '../../../core/models/user_model.dart';
import '../../../core/widgets/button_tile_widget.dart';
import '../../../core/widgets/dialog_widget.dart';
import '../../../core/widgets/dropdown_button_widget.dart';
import '../../../core/widgets/section_widget.dart';
import '../../../l10n/l10n.dart';
import '../../auth/views/auth_page.dart';
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
      Navigator.of(context).pop();
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
                _myProfileSectionWidget(context),
                _protectionSectionWidget(context),
                _personalizationSectionWidget(context),
                _othersSectionWidget(context),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _myProfileSectionWidget(BuildContext context) {
    return Observer(
      builder: (_) {
        final widget = SectionWidget(
          title: AppLocalizations.of(context)!.myProfile,
          content: [
            _myProfileCardWidget(
              context,
              appController.user,
            ),
          ],
        );
        return widget
            .animate()
            .fade(duration: const Duration(milliseconds: 400))
            .slideX(duration: const Duration(milliseconds: 200));
      },
    );
  }

  Widget _protectionSectionWidget(BuildContext context) {
    return Observer(
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
                        ? AppLocalizations.of(context)!.enableBiometricsHint
                        : AppLocalizations.of(context)!.cantEnableBiometrics,
                  ),
                  onChanged: appController.canEnableBiometrics
                      ? appController.changeIsBiometricsEnabled
                      : null,
                );
              },
            ),
          ],
        )
            .animate()
            .fade(
              duration: const Duration(milliseconds: 400),
              delay: const Duration(milliseconds: 100),
            )
            .slideX(
              duration: const Duration(milliseconds: 200),
              delay: const Duration(milliseconds: 100),
            );
      },
    );
  }

  Widget _personalizationSectionWidget(BuildContext context) {
    return SectionWidget(
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
                        padding: const EdgeInsets.symmetric(horizontal: 10),
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
        const SizedBox(height: 10),
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
                      padding: const EdgeInsets.symmetric(horizontal: 10),
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
    )
        .animate()
        .fade(
          duration: const Duration(milliseconds: 400),
          delay: Duration(
            milliseconds: appController.user == null ? 100 : 200,
          ),
        )
        .slideX(
          duration: const Duration(milliseconds: 200),
          delay: Duration(
            milliseconds: appController.user == null ? 100 : 200,
          ),
        );
  }

  Widget _othersSectionWidget(BuildContext context) {
    return SectionWidget(
      title: AppLocalizations.of(context)!.others,
      content: [
        Observer(
          builder: (_) {
            if (appController.user == null) return const SizedBox();

            return ButtonTileWidget(
              text: AppLocalizations.of(context)!.termsOfUseTitle,
              icon: CupertinoIcons.doc,
              onTap: () {
                DialogWidget.show(
                  context,
                  title: AppLocalizations.of(context)!.termsOfUseTitle,
                  message: AppLocalizations.of(context)!.termsOfUseMessage,
                  actionType: DialogWidgetActionType.close,
                );
              },
            );
          },
        ),
        ButtonTileWidget(
          text: AppLocalizations.of(context)!.aboutThisApp,
          icon: Icons.info_outline,
          onTap: () {
            showAboutDialog(
              context: context,
              applicationVersion: appController.appVersion,
              children: [
                Text(AppLocalizations.of(context)!.aboutAppText),
                const SizedBox(height: 10),
                ListTile(
                  onTap: () async {
                    final Uri url = Uri.parse('https://eduardoazevedo.com');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
                  isThreeLine: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    AppLocalizations.of(context)!.developedBy,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Eduardo Azevedo Regueira'),
                      Text(
                        'eduardoazevedo.com',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.link),
                ),
              ],
              applicationIcon: Image.asset(
                'assets/images/logo.png',
                height: 50,
              ),
            );
          },
        ),
      ],
    )
        .animate()
        .fade(
          duration: const Duration(milliseconds: 400),
          delay: Duration(
            milliseconds: appController.user == null ? 200 : 300,
          ),
        )
        .slideX(
          duration: const Duration(milliseconds: 200),
          delay: Duration(
            milliseconds: appController.user == null ? 200 : 300,
          ),
        );
  }

  Widget _myProfileCardWidget(BuildContext context, UserModel? user) {
    if (user == null) {
      return ButtonTileWidget(
        text: AppLocalizations.of(context)!.authPageLoginTitle,
        icon: Icons.exit_to_app,
        onTap: () {
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args != null && args is bool && args) {
            Navigator.of(context).pop();
          } else {
            Navigator.of(context).pushNamed(AuthPage.routeName);
          }
        },
      );
    } else {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.person_circle,
                          size: 45,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: Text(
                                  user.name,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              FittedBox(
                                child: Text(
                                  user.email,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 30),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: Text(
                                  AppLocalizations.of(context)!.subscription,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                              FittedBox(
                                child: Text(
                                  user.data.subscription.getTitle(context),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            DialogWidget.show(
                              context,
                              title: AppLocalizations.of(context)!
                                  .functionNotImplementedTitle,
                              message: AppLocalizations.of(context)!
                                  .functionNotImplementedMessage,
                              actionType: DialogWidgetActionType.close,
                            );
                          },
                          child: Text(AppLocalizations.of(context)!.change),
                        ),
                      ],
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
}
