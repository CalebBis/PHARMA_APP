import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'ventes.dart';

class Factures extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get pharmacieId => text()();
  TextColumn get venteId => text().references(Ventes, #id)();
  TextColumn get numeroFacture => text().unique()();
  DateTimeColumn get dateEmission => dateTime()();
  TextColumn get cheminPdf => text().nullable()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
