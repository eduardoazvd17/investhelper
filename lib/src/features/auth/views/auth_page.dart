import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:investmentmanager/src/features/investments/views/investments_page.dart';
import 'package:investmentmanager/src/l10n/l10n.dart';
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
                  _titleWidget,
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: _formWidget,
                  ),
                  _bottomWidget,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _titleWidget {
    late final String title;
    late final String subtitle;

    switch (_currentPageState) {
      case AuthPageState.login:
        title = AppLocalizations.of(context)!.authPageLoginTitle;
        subtitle = AppLocalizations.of(context)!.authPageLoginSubtitle;
      case AuthPageState.register:
        title = AppLocalizations.of(context)!.authPageRegisterTitle;
        subtitle = AppLocalizations.of(context)!.authPageRegisterSubtitle;
      case AuthPageState.recovery:
        title = AppLocalizations.of(context)!.authPageRecoveryTitle;
        subtitle = AppLocalizations.of(context)!.authPageRecoverySubtitle;
    }

    return Column(
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget get _formWidget {
    final TextButton actionButton = switch (_currentPageState) {
      AuthPageState.login => TextButton(
          onPressed: () {
            Navigator.of(context)
                .pushReplacementNamed(InvestmentsPage.routeName);
          },
          child: Text(
            AppLocalizations.of(context)!.makeLogin,
          ),
        ),
      AuthPageState.register => TextButton(
          onPressed: () {},
          child: Text(
            AppLocalizations.of(context)!.makeRegister,
          ),
        ),
      AuthPageState.recovery => TextButton(
          onPressed: () {},
          child: Text(
            AppLocalizations.of(context)!.makeRecovery,
          ),
        ),
    };

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
        actionButton,
        if (_currentPageState == AuthPageState.login) ...[
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              setState(() {
                _currentPageState = AuthPageState.recovery;
              });
            },
            child: Text(AppLocalizations.of(context)!.forgotMyPassword),
          ),
        ],
      ],
    );
  }

  Widget get _bottomWidget {
    switch (_currentPageState) {
      case AuthPageState.login:
        return InkWell(
          onTap: () {
            setState(() => _currentPageState = AuthPageState.register);
          },
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.dontHaveAnAccountYet,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 5),
                Text(
                  AppLocalizations.of(context)!.register,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ),
        );
      case AuthPageState.register:
        return InkWell(
          onTap: () {
            setState(() => _currentPageState = AuthPageState.login);
          },
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.alreadyHaveAnAccount,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 5),
                Text(
                  AppLocalizations.of(context)!.login,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ),
        );
      case AuthPageState.recovery:
        return TextButton(
          onPressed: () {
            setState(() => _currentPageState = AuthPageState.login);
          },
          child: Text(AppLocalizations.of(context)!.authPageLoginTitle),
        );
    }
  }
}

enum AuthPageState {
  login,
  register,
  recovery,
}
