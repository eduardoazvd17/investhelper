import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppFormat {
  static String currency(BuildContext context, double value) {
    return NumberFormat.simpleCurrency(
      locale: Localizations.localeOf(context).countryCode,
    ).format(value);
  }
}
