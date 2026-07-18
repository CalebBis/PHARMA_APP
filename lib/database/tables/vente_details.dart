import 'package:drift/drift.dart';
import 'ventes.dart';
import 'produits.dart';

class VenteDetails extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get venteId => integer().references(Ventes, #id)();
  IntColumn get produitId => integer().references(Produits, #id)();
  IntColumn get quantite => integer()();
  RealColumn get prixUnitaire => real()();
  RealColumn get sousTotal => real()();
}
