import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

class Ventes extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get pharmacieId => text()();
  DateTimeColumn get dateVente => dateTime()();
  RealColumn get montantTotal => real()();
  TextColumn get modePaiement => text()(); // Espèces, Carte, etc.
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
