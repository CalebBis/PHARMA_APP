import 'package:drift/drift.dart';
import '../database/database.dart';
import 'package:uuid/uuid.dart';

class FactureWithDetails {
  final Facture facture;
  final Vente vente;

  FactureWithDetails(this.facture, this.vente);
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
