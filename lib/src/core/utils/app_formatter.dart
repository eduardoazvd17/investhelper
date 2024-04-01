import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppFormatter {
  static String currency(BuildContext context, double value) {
    final countryCode =
        WidgetsBinding.instance.platformDispatcher.locale.countryCode;
    if (countryCode == 'BR') {
      return NumberFormat.simpleCurrency(locale: 'pt_BR').format(value);
    }
    return NumberFormat.simpleCurrency().format(value);
  }
}
