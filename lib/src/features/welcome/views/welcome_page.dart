import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

import '../../../core/controllers/app_controller.dart';
import '../../../l10n/l10n.dart';
import '../../investments/views/investments_page.dart';
import '../../settings/views/settings_page.dart';

class WelcomePage extends StatefulWidget {
  static const String routeName = "/welcome";
  final AppController appController;
  const WelcomePage({super.key, required this.appController});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  late PageController _pageViewController;
  int _currentPage = 0;

  @override
  void initState() {
    _pageViewController = PageController();
    _pageViewController.addListener(() {
      final int page = _pageViewController.page?.round() ?? 0;
      if (page != _currentPage) {
        setState(() => _currentPage = page);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appName),
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
      body: PageView(controller: _pageViewController, children: _pageViewPages),
      bottomNavigationBar: _navigationBar,
    );
  }

  Widget get _navigationBar => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: _currentPage > 0
                    ? () => _pageViewController.animateToPage(
                          _currentPage - 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        )
                    : null,
                child: Text(AppLocalizations.of(context)!.back),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(_pageViewPages.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      child: Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index == _currentPage
                              ? Theme.of(context).primaryColor
                              : Colors.grey[300],
                        ),
                      ),
                    ),
                  );
                }),
              ),
              TextButton(
                onPressed: _currentPage < _pageViewPages.length - 1
                    ? () => _pageViewController.animateToPage(
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

  List<Widget> get _pageViewPages {
    Widget pageWidget({
      required String lottieAsset,
      required String contentText,
      Widget? bottomWidget,
    }) {
      return Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .4,
                child: Center(child: Lottie.asset(lottieAsset)),
              )
                  .animate()
                  .fade(duration: const Duration(milliseconds: 400))
                  .slideY(duration: const Duration(milliseconds: 200)),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Text(
                  contentText,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              if (bottomWidget != null) bottomWidget,
            ],
          ),
        ),
      );
    }

    return [
      pageWidget(
        lottieAsset: 'assets/animations/investments.json',
        contentText: AppLocalizations.of(context)!.welcomeText1,
      ).animate().fade(),
      pageWidget(
        lottieAsset: 'assets/animations/monitoring.json',
        contentText: AppLocalizations.of(context)!.welcomeText2,
      ).animate().fade(),
      pageWidget(
        lottieAsset: 'assets/animations/saving_time.json',
        contentText: AppLocalizations.of(context)!.welcomeText3,
        bottomWidget: ElevatedButton(
          onPressed: () {
            widget.appController.disableWelcomePage();
            Navigator.of(context)
                .pushReplacementNamed(InvestmentsPage.routeName);
          },
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Text(AppLocalizations.of(context)!.letsStart),
          ),
        ),
      ).animate().fade(),
    ];
  }
}
