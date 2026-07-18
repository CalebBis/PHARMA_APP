import 'package:drift/drift.dart';
import '../database/database.dart';

class VentesRepository {
  final AppDatabase _db;
  VentesRepository(this._db);

  Future<List<Vente>> getVentes() => _db.select(_db.ventes).get();
  Stream<List<Vente>> watchVentes() => _db.select(_db.ventes).watch();

  // A transaction for a complete sale with details
  Future<int> enregistrerVente(VentesCompanion vente, List<VenteDetailsCompanion> details) async {
    return _db.transaction(() async {
      // 1. Insert vente
      final venteId = await _db.into(_db.ventes).insert(vente);

      // 2. Insert details
      for (var detail in details) {
        await _db.into(_db.venteDetails).insert(detail.copyWith(venteId: Value(venteId)));
        
        // Decrement stock
        if (detail.produitId.present) {
          final produitId = detail.produitId.value;
          final produit = await (_db.select(_db.produits)..where((p) => p.id.equals(produitId))).getSingle();
          final nouvelleQuantite = produit.quantiteStock - detail.quantite.value;
          
          await _db.update(_db.produits).replace(produit.copyWith(quantiteStock: nouvelleQuantite));
        }
      }
      return venteId;
    });
  }

  Future<List<Vente>> getVentesRecentes(int limit) {
    return (_db.select(_db.ventes)
          ..orderBy([(v) => OrderingTerm(expression: v.dateVente, mode: OrderingMode.desc)])
          ..limit(limit))
        .get();
  }

  Future<double> getVentesDuJour() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    
    final query = _db.select(_db.ventes)
      ..where((v) => v.dateVente.isBiggerOrEqualValue(startOfDay));
      
    final ventes = await query.get();
    return ventes.fold<double>(0.0, (sum, v) => sum + v.montantTotal);
  }

  Future<int> getNombreTransactionsDuJour() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    
    final query = _db.select(_db.ventes)
      ..where((v) => v.dateVente.isBiggerOrEqualValue(startOfDay));
      
    final ventes = await query.get();
    return ventes.length;
  }
  
  Future<String?> getTopProduit(int days) async {
    final startDate = DateTime.now().subtract(Duration(days: days));
    final result = await _db.customSelect(
      '''
      SELECT p.nom, SUM(d.quantite) as total_qty
      FROM ventes v
      JOIN vente_details d ON d.vente_id = v.id
      JOIN produits p ON p.id = d.produit_id
      WHERE v.date_vente >= ?
      GROUP BY p.id
      ORDER BY total_qty DESC
      LIMIT 1
      ''',
      variables: [Variable.withDateTime(startDate)],
    ).getSingleOrNull();
    
    return result?.read<String>('nom');
  }

  Future<List<Map<String, dynamic>>> getVentesParJour(int days) async {
    final startDate = DateTime.now().subtract(Duration(days: days));
    final result = await _db.customSelect(
      '''
      SELECT DATE(date_vente, 'unixepoch') as jour, SUM(montant_total) as total
      FROM ventes
      WHERE date_vente >= ?
      GROUP BY jour
      ORDER BY jour ASC
      ''',
      variables: [Variable.withDateTime(startDate)],
    ).get();
    
    return result.map((row) => {
      'jour': row.read<String>('jour'),
      'total': row.read<double>('total'),
    }).toList();
  }

  Future<Map<String, dynamic>> getRapportData(DateTime start, DateTime end) async {
    // Total des ventes, nombre transactions, benefice total
    final ventesQuery = await _db.customSelect(
      '''
      SELECT COUNT(v.id) as nb_transactions, SUM(v.montant_total) as total_ventes
      FROM ventes v
      WHERE v.date_vente >= ? AND v.date_vente <= ?
      ''',
      variables: [Variable.withDateTime(start), Variable.withDateTime(end)],
    ).getSingleOrNull();

    final nbTransactions = ventesQuery?.read<int>('nb_transactions') ?? 0;
    final totalVentes = ventesQuery?.read<double>('total_ventes') ?? 0.0;
    final panierMoyen = nbTransactions > 0 ? totalVentes / nbTransactions : 0.0;

    // Benefice (prixVente - prixAchat) * quantite
    final beneficeQuery = await _db.customSelect(
      '''
      SELECT SUM((p.prix_vente - p.prix_achat) * d.quantite) as benefice
      FROM ventes v
      JOIN vente_details d ON d.vente_id = v.id
      JOIN produits p ON p.id = d.produit_id
      WHERE v.date_vente >= ? AND v.date_vente <= ?
      ''',
      variables: [Variable.withDateTime(start), Variable.withDateTime(end)],
    ).getSingleOrNull();

    final beneficeTotal = beneficeQuery?.read<double>('benefice') ?? 0.0;

    return {
      'nbTransactions': nbTransactions,
      'totalVentes': totalVentes,
      'panierMoyen': panierMoyen,
      'beneficeTotal': beneficeTotal,
    };
  }
}
