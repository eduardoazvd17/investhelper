import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/controllers/app_controller.dart';
import '../../../core/exceptions/app_exception.dart';
import '../../../core/widgets/button_tile_widget.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../core/widgets/modal_bottom_sheet_widget.dart';
import '../../../core/widgets/section_widget.dart';
import '../../../core/widgets/text_field_widget.dart';
import '../../../l10n/l10n.dart';
import '../../investments/views/investments_page.dart';

class ChangePersonalDataPage extends StatefulWidget {
  static const String routeName = "/changePersonalData";
  final AppController appController;
  const ChangePersonalDataPage({super.key, required this.appController});

  @override
  State<ChangePersonalDataPage> createState() => _ChangePersonalDataPageState();
}

class _ChangePersonalDataPageState extends State<ChangePersonalDataPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _currentPasswordController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _newPasswordConfirmationController;
  late final FocusNode _currentPasswordFocus;
  late final FocusNode _newPasswordFocus;
  late final FocusNode _newPasswordConfirmationFocus;

  @override
  void initState() {
    _nameController = TextEditingController();
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _newPasswordConfirmationController = TextEditingController();
    _currentPasswordFocus = FocusNode();
    _newPasswordFocus = FocusNode();
    _newPasswordConfirmationFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _newPasswordConfirmationController.dispose();
    _currentPasswordFocus.dispose();
    _newPasswordFocus.dispose();
    _newPasswordConfirmationFocus.dispose();
    super.dispose();
  }

  Future<void> _changeUserName() async {
    _nameController.text = widget.appController.user!.name;

    await ModalBottomSheetWidget.show(
      context,
      title: AppLocalizations.of(context)!.changeName,
      actions: [
        TextButton(
          onPressed: () async {
            try {
              LoadingWidget.dialog(context);

              await widget.appController.changeUserName(
                _nameController.text.trim(),
              );

              if (mounted) {
                LoadingWidget.hide(context);
                Navigator.of(context).pop();
              }
            } on AppException catch (error) {
              if (mounted) {
                LoadingWidget.hide(context);
                error.show(context);
              }
            }
          },
          child: Text(AppLocalizations.of(context)!.save),
        ),
        TextButton(
          onPressed: Navigator.of(context).pop,
          style: ButtonStyle(
            foregroundColor:
                WidgetStateProperty.all(Theme.of(context).colorScheme.error),
          ),
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
      ],
      children: [
        _nameTextField,
      ],
    );
  }

  Future<void> _changeUserPassword() async {
    _currentPasswordController.clear();
    _newPasswordController.clear();
    _newPasswordConfirmationController.clear();

    await ModalBottomSheetWidget.show(
      context,
      title: AppLocalizations.of(context)!.changePassword,
      actions: [
        TextButton(
          onPressed: () async {
            try {
              LoadingWidget.dialog(context);

              await widget.appController.changeUserPassword(
                _currentPasswordController.text.trim(),
                _newPasswordController.text.trim(),
                _newPasswordConfirmationController.text.trim(),
              );

              if (mounted) {
                LoadingWidget.hide(context);
                Navigator.of(context).pop();
              }
            } on AppException catch (error) {
              if (mounted) {
                LoadingWidget.hide(context);
                error.show(context);
              }
            }
          },
          child: Text(AppLocalizations.of(context)!.save),
        ),
        TextButton(
          onPressed: Navigator.of(context).pop,
          style: ButtonStyle(
            foregroundColor:
                WidgetStateProperty.all(Theme.of(context).colorScheme.error),
          ),
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
      ],
      children: [
        _currentPasswordTextField,
        const SizedBox(height: 10),
        _newPasswordTextField,
        const SizedBox(height: 10),
        _newPasswordConfirmationTextField,
      ],
    );
  }

  Future<void> _deleteMyAccount() async {
    _currentPasswordController.clear();

    await ModalBottomSheetWidget.show(
      context,
      title: AppLocalizations.of(context)!.deleteMyAccountTitle,
      actions: [
        TextButton(
          onPressed: () async {
            try {
              LoadingWidget.dialog(context);
              await widget.appController.deleteMyAccount(
                _currentPasswordController.text.trim(),
              );
              if (mounted) {
                LoadingWidget.hide(context);
                Navigator.of(context).popUntil(
                  ModalRoute.withName(InvestmentsPage.routeName),
                );
              }
            } on AppException catch (error) {
              if (mounted) {
                LoadingWidget.hide(context);
                error.show(context);
              }
            }
          },
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(
              Theme.of(context).colorScheme.error,
            ),
          ),
          child: Text(AppLocalizations.of(context)!.yes),
        ),
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: Text(AppLocalizations.of(context)!.no),
        ),
      ],
      children: [
        Text(AppLocalizations.of(context)!.deleteMyAccountMessage),
        const SizedBox(height: 10),
        const Divider(),
        _currentPasswordTextField,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.changePersonalData),
      ),
      body: Observer(
        builder: (_) {
          if (widget.appController.user == null) {
            return const SizedBox();
          }

          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Observer(
                  builder: (context) {
                    return Column(
                      children: [
                        SectionWidget(
                          title: AppLocalizations.of(context)!.name,
                          actions: [
                            TextButton.icon(
                              onPressed: _changeUserName,
                              icon: const Icon(CupertinoIcons.pen),
                              label: Text(
                                  AppLocalizations.of(context)!.changeName),
                            )
                                .animate()
                                .fade(
                                    duration: const Duration(milliseconds: 400))
                                .slideX(
                                  end: 0,
                                  begin: 1,
                                  duration: const Duration(milliseconds: 200),
                                ),
                          ],
                          content: [
                            Text(
                              widget.appController.user!.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                        const Divider(),
                        SectionWidget(
                          title: AppLocalizations.of(context)!.email,
                          content: [
                            Text(
                              widget.appController.user!.email,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                        const Divider(),
                        SectionWidget(
                          title: AppLocalizations.of(context)!.password,
                          actions: [
                            TextButton.icon(
                              onPressed: _changeUserPassword,
                              icon: const Icon(CupertinoIcons.lock),
                              label: Text(
                                  AppLocalizations.of(context)!.changePassword),
                            )
                                .animate()
                                .fade(
                                    duration: const Duration(milliseconds: 400))
                                .slideX(
                                  end: 0,
                                  begin: 1,
                                  duration: const Duration(milliseconds: 200),
                                ),
                          ],
                          content: [
                            Text(
                              '••••••••',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: SectionWidget(
                            title: AppLocalizations.of(context)!.security,
                            content: [
                              ButtonTileWidget(
                                text: AppLocalizations.of(context)!
                                    .deleteMyAccountTitle,
                                icon: Icons.close,
                                color: Theme.of(context).colorScheme.error,
                                onTap: _deleteMyAccount,
                              )
                                  .animate()
                                  .fade(
                                      duration:
                                          const Duration(milliseconds: 400))
                                  .slideX(
                                    end: 0,
                                    begin: 1,
                                    duration: const Duration(milliseconds: 200),
                                  ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget get _nameTextField {
    return TextFieldWidget(
      label: AppLocalizations.of(context)!.name,
      hint: AppLocalizations.of(context)!.nameHint,
      controller: _nameController,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      textInputAction: TextInputAction.next,
    );
  }

  Widget get _currentPasswordTextField {
    return TextFieldWidget(
      label: AppLocalizations.of(context)!.currentPassword,
      hint: AppLocalizations.of(context)!.passwordHint,
      focusNode: _currentPasswordFocus,
      controller: _currentPasswordController,
      obscureText: true,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) {
        _newPasswordFocus.requestFocus();
      },
    );
  }

  Widget get _newPasswordTextField {
    return TextFieldWidget(
      label: AppLocalizations.of(context)!.newPassword,
      hint: AppLocalizations.of(context)!.newPasswordHint,
      focusNode: _newPasswordFocus,
      controller: _newPasswordController,
      obscureText: true,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) {
        _newPasswordConfirmationFocus.requestFocus();
      },
    );
  }

  Widget get _newPasswordConfirmationTextField {
    return TextFieldWidget(
      label: AppLocalizations.of(context)!.newPasswordConfirmation,
      hint: AppLocalizations.of(context)!.passwordConfirmationHint,
      focusNode: _newPasswordConfirmationFocus,
      controller: _newPasswordConfirmationController,
      obscureText: true,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
    );
  }
}
