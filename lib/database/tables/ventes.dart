import 'package:drift/drift.dart';

class Ventes extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get dateVente => dateTime()();
  RealColumn get montantTotal => real()();
  TextColumn get modePaiement => text()(); // Espèces, Carte, etc.
}
