import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_formatter.dart';

class DatePickerWidget extends StatefulWidget {
  final String label;
  final DateTime value;
  final DateTime? minDate;
  final void Function(DateTime) onChange;
  const DatePickerWidget({
    super.key,
    required this.label,
    required this.value,
    this.minDate,
    required this.onChange,
  });

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  late DateTime _selectedDate;

  @override
  void initState() {
    _selectedDate = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: FittedBox(
                  child: Text(
                    AppFormatter.dateWithDay(context, _selectedDate),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  final now = DateTime.now();
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    currentDate: _selectedDate,
                    firstDate: widget.minDate ?? DateTime(2000),
                    lastDate: now,
                  );

                  if (selectedDate != null) {
                    if (widget.minDate != null &&
                        widget.minDate!.month == selectedDate.year &&
                        widget.minDate!.month == selectedDate.month &&
                        widget.minDate!.day == selectedDate.day) {
                      selectedDate = DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        widget.minDate!.hour,
                        widget.minDate!.minute,
                        widget.minDate!.second,
                        widget.minDate!.millisecond + 1,
                      );
                    } else {
                      selectedDate = DateTime(
                        selectedDate.year,
                        selectedDate.month,
                        selectedDate.day,
                        now.hour,
                        now.minute,
                        now.second,
                        now.millisecond,
                      );
                    }
                  }

                  setState(() {
                    _selectedDate = selectedDate ?? DateTime.now();
                  });
                  widget.onChange.call(_selectedDate);
                },
                icon: const Icon(CupertinoIcons.calendar),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
