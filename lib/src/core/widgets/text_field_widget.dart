import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String label;
  final String? hint;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final void Function(String)? onFieldSubmitted;
  final int maxLines;
  final bool enabled;
  final Widget? prefix;
  final void Function(String)? onChanged;
  const TextFieldWidget({
    super.key,
    this.focusNode,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    required this.label,
    this.hint,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.onFieldSubmitted,
    this.maxLines = 1,
    this.enabled = true,
    this.prefix,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5, left: 5),
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: TextFormField(
            enabled: enabled,
            maxLines: maxLines,
            focusNode: focusNode,
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hint,
              prefix: prefix,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            textInputAction: textInputAction,
            textCapitalization: textCapitalization,
            onFieldSubmitted: onFieldSubmitted,
          ),
        ),
      ],
    );
  }
}
