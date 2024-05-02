import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AdviseMessageWidget extends StatelessWidget {
  final String message;
  const AdviseMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10, right: 20),
          child: Icon(Icons.info_outline),
        )
            .animate()
            .fade(duration: const Duration(milliseconds: 400))
            .slideX(duration: const Duration(milliseconds: 200)),
        Expanded(child: Text(message))
            .animate()
            .fade(duration: const Duration(milliseconds: 400))
            .slideY(duration: const Duration(milliseconds: 200))
      ],
    );
  }
}
