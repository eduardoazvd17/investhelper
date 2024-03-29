import 'package:flutter/material.dart';
import 'package:investhelper/src/core/exceptions/app_exception.dart';
import 'package:investhelper/src/features/auth/models/login_user_model.dart';
import 'package:investhelper/src/features/auth/models/register_user_model.dart';
import 'package:investhelper/src/features/investments/views/investments_page.dart';
import 'package:investhelper/src/l10n/l10n.dart';
import 'package:lottie/lottie.dart';

import '../controllers/auth_controller.dart';

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

  @override
  void initState() {
    _currentPageState = AuthPageState.login;
    _nameController = TextEditingController();
    _emailController = TextEditingController();
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

  Future<void> _makeLogin() async {
    try {
      await widget.controller.makeLogin(
        LoginUserModel(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(InvestmentsPage.routeName);
    } on AppException catch (e) {
      await e.show(context);
    }
  }

  Future<void> _makeRegister() async {
    try {
      await widget.controller.makeRegister(
        RegisterUserModel(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          passwordConfirmation: _passwordConfirmationController.text.trim(),
        ),
      );
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(InvestmentsPage.routeName);
    } on AppException catch (e) {
      await e.show(context);
    }
  }

  Future<void> _makeRecovery() async {
    try {
      await widget.controller.sendRecoveryEmail(_emailController.text.trim());
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.recoveryEmailSentTitle),
          content: Text(AppLocalizations.of(context)!.recoveryEmailSentMessage),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: Text(AppLocalizations.of(context)!.close),
            ),
          ],
        ),
      );
    } on AppException catch (e) {
      await e.show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: SizedBox(
                      height: 250,
                      child: Lottie.asset('assets/animations/auth.json'),
                    ),
                  ),
                  switch (_currentPageState) {
                    AuthPageState.login => _loginStateContent,
                    AuthPageState.register => _registerStateContent,
                    AuthPageState.recovery => _recoveryStateContent,
                  },
                ],
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
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Column(
            children: [
              _emailTextField,
              const SizedBox(height: 10),
              _passwordTextField,
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _makeLogin,
                child: Text(
                  AppLocalizations.of(context)!.makeLogin,
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => setState(() {
                  _currentPageState = AuthPageState.recovery;
                }),
                child: Text(AppLocalizations.of(context)!.forgotMyPassword),
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
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Column(
            children: [
              _nameTextField,
              const SizedBox(height: 10),
              _emailTextField,
              const SizedBox(height: 10),
              _passwordTextField,
              const SizedBox(height: 10),
              _passwordConfirmationTextField,
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _makeRegister,
                child: Text(AppLocalizations.of(context)!.makeRegister),
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
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Column(
            children: [
              _emailTextField,
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _makeRecovery,
                child: Text(
                  AppLocalizations.of(context)!.makeRecovery,
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
      ],
    );
  }

  Widget get _nameTextField {
    return TextFormField(
      focusNode: _nameFocus,
      controller: _nameController,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        label: Text(AppLocalizations.of(context)!.name),
        hintText: AppLocalizations.of(context)!.nameHint,
        border: const OutlineInputBorder(),
      ),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => _emailFocus.requestFocus(),
    );
  }

  Widget get _emailTextField {
    final bool hasNext = _passwordFocus.canRequestFocus;
    return TextFormField(
      focusNode: _emailFocus,
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        label: Text(AppLocalizations.of(context)!.email),
        hintText: AppLocalizations.of(context)!.emailHint,
        border: const OutlineInputBorder(),
      ),
      textInputAction: hasNext ? TextInputAction.next : TextInputAction.done,
      onFieldSubmitted: hasNext ? (_) => _passwordFocus.requestFocus() : null,
    );
  }

  Widget get _passwordTextField {
    final bool hasNext = _passwordConfirmationFocus.canRequestFocus;
    return TextFormField(
      focusNode: _passwordFocus,
      controller: _passwordController,
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        label: Text(AppLocalizations.of(context)!.password),
        hintText: AppLocalizations.of(context)!.passwordHint,
        border: const OutlineInputBorder(),
      ),
      textInputAction: hasNext ? TextInputAction.next : TextInputAction.done,
      onFieldSubmitted:
          hasNext ? (_) => _passwordConfirmationFocus.requestFocus() : null,
    );
  }

  Widget get _passwordConfirmationTextField {
    return TextFormField(
      focusNode: _passwordConfirmationFocus,
      controller: _passwordConfirmationController,
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        label: Text(AppLocalizations.of(context)!.passwordConfirmation),
        hintText: AppLocalizations.of(context)!.passwordConfirmationHint,
        border: const OutlineInputBorder(),
      ),
      textInputAction: TextInputAction.done,
    );
  }

  Widget _changeStateButtonWidget({
    required String text,
    required String highlightedText,
    required void Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
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
