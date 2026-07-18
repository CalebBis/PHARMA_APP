import 'package:drift/drift.dart';
import '../database/database.dart';

class ProduitsRepository {
  final AppDatabase _db;
  final bool _isPharmacien;
  ProduitsRepository(this._db, this._isPharmacien);

  Future<List<Produit>> getTousLesProduits() => _db.select(_db.produits).get();
  Stream<List<Produit>> watchTousLesProduits() => _db.select(_db.produits).watch();

  Future<int> ajouterProduit(ProduitsCompanion produit) {
    if (!_isPharmacien) throw Exception("Action non autorisée");
    return _db.into(_db.produits).insert(produit);
  }
  
  Future<bool> modifierProduit(Produit produit) {
    if (!_isPharmacien) throw Exception("Action non autorisée");
    return _db.update(_db.produits).replace(produit);
  }
  
  Future<int> supprimerProduit(Produit produit) {
    if (!_isPharmacien) throw Exception("Action non autorisée");
    return _db.delete(_db.produits).delete(produit);
  }

  Future<int> getCompteStockBas() async {
    final query = _db.select(_db.produits)
      ..where((p) => p.quantiteStock.isSmallerOrEqual(p.seuilAlerte));
    final result = await query.get();
    return result.length;
  }
}
