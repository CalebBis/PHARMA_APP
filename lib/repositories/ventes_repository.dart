import 'package:drift/drift.dart';
import '../database/database.dart';
import 'package:uuid/uuid.dart';

class VenteRecenteDTO {
  final double montantTotal;
  final DateTime dateVente;
  final String description;

  VenteRecenteDTO({
    required this.montantTotal,
    required this.dateVente,
    required this.description,
  });
}

class VentesRepository {
  final AppDatabase _db;
  final String _pharmacieId;
  VentesRepository(this._db, this._pharmacieId);

  Future<List<Vente>> getVentes() => (_db.select(_db.ventes)
        ..where((t) => t.pharmacieId.equals(_pharmacieId))
        ..where((t) => t.isDeleted.equals(false)))
      .get();
      
  Stream<List<Vente>> watchVentes() => (_db.select(_db.ventes)
        ..where((t) => t.pharmacieId.equals(_pharmacieId))
        ..where((t) => t.isDeleted.equals(false)))
      .watch();

  // A transaction for a complete sale with details
  Future<String> enregistrerVente(VentesCompanion vente, List<VenteDetailsCompanion> details) async {
    return _db.transaction(() async {
      final String venteId = vente.id.present ? vente.id.value : const Uuid().v4();
      
      final v = vente.copyWith(
        id: Value(venteId),
        pharmacieId: Value(_pharmacieId),
        updatedAt: Value(DateTime.now()),
        isSynced: const Value(false),
      );

      // 1. Insert vente
      await _db.into(_db.ventes).insert(v);

      // 2. Insert details
      for (var detail in details) {
        final d = detail.copyWith(
          id: Value(const Uuid().v4()),
          pharmacieId: Value(_pharmacieId),
          venteId: Value(venteId),
          updatedAt: Value(DateTime.now()),
          isSynced: const Value(false),
        );
        await _db.into(_db.venteDetails).insert(d);
        
        // Decrement stock
        if (detail.produitId.present) {
          final produitId = detail.produitId.value;
          final produit = await (_db.select(_db.produits)..where((p) => p.id.equals(produitId))).getSingle();
          final nouvelleQuantite = produit.quantiteStock - detail.quantite.value;
          
          await _db.update(_db.produits).replace(produit.copyWith(
            quantiteStock: nouvelleQuantite,
            updatedAt: DateTime.now(),
            isSynced: false,
          ));
        }
      }
      return venteId;
    });
  }

  Future<List<Vente>> getVentesRecentes(int limit) {
    return (_db.select(_db.ventes)
          ..where((t) => t.pharmacieId.equals(_pharmacieId))
          ..where((t) => t.isDeleted.equals(false))
          ..orderBy([(v) => OrderingTerm(expression: v.dateVente, mode: OrderingMode.desc)])
          ..limit(limit))
        .get();
  }

  Future<List<VenteRecenteDTO>> getVentesRecentesDTO(int limit) async {
    final ventes = await getVentesRecentes(limit);

    List<VenteRecenteDTO> result = [];
    for (var v in ventes) {
      final details = await (_db.select(_db.venteDetails)..where((d) => d.venteId.equals(v.id))).get();
      String desc = "";
      if (details.length == 1) {
        final produitId = details.first.produitId;
        final produit = await (_db.select(_db.produits)..where((p) => p.id.equals(produitId))).getSingleOrNull();
        desc = produit?.nom ?? "Produit inconnu";
      } else {
        desc = "${details.length} produits";
      }
      result.add(VenteRecenteDTO(
        montantTotal: v.montantTotal,
        dateVente: v.dateVente,
        description: desc,
      ));
    }
    return result;
  }

  Future<double> getVentesDuJour() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    
    final query = _db.select(_db.ventes)
      ..where((v) => v.pharmacieId.equals(_pharmacieId))
      ..where((v) => v.isDeleted.equals(false))
      ..where((v) => v.dateVente.isBiggerOrEqualValue(startOfDay));
      
    final ventes = await query.get();
    return ventes.fold<double>(0.0, (sum, v) => sum + v.montantTotal);
  }

  Future<int> getNombreTransactionsDuJour() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    
    final query = _db.select(_db.ventes)
      ..where((v) => v.pharmacieId.equals(_pharmacieId))
      ..where((v) => v.isDeleted.equals(false))
      ..where((v) => v.dateVente.isBiggerOrEqualValue(startOfDay));
      
    final ventes = await query.get();
    return ventes.length;
  }

  Future<double> getVentesDeLaVeille() async {
    final now = DateTime.now();
    final startOfYesterday = DateTime(now.year, now.month, now.day - 1);
    final startOfDay = DateTime(now.year, now.month, now.day);
    
    final query = _db.select(_db.ventes)
      ..where((v) => v.pharmacieId.equals(_pharmacieId))
      ..where((v) => v.isDeleted.equals(false))
      ..where((v) => v.dateVente.isBiggerOrEqualValue(startOfYesterday) & v.dateVente.isSmallerThanValue(startOfDay));
      
    final ventes = await query.get();
    return ventes.fold<double>(0.0, (sum, v) => sum + v.montantTotal);
  }

  Future<int> getTransactionsDeLaVeille() async {
    final now = DateTime.now();
    final startOfYesterday = DateTime(now.year, now.month, now.day - 1);
    final startOfDay = DateTime(now.year, now.month, now.day);
    
    final query = _db.select(_db.ventes)
      ..where((v) => v.pharmacieId.equals(_pharmacieId))
      ..where((v) => v.isDeleted.equals(false))
      ..where((v) => v.dateVente.isBiggerOrEqualValue(startOfYesterday) & v.dateVente.isSmallerThanValue(startOfDay));
      
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
      WHERE v.date_vente >= ? AND v.pharmacie_id = ? AND v.is_deleted = 0
      GROUP BY p.id
      ORDER BY total_qty DESC
      LIMIT 1
      ''',
      variables: [Variable.withDateTime(startDate), Variable.withString(_pharmacieId)],
    ).getSingleOrNull();
    
    return result?.read<String>('nom');
  }

  Future<List<Map<String, dynamic>>> getVentesParJour(int days) async {
    final startDate = DateTime.now().subtract(Duration(days: days));
    final result = await _db.customSelect(
      '''
      SELECT DATE(date_vente, 'unixepoch') as jour, SUM(montant_total) as total
      FROM ventes
      WHERE date_vente >= ? AND pharmacie_id = ? AND is_deleted = 0
      GROUP BY jour
      ORDER BY jour ASC
      ''',
      variables: [Variable.withDateTime(startDate), Variable.withString(_pharmacieId)],
    ).get();
    
    return result.map((row) => {
      'jour': row.read<String>('jour'),
      'total': row.read<double>('total'),
    }).toList();
  }

  Future<List<Map<String, dynamic>>> getChartData(String period) async {
    String groupBy;
    DateTime startDate;
    final now = DateTime.now();

    if (period == '7 jours') {
      startDate = now.subtract(const Duration(days: 7));
      groupBy = "DATE(date_vente, 'unixepoch', 'localtime')";
    } else if (period == 'Mois') {
      startDate = now.subtract(const Duration(days: 30));
      groupBy = "DATE(date_vente, 'unixepoch', 'localtime')";
    } else if (period == 'Année') {
      startDate = DateTime(now.year - 1, now.month, now.day);
      groupBy = "STRFTIME('%Y-%m', date_vente, 'unixepoch', 'localtime')";
    } else {
      startDate = now.subtract(const Duration(days: 7));
      groupBy = "DATE(date_vente, 'unixepoch', 'localtime')";
    }

    final result = await _db.customSelect(
      '''
      SELECT $groupBy as periode, SUM(montant_total) as total
      FROM ventes
      WHERE date_vente >= ? AND pharmacie_id = ? AND is_deleted = 0
      GROUP BY periode
      ORDER BY periode ASC
      ''',
      variables: [Variable.withDateTime(startDate), Variable.withString(_pharmacieId)],
    ).get();
    
    return result.map((row) => {
      'jour': row.read<String>('periode'),
      'total': row.read<double>('total'),
    }).toList();
  }

  Future<Map<String, dynamic>> getRapportData(DateTime start, DateTime end) async {
    // Total des ventes, nombre transactions, benefice total
    final ventesQuery = await _db.customSelect(
      '''
      SELECT COUNT(v.id) as nb_transactions, SUM(v.montant_total) as total_ventes
      FROM ventes v
      WHERE v.date_vente >= ? AND v.date_vente <= ? AND v.pharmacie_id = ? AND v.is_deleted = 0
      ''',
      variables: [Variable.withDateTime(start), Variable.withDateTime(end), Variable.withString(_pharmacieId)],
    ).getSingleOrNull();

    final nbTransactions = ventesQuery?.read<int>('nb_transactions') ?? 0;
    final totalVentes = ventesQuery?.read<double>('total_ventes') ?? 0.0;
    final panierMoyen = nbTransactions > 0 ? totalVentes / nbTransactions : 0.0;

    // Benefice (prixVente - prixAchat) * quantite
    final beneficeQuery = await _db.customSelect(
      '''
      SELECT SUM((d.prix_unitaire - d.prix_achat) * d.quantite) as benefice
      FROM ventes v
      JOIN vente_details d ON d.vente_id = v.id
      JOIN produits p ON p.id = d.produit_id
      WHERE v.date_vente >= ? AND v.date_vente <= ? AND v.pharmacie_id = ? AND v.is_deleted = 0
      ''',
      variables: [Variable.withDateTime(start), Variable.withDateTime(end), Variable.withString(_pharmacieId)],
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
