import 'package:drift/drift.dart';
import 'ventes.dart';

class Factures extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get venteId => integer().references(Ventes, #id)();
  TextColumn get numeroFacture => text().unique()();
  DateTimeColumn get dateEmission => dateTime()();
  TextColumn get cheminPdf => text().nullable()();
}
