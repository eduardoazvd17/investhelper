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

  static String dateWithDay(BuildContext context, DateTime date) {
    final String languageCode = Localizations.localeOf(context).languageCode;
    if (languageCode == 'pt') {
      return DateFormat.yMMMEd('pt_BR').format(date);
    }
    return DateFormat.yMMMEd().format(date);
  }

  static String textFieldInteger(String value) {
    final String newValue = value.replaceFirst(RegExp(r'^0+(?=[0-9])'), '');
    return newValue.replaceAll(RegExp(r'[^\d]'), '');
  }

  static String textFieldCurrency(String value) {
    final String replaceComma = value.trim().replaceAll(',', '.');
    String formattedNumbers = replaceComma.replaceAll(RegExp(r'[^\d.]'), '');

    final split = formattedNumbers.split('.');
    final float =
        split.last.length > 2 ? split.last.substring(0, 2) : split.last;

    if (split.length > 2) {
      formattedNumbers = '${split.sublist(0, split.length).join()}.$float';
    } else if (split.length == 2) {
      formattedNumbers = '${split.first}.$float';
    }

    return formattedNumbers;
  }

  static String cryptoFloat(String value) {
    final String removeLeftZero =
        value.replaceFirst(RegExp(r'^0+(?=[0-9])'), '');
    final String replaceComma = removeLeftZero.replaceAll(',', '.');
    String formattedNumbers = replaceComma.replaceAll(RegExp(r'[^\d.]'), '');
    if (formattedNumbers.contains('.')) {
      final split = formattedNumbers.split('.');
      final float = split.last;
      split.removeLast();
      return '${split.join()}.$float';
    } else {
      return formattedNumbers;
    }
  }

  static String ticker(String value) {
    final RegExp tickerRegex = RegExp(
      r'[a-zA-Z]{4}(([1-9]{1}[0-1]{1})|[1-9]{1})',
    );

    String newValue = value;
    if (tickerRegex.hasMatch(newValue)) {
      for (final match in tickerRegex.allMatches(newValue)) {
        final String matchString = match.group(0) ?? '';
        newValue = newValue.replaceAll(
          matchString,
          matchString.toUpperCase(),
        );
      }
    }
    return newValue;
  }
}
