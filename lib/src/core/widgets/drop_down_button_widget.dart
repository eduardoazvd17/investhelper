import 'package:flutter/material.dart';

class DropDownButtonWidget<T> extends StatefulWidget {
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
  State<DropDownButtonWidget<T>> createState() =>
      _DropDownButtonWidgetState<T>();
}

class _DropDownButtonWidgetState<T> extends State<DropDownButtonWidget<T>> {
  T? _selectedItem;

  @override
  void initState() {
    _selectedItem = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        DropdownButton<T>(
          value: _selectedItem,
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
          items: widget.items,
          onChanged: (value) {
            setState(() => _selectedItem = value);
            widget.onChanged.call(value);
          },
        ),
      ],
    );
  }
}
