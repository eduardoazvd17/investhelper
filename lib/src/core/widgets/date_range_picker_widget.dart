import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/app_formatter.dart';

class DateRangePickerWidget extends StatefulWidget {
  final String label;
  final DateTime startDate;
  final DateTime endDate;
  final int maxInterval;
  final void Function(DateTime start, DateTime end) onChange;
  const DateRangePickerWidget({
    super.key,
    required this.label,
    required this.startDate,
    required this.endDate,
    this.maxInterval = 30,
    required this.onChange,
  });

  @override
  State<DateRangePickerWidget> createState() => _DateRangePickerWidgetState();
}

class _DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  late DateTime _selectedStartDate;
  late DateTime _selectedEndDate;

  @override
  void initState() {
    _selectedStartDate = widget.startDate;
    _selectedEndDate = widget.endDate;
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: Text(
                        AppFormatter.dateWithDay(context, _selectedStartDate),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        AppFormatter.dateWithDay(context, _selectedEndDate),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () async {
                  final now = DateTime.now();

                  DateTimeRange? selectedRange = await showDateRangePicker(
                    context: context,
                    initialDateRange: DateTimeRange(
                      start: _selectedStartDate,
                      end: _selectedEndDate,
                    ),
                    firstDate: DateTime(2000),
                    lastDate: now,
                  );

                  if (selectedRange != null) {
                    setState(() {
                      _selectedStartDate = selectedRange.start;
                      _selectedEndDate = selectedRange.end;
                    });
                    widget.onChange.call(_selectedStartDate, _selectedEndDate);
                  }
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
