import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppFormatter {
  static String get currencyPrefix {
    final countryCode =
        WidgetsBinding.instance.platformDispatcher.locale.countryCode;
    return countryCode == 'BR' ? 'R\$' : "\$";
  }

  static String currency(double value) {
    final countryCode =
        WidgetsBinding.instance.platformDispatcher.locale.countryCode;
    if (countryCode == 'BR') {
      return NumberFormat.simpleCurrency(locale: 'pt_BR').format(value);
    }
    return NumberFormat.simpleCurrency().format(value);
  }

  static String date(BuildContext context, DateTime date) {
    final String languageCode = Localizations.localeOf(context).languageCode;
    if (languageCode == 'pt') {
      return DateFormat.yMMMd('pt_BR').format(date);
    }
    return DateFormat.yMMMd().format(date);
  }
}
