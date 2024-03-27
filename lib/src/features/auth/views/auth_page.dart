import 'package:flutter/material.dart';
import 'package:investhelper/src/features/investments/views/investments_page.dart';
import 'package:investhelper/src/l10n/l10n.dart';
import 'package:lottie/lottie.dart';

class AuthPage extends StatefulWidget {
  static const String routeName = "/auth";
  final AuthPageState authPageState;
  const AuthPage({
    super.key,
    this.authPageState = AuthPageState.login,
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

  @override
  void initState() {
    _currentPageState = widget.authPageState;
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordConfirmationController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    super.dispose();
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
          child: _formWidget(_currentPageState),
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
          child: _formWidget(_currentPageState),
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
          child: _formWidget(_currentPageState),
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

  Widget _formWidget(AuthPageState state) {
    return Column(
      children: [
        if (_currentPageState == AuthPageState.register) ...[
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              label: Text(AppLocalizations.of(context)!.name),
              hintText: AppLocalizations.of(context)!.nameHint,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
        ],
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            label: Text(AppLocalizations.of(context)!.email),
            hintText: AppLocalizations.of(context)!.emailHint,
            border: const OutlineInputBorder(),
          ),
        ),
        if (_currentPageState != AuthPageState.recovery) ...[
          const SizedBox(height: 10),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              label: Text(AppLocalizations.of(context)!.password),
              hintText: AppLocalizations.of(context)!.passwordHint,
              border: const OutlineInputBorder(),
            ),
          ),
        ],
        if (_currentPageState == AuthPageState.register) ...[
          const SizedBox(height: 10),
          TextFormField(
            controller: _passwordConfirmationController,
            obscureText: true,
            decoration: InputDecoration(
              label: Text(AppLocalizations.of(context)!.passwordConfirmation),
              hintText: AppLocalizations.of(context)!.passwordConfirmationHint,
              border: const OutlineInputBorder(),
            ),
          ),
        ],
        const SizedBox(height: 10),
        switch (state) {
          AuthPageState.login => ElevatedButton(
              onPressed: () => Navigator.of(context)
                  .pushReplacementNamed(InvestmentsPage.routeName),
              child: Text(
                AppLocalizations.of(context)!.makeLogin,
              ),
            ),
          AuthPageState.register => ElevatedButton(
              onPressed: () {},
              child: Text(
                AppLocalizations.of(context)!.makeRegister,
              ),
            ),
          AuthPageState.recovery => ElevatedButton(
              onPressed: () {},
              child: Text(
                AppLocalizations.of(context)!.makeRecovery,
              ),
            ),
        },
        if (_currentPageState == AuthPageState.login) ...[
          const SizedBox(height: 15),
          TextButton(
            onPressed: () => setState(() {
              _currentPageState = AuthPageState.recovery;
            }),
            child: Text(AppLocalizations.of(context)!.forgotMyPassword),
          ),
        ],
      ],
    );
  }
}

enum AuthPageState {
  login,
  register,
  recovery,
}
