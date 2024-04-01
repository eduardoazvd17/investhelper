import 'package:flutter/material.dart';

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
        ),
        Expanded(child: Text(message))
      ],
    );
  }
}
