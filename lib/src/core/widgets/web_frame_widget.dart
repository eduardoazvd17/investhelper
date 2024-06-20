import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../utils/app_theme.dart';

class WebFrameWidget extends StatelessWidget {
  final ThemeMode? themeMode;
  final Widget child;

  const WebFrameWidget({
    super.key,
    this.themeMode,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr, // ou TextDirection.rtl se necessário
      child: Scaffold(
        backgroundColor: switch (themeMode) {
          null ||
          ThemeMode.system =>
            SchedulerBinding.instance.platformDispatcher.platformBrightness ==
                    Brightness.dark
                ? AppTheme.kSecondaryDarkBackgroundColor
                : AppTheme.kSecondaryLightBackgroundColor,
          ThemeMode.light => AppTheme.kSecondaryLightBackgroundColor,
          ThemeMode.dark => AppTheme.kSecondaryDarkBackgroundColor,
        },
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                if (constraints.maxWidth > 500)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: constraints.maxHeight * .1,
                    ),
                  ),
                Expanded(
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 16,
                            offset: const Offset(0, 0),
                            color: AppTheme.kShadowColor,
                          ),
                        ],
                      ),
                      child: SizedBox(
                        width: 500,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 500),
                          child: ClipRRect(
                            borderRadius: constraints.maxWidth > 500
                                ? BorderRadius.circular(14)
                                : BorderRadius.zero,
                            child: child,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
