import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'ventes.dart';
import 'produits.dart';

class VenteDetails extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get pharmacieId => text()();
  TextColumn get venteId => text().references(Ventes, #id)();
  TextColumn get produitId => text().references(Produits, #id)();
  IntColumn get quantite => integer()();
  RealColumn get prixUnitaire => real()();
  RealColumn get sousTotal => real()();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
