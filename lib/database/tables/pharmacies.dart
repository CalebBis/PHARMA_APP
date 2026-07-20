import 'package:drift/drift.dart';

class Pharmacies extends Table {
  TextColumn get id => text()();          // id Supabase (UUID)
  TextColumn get nom => text()();
  TextColumn get logoUrl => text().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
