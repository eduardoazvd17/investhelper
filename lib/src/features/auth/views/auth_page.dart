import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

import '../../../core/exceptions/app_exception.dart';
import '../../../core/utils/date_time_utils.dart';
import '../../../core/widgets/dialog_widget.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../core/widgets/text_field_widget.dart';
import '../../../l10n/l10n.dart';
import '../../settings/views/settings_page.dart';
import '../../subscription/views/subscription_page.dart';
import '../controllers/auth_controller.dart';
import '../models/login_user_model.dart';
import '../models/register_user_model.dart';

class AuthPage extends StatefulWidget {
  static const String routeName = "/auth";
  final AuthController controller;
  const AuthPage({
    super.key,
    required this.controller,
  });

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late AuthPageState _currentPageState;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordConfirmationController;
  late FocusNode _nameFocus;
  late FocusNode _emailFocus;
  late FocusNode _passwordFocus;
  late FocusNode _passwordConfirmationFocus;
  bool _hasAcceptedTermsOfUse = false;

  @override
  void initState() {
    _currentPageState = AuthPageState.login;
    _nameController = TextEditingController();
    _emailController = TextEditingController(
      text: kDebugMode ? 'testing@investhelper.com' : null,
    );
    _passwordController = TextEditingController();
    _passwordConfirmationController = TextEditingController();
    _nameFocus = FocusNode();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
    _passwordConfirmationFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _passwordConfirmationFocus.dispose();
    super.dispose();
  }

  static void _hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  Future<void> _makeLogin(bool withGoogle) async {
    try {
      if (withGoogle) {
        if (!_hasAcceptedTermsOfUse) {
          await _showTermsAndPolicy();
          if (!_hasAcceptedTermsOfUse || !mounted) return;
        }

        LoadingWidget.dialog(context);
        await widget.controller.makeLoginWithGoogle();
      } else {
        LoadingWidget.dialog(context);
        await widget.controller.makeLogin(
          LoginUserModel(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          ),
        );
      }

      if (!mounted) return;
      LoadingWidget.hide(context);
      if (widget.controller.user != null) {
        if (DateTimeUtils.isToday(widget.controller.user!.data.registerDate)) {
          await Navigator.of(context).pushNamed(SubscriptionPage.routeName);
        }

        if (!mounted) return;
        Navigator.of(context).pop();
      }
    } on AppException catch (e) {
      if (!mounted) return;
      LoadingWidget.hide(context);
      await e.show(context);
    } catch (_) {
      if (!mounted) return;
      LoadingWidget.hide(context);
    }
  }

  Future<void> _makeRegister() async {
    if (!_hasAcceptedTermsOfUse) {
      await _showTermsAndPolicy();
      if (!_hasAcceptedTermsOfUse || !mounted) return;
    }

    try {
      LoadingWidget.dialog(context);

      await widget.controller.makeRegister(
        RegisterUserModel(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          passwordConfirmation: _passwordConfirmationController.text.trim(),
        ),
      );

      if (!mounted) return;
      LoadingWidget.hide(context);
      if (widget.controller.user != null) {
        if (DateTimeUtils.isToday(widget.controller.user!.data.registerDate)) {
          await Navigator.of(context).pushNamed(SubscriptionPage.routeName);
        }

        if (!mounted) return;
        Navigator.of(context).pop();
      }
    } on AppException catch (e) {
      if (!mounted) return;
      LoadingWidget.hide(context);
      await e.show(context);
    }
  }

  Future<void> _sendRecoveryEmail() async {
    try {
      LoadingWidget.dialog(context);

      await widget.controller.sendRecoveryEmail(
        _emailController.text.trim(),
      );

      if (!mounted) return;
      LoadingWidget.hide(context);
      await DialogWidget.show(
        context,
        title: AppLocalizations.of(context)!.recoveryEmailSentTitle,
        message: AppLocalizations.of(context)!.recoveryEmailSentMessage,
        actionType: DialogWidgetActionType.close,
      ).then((_) {
        setState(() {
          _currentPageState = AuthPageState.login;
        });
      });
    } on AppException catch (e) {
      if (!mounted) return;
      LoadingWidget.hide(context);
      await e.show(context);
    }
  }

  Future<void> _showTermsAndPolicy() async {
    final bool? result = await DialogWidget.show(
      context,
      title: AppLocalizations.of(context)!.termsOfUseTitle,
      message: AppLocalizations.of(context)!.termsOfUseMessage,
      messageWidget: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: widget.controller.openTermsUrl,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: FittedBox(
            child: Text(
              AppLocalizations.of(context)!.termsOfUseTitle,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
      actionType: DialogWidgetActionType.acceptOrNotAccept,
    );
    setState(() => _hasAcceptedTermsOfUse = result == true);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _hideKeyboard,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  SettingsPage.routeName,
                  arguments: true,
                );
              },
              icon: const Icon(CupertinoIcons.settings),
            ).animate().rotate(duration: const Duration(milliseconds: 300)),
          ],
        ),
        body: SafeArea(
          top: false,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: SizedBox(
                        height: 250,
                        child: Lottie.asset('assets/animations/auth.json'),
                      ),
                    )
                        .animate()
                        .fade(duration: const Duration(milliseconds: 400))
                        .slideY(duration: const Duration(milliseconds: 200)),
                    switch (_currentPageState) {
                      AuthPageState.login => _loginStateContent,
                      AuthPageState.register => _registerStateContent,
                      AuthPageState.recovery => _recoveryStateContent,
                    }
                        .animate()
                        .fade(duration: const Duration(milliseconds: 400))
                        .slideX(duration: const Duration(milliseconds: 200)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _loginStateContent {
    return Column(
      children: [
        _titleWidget(
          title: AppLocalizations.of(context)!.authPageLoginTitle,
          subTitle: AppLocalizations.of(context)!.authPageLoginSubtitle,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          child: ElevatedButton.icon(
            onPressed: () => _makeLogin(true),
            icon: Image.asset(
              'assets/images/google_icon.png',
              height: 24,
              width: 24,
            ),
            label: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(AppLocalizations.of(context)!.continueWithGoogle),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(15),
              minimumSize: const Size(double.infinity, 0),
              foregroundColor: Colors.black,
              backgroundColor: Colors.grey.shade200,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Divider(height: 0, color: Colors.grey),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            children: [
              _emailTextField,
              const SizedBox(height: 10),
              _passwordTextField,
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextButton(
                    onPressed: () => setState(() {
                      _currentPageState = AuthPageState.recovery;
                    }),
                    child: Text(AppLocalizations.of(context)!.forgotMyPassword),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () => _makeLogin(false),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    AppLocalizations.of(context)!.makeLogin,
                  ),
                ),
              ),
            ],
          ),
        ),
        _changeStateButtonWidget(
          text: AppLocalizations.of(context)!.dontHaveAnAccountYet,
          highlightedText: AppLocalizations.of(context)!.register,
          onTap: () => setState(() {
            _currentPageState = AuthPageState.register;
          }),
        ),
      ],
    );
  }

  Widget get _registerStateContent {
    return Column(
      children: [
        _titleWidget(
          title: AppLocalizations.of(context)!.authPageRegisterTitle,
          subTitle: AppLocalizations.of(context)!.authPageRegisterSubtitle,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            children: [
              _nameTextField,
              const SizedBox(height: 10),
              _emailTextField,
              const SizedBox(height: 10),
              _passwordTextField,
              const SizedBox(height: 10),
              _passwordConfirmationTextField,
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: _makeRegister,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(AppLocalizations.of(context)!.makeRegister),
                ),
              ),
            ],
          ),
        ),
        _changeStateButtonWidget(
          text: AppLocalizations.of(context)!.alreadyHaveAnAccount,
          highlightedText: AppLocalizations.of(context)!.login,
          onTap: () => setState(() {
            _currentPageState = AuthPageState.login;
          }),
        ),
      ],
    );
  }

  Widget get _recoveryStateContent {
    return Column(
      children: [
        _titleWidget(
          title: AppLocalizations.of(context)!.authPageRecoveryTitle,
          subTitle: AppLocalizations.of(context)!.authPageRecoverySubtitle,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            children: [
              _emailTextField,
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: _sendRecoveryEmail,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    AppLocalizations.of(context)!.sendRecoveryEmail,
                  ),
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() => _currentPageState = AuthPageState.login);
          },
          child: Text(AppLocalizations.of(context)!.authPageLoginTitle),
        ),
      ],
    );
  }

  Widget _titleWidget({
    required String title,
    required String subTitle,
  }) {
    return Column(
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 5),
        Text(
          subTitle,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        _termsWidget,
      ],
    );
  }

  Widget get _nameTextField {
    return TextFieldWidget(
      label: AppLocalizations.of(context)!.name,
      hint: AppLocalizations.of(context)!.nameHint,
      focusNode: _nameFocus,
      controller: _nameController,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => _emailFocus.requestFocus(),
    );
  }

  Widget get _emailTextField {
    return TextFieldWidget(
      label: AppLocalizations.of(context)!.email,
      hint: AppLocalizations.of(context)!.emailHint,
      focusNode: _emailFocus,
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: _currentPageState != AuthPageState.recovery
          ? TextInputAction.next
          : TextInputAction.done,
      onFieldSubmitted: (_) {
        if (_currentPageState == AuthPageState.recovery) {
          _sendRecoveryEmail();
        } else if (_passwordFocus.canRequestFocus) {
          _passwordFocus.requestFocus();
        }
      },
    );
  }

  Widget get _passwordTextField {
    return TextFieldWidget(
      label: AppLocalizations.of(context)!.password,
      hint: AppLocalizations.of(context)!.passwordHint,
      focusNode: _passwordFocus,
      controller: _passwordController,
      obscureText: true,
      keyboardType: TextInputType.text,
      textInputAction: _currentPageState != AuthPageState.login
          ? TextInputAction.next
          : TextInputAction.done,
      onFieldSubmitted: (_) {
        if (_currentPageState == AuthPageState.login) {
          _makeLogin(false);
        } else if (_passwordConfirmationFocus.canRequestFocus) {
          _passwordConfirmationFocus.requestFocus();
        }
      },
    );
  }

  Widget get _passwordConfirmationTextField {
    return TextFieldWidget(
      label: AppLocalizations.of(context)!.passwordConfirmation,
      hint: AppLocalizations.of(context)!.passwordConfirmationHint,
      focusNode: _passwordConfirmationFocus,
      controller: _passwordConfirmationController,
      obscureText: true,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) => _makeRegister(),
    );
  }

  Widget get _termsWidget {
    return InkWell(
      onTap: widget.controller.openTermsUrl,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Text(
          AppLocalizations.of(context)!.termsOfUseTitle,
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }

  Widget _changeStateButtonWidget({
    required String text,
    required String highlightedText,
    required void Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 5),
            Text(
              highlightedText,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: Theme.of(context).primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}

enum AuthPageState {
  login,
  register,
  recovery,
}
