import 'package:flutter/material.dart';
import 'package:investmentmanager/src/l10n/l10n.dart';
import 'package:lottie/lottie.dart';

import '../../auth/views/auth_page.dart';

class WelcomePage extends StatefulWidget {
  static const String routeName = "/welcome";
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    _pageController = PageController();
    _pageController.addListener(() {
      final int page = _pageController.page?.round() ?? 0;
      if (page != _currentPage) {
        setState(() => _currentPage = page);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.appName)),
      body: PageView(controller: _pageController, children: _pages),
      bottomNavigationBar: _navigationBar,
    );
  }

  List<Widget> get _pages => [
        _firstPageContent,
        _secondPageContent,
        _thirdPageContent,
      ];

  Widget get _navigationBar => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: _currentPage > 0
                    ? () => _pageController.animateToPage(
                          _currentPage - 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        )
                    : null,
                child: Text(AppLocalizations.of(context)!.back),
              ),
              Text('${_currentPage + 1} / ${_pages.length}'),
              TextButton(
                onPressed: _currentPage < _pages.length - 1
                    ? () => _pageController.animateToPage(
                          _currentPage + 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        )
                    : null,
                child: Text(AppLocalizations.of(context)!.next),
              ),
            ],
          ),
        ),
      );

  Widget get _firstPageContent => Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _resizeAnimation(
                Lottie.asset("assets/animations/investments.json"),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Text(
                  AppLocalizations.of(context)!.welcomeText1,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );

  Widget get _secondPageContent => Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _resizeAnimation(
                Lottie.asset("assets/animations/monitoring.json"),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Text(
                  AppLocalizations.of(context)!.welcomeText2,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );

  Widget get _thirdPageContent => Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _resizeAnimation(
                Lottie.asset("assets/animations/saving_time.json"),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Text(
                  AppLocalizations.of(context)!.welcomeText3,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(AuthPage.routeName);
                },
                child: Text(AppLocalizations.of(context)!.letsStart),
              ),
            ],
          ),
        ),
      );

  Widget _resizeAnimation(LottieBuilder animation) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .4,
      child: Center(child: animation),
    );
  }
}
