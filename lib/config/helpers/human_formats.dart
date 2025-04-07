import 'package:intl/intl.dart';

class HumanFormats {
  static String number(double number) {
    final formatNumber = NumberFormat.compactCurrency(
        decimalDigits: 0, locale: 'en_US', symbol: '');
    return formatNumber.format(number);
  }
}
