import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyListWidget extends StatelessWidget {
  final String message;
  const EmptyListWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    const double animationSize = 120;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: animationSize,
          child: Lottie.asset(
            'assets/animations/not_found.json',
          ),
        ),
        Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Colors.grey),
        ),
        const SizedBox(height: animationSize / 2),
      ],
    );
  }
}
