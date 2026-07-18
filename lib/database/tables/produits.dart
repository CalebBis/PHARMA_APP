import 'package:drift/drift.dart';
import 'categories.dart';

class Produits extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nom => text()();
  IntColumn get categorieId => integer().references(Categories, #id)();
  RealColumn get prixAchat => real()();
  RealColumn get prixVente => real()();
  IntColumn get quantiteStock => integer()();
  IntColumn get seuilAlerte => integer()();
  DateTimeColumn get datePeremption => dateTime().nullable()();
  DateTimeColumn get dateCreation => dateTime()();
}
