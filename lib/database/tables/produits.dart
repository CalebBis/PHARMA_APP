import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'categories.dart';

class Produits extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get pharmacieId => text()();
  TextColumn get nom => text()();
  TextColumn get categorieId => text().nullable().references(Categories, #id)();
  RealColumn get prixAchat => real()();
  RealColumn get prixVente => real()();
  IntColumn get quantiteStock => integer()();
  IntColumn get seuilAlerte => integer()();
  DateTimeColumn get datePeremption => dateTime().nullable()();
  DateTimeColumn get dateCreation => dateTime()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
