import 'package:flutter/material.dart';

class DropDownButtonWidget<T> extends StatelessWidget {
  final String label;
  final T? value;
  final String? hint;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;
  const DropDownButtonWidget({
    super.key,
    required this.label,
    this.value,
    this.hint,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        DropdownButton<T>(
          value: value,
          isExpanded: true,
          elevation: 24,
          iconSize: 35,
          borderRadius: BorderRadius.circular(10),
          underline: const SizedBox(),
          style: Theme.of(context).textTheme.bodyLarge,
          padding: const EdgeInsets.only(
            left: 17,
            right: 32,
            top: 10,
            bottom: 10,
          ),
          items: items,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
