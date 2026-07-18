import 'package:drift/drift.dart';
import '../database/database.dart';

class FactureWithDetails {
  final Facture facture;
  final Vente vente;

  FactureWithDetails(this.facture, this.vente);
}

class FacturesRepository {
  final AppDatabase _db;
  FacturesRepository(this._db);

  Future<List<FactureWithDetails>> getToutesLesFactures() async {
    final query = _db.select(_db.factures).join([
      innerJoin(_db.ventes, _db.ventes.id.equalsExp(_db.factures.venteId)),
    ]);
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
    ]);
    return query.watch().map((rows) {
      return rows.map((row) {
        return FactureWithDetails(
          row.readTable(_db.factures),
          row.readTable(_db.ventes),
        );
      }).toList();
    });
  }

  Future<int> ajouterFacture(FacturesCompanion facture) => _db.into(_db.factures).insert(facture);
}
