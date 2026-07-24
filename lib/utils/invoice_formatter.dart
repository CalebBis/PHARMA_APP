import 'package:intl/intl.dart';

class InvoiceFormatter {
  /// Formate la date de création de la facture pour afficher un numéro court.
  /// Exemple: FACT-24072026-1433
  static String formatShort(DateTime date) {
    final dateFormat = DateFormat('ddMMyyyy-HHmm');
    return 'FACT-${dateFormat.format(date)}';
  }
}
