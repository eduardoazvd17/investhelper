import 'package:flutter/material.dart';

class DropdownButtonWidget<T> extends StatefulWidget {
  final String? label;
  final T? value;
  final String? hint;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?) onChanged;
  const DropdownButtonWidget({
    super.key,
    this.label,
    this.value,
    this.hint,
    required this.items,
    required this.onChanged,
  });

  @override
  State<DropdownButtonWidget<T>> createState() =>
      _DropdownButtonWidgetState<T>();
}

class _DropdownButtonWidgetState<T> extends State<DropdownButtonWidget<T>> {
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
        if (widget.label != null)
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              widget.label!,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        DropdownButton<T>(
          value: _selectedItem,
          isExpanded: true,
          elevation: 24,
          iconSize: 35,
          itemHeight: MediaQuery.of(context).textScaler.scale(60),
          borderRadius: BorderRadius.circular(10),
          underline: const SizedBox(),
          style: Theme.of(context).textTheme.bodyLarge,
          hint: widget.hint != null ? Text(widget.hint!) : null,
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 5,
            bottom: 5,
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
