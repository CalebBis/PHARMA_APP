import 'package:drift/drift.dart';
import '../database/database.dart';
import 'package:uuid/uuid.dart';

class ProduitsRepository {
  final AppDatabase _db;
  final bool _isPharmacien;
  final String _pharmacieId;
  ProduitsRepository(this._db, this._isPharmacien, this._pharmacieId);

  Future<List<Produit>> getTousLesProduits() => (_db.select(_db.produits)
        ..where((t) => t.pharmacieId.equals(_pharmacieId))
        ..where((t) => t.isDeleted.equals(false))
        ..orderBy([(t) => OrderingTerm(expression: t.nom.lower(), mode: OrderingMode.asc)]))
      .get();
      
  Stream<List<Produit>> watchTousLesProduits() => (_db.select(_db.produits)
        ..where((t) => t.pharmacieId.equals(_pharmacieId))
        ..where((t) => t.isDeleted.equals(false))
        ..orderBy([(t) => OrderingTerm(expression: t.nom.lower(), mode: OrderingMode.asc)]))
      .watch();

  Future<int> ajouterProduit(ProduitsCompanion produit) {
    if (!_isPharmacien) throw Exception("Action non autorisée");
    final p = produit.copyWith(
      pharmacieId: Value(_pharmacieId),
      updatedAt: Value(DateTime.now()),
      isSynced: const Value(false),
      id: produit.id.present ? produit.id : Value(const Uuid().v4()),
    );
    return _db.into(_db.produits).insert(p).then((_) => 1); // Return 1 for success since insert returns rowId but we use UUID
  }
  
  Future<bool> modifierProduit(Produit produit) {
    if (!_isPharmacien) throw Exception("Action non autorisée");
    final p = produit.copyWith(
      updatedAt: DateTime.now(),
      isSynced: false,
    );
    return _db.update(_db.produits).replace(p);
  }
  
  Future<int> supprimerProduit(Produit produit) {
    if (!_isPharmacien) throw Exception("Action non autorisée");
    final p = produit.copyWith(
      isDeleted: true,
      updatedAt: DateTime.now(),
      isSynced: false,
    );
    return _db.update(_db.produits).replace(p).then((_) => 1);
  }

  Future<int> getCompteStockBas() async {
    final query = _db.select(_db.produits)
      ..where((p) => p.pharmacieId.equals(_pharmacieId))
      ..where((p) => p.isDeleted.equals(false))
      ..where((p) => p.quantiteStock.isSmallerOrEqual(p.seuilAlerte));
    final result = await query.get();
    return result.length;
  }
}
