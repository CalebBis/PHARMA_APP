import 'package:drift/drift.dart';
import '../database/database.dart';
import 'package:uuid/uuid.dart';

class FactureWithDetails {
  final Facture facture;
  final Vente vente;

  FactureWithDetails(this.facture, this.vente);
}

class FactureLigne {
  final Facture facture;
  final VenteDetail detail;
  final Produit produit;

  FactureLigne({
    required this.facture,
    required this.detail,
    required this.produit,
  });
}

class FacturesRepository {
  final AppDatabase _db;
  final String _pharmacieId;
  FacturesRepository(this._db, this._pharmacieId);

  Future<List<FactureWithDetails>> getToutesLesFactures() async {
    final query = _db.select(_db.factures).join([
      innerJoin(_db.ventes, _db.ventes.id.equalsExp(_db.factures.venteId)),
    ])..where(_db.factures.pharmacieId.equals(_pharmacieId) & _db.factures.isDeleted.equals(false));
    final results = await query.get();
    return results.map((row) {
      return FactureWithDetails(
        row.readTable(_db.factures),
        row.readTable(_db.ventes),
      );
    }).toList();
  }

  Future<List<FactureWithDetails>> getFacturesByPeriod(DateTime start, DateTime end) async {
    final query = _db.select(_db.factures).join([
      innerJoin(_db.ventes, _db.ventes.id.equalsExp(_db.factures.venteId)),
    ])..where(_db.factures.dateEmission.isBetweenValues(start, end) & 
              _db.factures.pharmacieId.equals(_pharmacieId) & 
              _db.factures.isDeleted.equals(false));
    
    final results = await query.get();
    return results.map((row) {
      return FactureWithDetails(
        row.readTable(_db.factures),
        row.readTable(_db.ventes),
      );
    }).toList();
  }

  Future<List<FactureLigne>> getFactureLignesByPeriod(DateTime start, DateTime end) async {
    final query = _db.select(_db.factures).join([
      innerJoin(_db.ventes, _db.ventes.id.equalsExp(_db.factures.venteId)),
      innerJoin(_db.venteDetails, _db.venteDetails.venteId.equalsExp(_db.ventes.id)),
      innerJoin(_db.produits, _db.produits.id.equalsExp(_db.venteDetails.produitId)),
    ])..where(_db.factures.dateEmission.isBetweenValues(start, end) & 
              _db.factures.pharmacieId.equals(_pharmacieId) & 
              _db.factures.isDeleted.equals(false));
    
    // Trier par date d'émission descendante pour avoir les plus récentes en haut
    query.orderBy([OrderingTerm(expression: _db.factures.dateEmission, mode: OrderingMode.desc)]);
    
    final results = await query.get();
    return results.map((row) {
      return FactureLigne(
        facture: row.readTable(_db.factures),
        detail: row.readTable(_db.venteDetails),
        produit: row.readTable(_db.produits),
      );
    }).toList();
  }

  Stream<List<FactureWithDetails>> watchToutesLesFactures() {
    final query = _db.select(_db.factures).join([
      innerJoin(_db.ventes, _db.ventes.id.equalsExp(_db.factures.venteId)),
    ])..where(_db.factures.pharmacieId.equals(_pharmacieId) & _db.factures.isDeleted.equals(false));
    return query.watch().map((rows) {
      return rows.map((row) {
        return FactureWithDetails(
          row.readTable(_db.factures),
          row.readTable(_db.ventes),
        );
      }).toList();
    });
  }

  Future<String> ajouterFacture(FacturesCompanion facture) async {
    final String id = facture.id.present ? facture.id.value : const Uuid().v4();
    final f = facture.copyWith(
      id: Value(id),
      pharmacieId: Value(_pharmacieId),
      updatedAt: Value(DateTime.now()),
      isSynced: const Value(false),
    );
    await _db.into(_db.factures).insert(f);
    return id;
  }
}
