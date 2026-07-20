import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String format(double amount) {
    final format = NumberFormat.currency(
      locale: 'fr_FR',
      symbol: 'FC',
      decimalDigits: 0, // usually Congolese Francs do not use decimals
    );
    return format.format(amount);
  }
}
