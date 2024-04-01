import 'package:flutter/material.dart';

import '../models/daily_tip_model.dart';

class DailyTipsWidget extends StatelessWidget {
  final DailyTipModel dailyTip;
  const DailyTipsWidget({super.key, required this.dailyTip});

  @override
  Widget build(BuildContext context) {
    final String languageCode = Localizations.localeOf(context).languageCode;

    final String title = (languageCode == "pt")
        ? dailyTip.portugueseTitle
        : dailyTip.englishTitle;

    final String message = (languageCode == "pt")
        ? dailyTip.portugueseMessage
        : dailyTip.englishMessage;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(message, style: Theme.of(context).textTheme.titleSmall),
          ],
        ),
      ),
    );
  }
}
