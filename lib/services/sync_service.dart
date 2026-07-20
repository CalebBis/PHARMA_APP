import 'dart:async';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drift/drift.dart' as d;
import 'package:supabase_flutter/supabase_flutter.dart' as sp;
import '../database/database.dart';

/// Service de synchronisation offline-first :
///  - PUSH : envoi des lignes marquées isSynced = false vers Supabase
///  - PULL : récupération des lignes distantes plus récentes que les locales
///  - Résolution de conflit : Last-Write-Wins sur updatedAt
class SyncService {
  final sp.SupabaseClient _supabase = sp.Supabase.instance.client;
  final AppDatabase _db;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  SyncService(this._db);

  /// Démarre l'écoute de la connectivité pour déclencher une synchro dès le retour d'internet.
  void startListening() {
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      if (results.isNotEmpty && results.first != ConnectivityResult.none) {
        syncAll();
      }
    });
  }

  void stopListening() {
    _connectivitySubscription?.cancel();
  }

  Future<void> syncAll() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    try {
      final profile =
          await _supabase.from('utilisateurs_profil').select().eq('id', user.id).single();
      final pharmacieId = profile['pharmacie_id'] as String;

      await _syncPharmacies(pharmacieId);
      await _syncCategories(pharmacieId);
      await _syncProduits(pharmacieId);
      await _syncVentes(pharmacieId);
      await _syncVenteDetails(pharmacieId);
      await _syncFactures(pharmacieId);
    } catch (e) {
      debugPrint('[SyncService] syncAll error: $e');
    }
  }

  // ─── PHARMACIES ─────────────────────────────────────────────────────────────

  Future<void> _syncPharmacies(String pharmacieId) async {
    // PUSH
    final pending = await (_db.select(_db.pharmacies)
          ..where((t) => t.isSynced.equals(false)))
        .get();
    for (final row in pending) {
      await _supabase.from('pharmacies').upsert({
        'id': row.id,
        'nom': row.nom,
        'logo_url': row.logoUrl,
        'updated_at': row.updatedAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
      });
      await (_db.update(_db.pharmacies)..where((t) => t.id.equals(row.id)))
          .write(const PharmaciesCompanion(isSynced: d.Value(true)));
    }

    // PULL
    final latest = await (_db.select(_db.pharmacies)
          ..where((p) => p.id.equals(pharmacieId))
          ..orderBy([(t) => d.OrderingTerm(expression: t.updatedAt, mode: d.OrderingMode.desc)])
          ..limit(1))
        .getSingleOrNull();

    var query = _supabase.from('pharmacies').select().eq('id', pharmacieId);
    if (latest?.updatedAt != null) {
      query = query.gt('updated_at', latest!.updatedAt!.toIso8601String());
    }

    final remoteRows = await query;
    for (final r in remoteRows) {
      final local = await (_db.select(_db.pharmacies)..where((t) => t.id.equals(r['id']))).getSingleOrNull();
      final remoteUpdatedAtStr = r['updated_at'] as String?;
      final remoteUpdatedAt = remoteUpdatedAtStr != null ? DateTime.parse(remoteUpdatedAtStr) : DateTime.now();
      
      if (local == null || local.updatedAt == null || remoteUpdatedAt.isAfter(local.updatedAt!)) {
        await _db.into(_db.pharmacies).insertOnConflictUpdate(PharmaciesCompanion.insert(
          id: r['id'] as String,
          nom: r['nom'] as String,
          logoUrl: d.Value(r['logo_url'] as String?),
          updatedAt: d.Value(remoteUpdatedAt),
          isSynced: const d.Value(true),
        ));
      }
    }
  }

  // ─── CATEGORIES ─────────────────────────────────────────────────────────────

  Future<void> _syncCategories(String pharmacieId) async {
    // PUSH
    final pending = await (_db.select(_db.categories)
          ..where((t) => t.isSynced.equals(false)))
        .get();
    for (final row in pending) {
      await _supabase.from('categories').upsert({
        'id': row.id,
        'pharmacie_id': row.pharmacieId,
        'nom': row.nom,
        'updated_at': row.updatedAt.toIso8601String(),
        'is_deleted': row.isDeleted,
      });
      await (_db.update(_db.categories)..where((t) => t.id.equals(row.id)))
          .write(const CategoriesCompanion(isSynced: d.Value(true)));
    }

    // PULL
    final latest = await (_db.select(_db.categories)
          ..where((c) => c.pharmacieId.equals(pharmacieId))
          ..orderBy([(t) => d.OrderingTerm(expression: t.updatedAt, mode: d.OrderingMode.desc)])
          ..limit(1))
        .getSingleOrNull();

    var query = _supabase.from('categories').select().eq('pharmacie_id', pharmacieId);
    if (latest != null) query = query.gt('updated_at', latest.updatedAt.toIso8601String());

    final remoteRows = await query;
    for (final r in remoteRows) {
      final local = await (_db.select(_db.categories)..where((t) => t.id.equals(r['id']))).getSingleOrNull();
      final remoteUpdatedAt = DateTime.parse(r['updated_at'] as String);
      if (local == null || remoteUpdatedAt.isAfter(local.updatedAt)) {
        await _db.into(_db.categories).insertOnConflictUpdate(CategoriesCompanion.insert(
          id: d.Value(r['id'] as String),
          pharmacieId: r['pharmacie_id'] as String,
          nom: r['nom'] as String,
          updatedAt: d.Value(remoteUpdatedAt),
          isSynced: const d.Value(true),
          isDeleted: d.Value(r['is_deleted'] as bool? ?? false),
        ));
      }
    }
  }

  // ─── PRODUITS ────────────────────────────────────────────────────────────────

  Future<void> _syncProduits(String pharmacieId) async {
    // PUSH
    final pending = await (_db.select(_db.produits)
          ..where((t) => t.isSynced.equals(false)))
        .get();
    for (final row in pending) {
      await _supabase.from('produits').upsert({
        'id': row.id,
        'pharmacie_id': row.pharmacieId,
        'nom': row.nom,
        'categorie_id': row.categorieId,
        'prix_achat': row.prixAchat,
        'prix_vente': row.prixVente,
        'quantite_stock': row.quantiteStock,
        'seuil_alerte': row.seuilAlerte,
        'date_peremption': row.datePeremption?.toIso8601String(),
        'date_creation': row.dateCreation.toIso8601String(),
        'updated_at': row.updatedAt.toIso8601String(),
        'is_deleted': row.isDeleted,
      });
      await (_db.update(_db.produits)..where((t) => t.id.equals(row.id)))
          .write(const ProduitsCompanion(isSynced: d.Value(true)));
    }

    // PULL
    final latest = await (_db.select(_db.produits)
          ..where((p) => p.pharmacieId.equals(pharmacieId))
          ..orderBy([(t) => d.OrderingTerm(expression: t.updatedAt, mode: d.OrderingMode.desc)])
          ..limit(1))
        .getSingleOrNull();

    var query = _supabase.from('produits').select().eq('pharmacie_id', pharmacieId);
    if (latest != null) query = query.gt('updated_at', latest.updatedAt.toIso8601String());

    final remoteRows = await query;
    for (final r in remoteRows) {
      final local = await (_db.select(_db.produits)..where((t) => t.id.equals(r['id']))).getSingleOrNull();
      final remoteUpdatedAt = DateTime.parse(r['updated_at'] as String);
      if (local == null || remoteUpdatedAt.isAfter(local.updatedAt)) {
        await _db.into(_db.produits).insertOnConflictUpdate(ProduitsCompanion.insert(
          id: d.Value(r['id'] as String),
          pharmacieId: r['pharmacie_id'] as String,
          nom: r['nom'] as String,
          categorieId: d.Value(r['categorie_id'] as String?),
          prixAchat: (r['prix_achat'] as num).toDouble(),
          prixVente: (r['prix_vente'] as num).toDouble(),
          quantiteStock: r['quantite_stock'] as int,
          seuilAlerte: r['seuil_alerte'] as int,
          datePeremption: d.Value(r['date_peremption'] != null ? DateTime.parse(r['date_peremption'] as String) : null),
          dateCreation: DateTime.parse(r['date_creation'] as String),
          updatedAt: d.Value(remoteUpdatedAt),
          isSynced: const d.Value(true),
          isDeleted: d.Value(r['is_deleted'] as bool? ?? false),
        ));
      }
    }
  }

  // ─── VENTES ──────────────────────────────────────────────────────────────────

  Future<void> _syncVentes(String pharmacieId) async {
    // PUSH
    final pending = await (_db.select(_db.ventes)..where((t) => t.isSynced.equals(false))).get();
    for (final row in pending) {
      await _supabase.from('ventes').upsert({
        'id': row.id,
        'pharmacie_id': row.pharmacieId,
        'date_vente': row.dateVente.toIso8601String(),
        'montant_total': row.montantTotal,
        'mode_paiement': row.modePaiement,
        'updated_at': row.updatedAt.toIso8601String(),
        'is_deleted': row.isDeleted,
      });
      await (_db.update(_db.ventes)..where((t) => t.id.equals(row.id)))
          .write(const VentesCompanion(isSynced: d.Value(true)));
    }

    // PULL
    final latest = await (_db.select(_db.ventes)
          ..where((v) => v.pharmacieId.equals(pharmacieId))
          ..orderBy([(t) => d.OrderingTerm(expression: t.updatedAt, mode: d.OrderingMode.desc)])
          ..limit(1))
        .getSingleOrNull();

    var query = _supabase.from('ventes').select().eq('pharmacie_id', pharmacieId);
    if (latest != null) query = query.gt('updated_at', latest.updatedAt.toIso8601String());

    final remoteRows = await query;
    for (final r in remoteRows) {
      final local = await (_db.select(_db.ventes)..where((t) => t.id.equals(r['id']))).getSingleOrNull();
      final remoteUpdatedAt = DateTime.parse(r['updated_at'] as String);
      if (local == null || remoteUpdatedAt.isAfter(local.updatedAt)) {
        await _db.into(_db.ventes).insertOnConflictUpdate(VentesCompanion.insert(
          id: d.Value(r['id'] as String),
          pharmacieId: r['pharmacie_id'] as String,
          dateVente: DateTime.parse(r['date_vente'] as String),
          montantTotal: (r['montant_total'] as num).toDouble(),
          modePaiement: r['mode_paiement'] as String,
          updatedAt: d.Value(remoteUpdatedAt),
          isSynced: const d.Value(true),
          isDeleted: d.Value(r['is_deleted'] as bool? ?? false),
        ));
      }
    }
  }

  // ─── VENTE DETAILS ───────────────────────────────────────────────────────────

  Future<void> _syncVenteDetails(String pharmacieId) async {
    // PUSH
    final pending =
        await (_db.select(_db.venteDetails)..where((t) => t.isSynced.equals(false))).get();
    for (final row in pending) {
      await _supabase.from('vente_details').upsert({
        'id': row.id,
        'pharmacie_id': row.pharmacieId,
        'vente_id': row.venteId,
        'produit_id': row.produitId,
        'quantite': row.quantite,
        'prix_unitaire': row.prixUnitaire,
        'sous_total': row.sousTotal,
        'updated_at': row.updatedAt.toIso8601String(),
        'is_deleted': row.isDeleted,
      });
      await (_db.update(_db.venteDetails)..where((t) => t.id.equals(row.id)))
          .write(const VenteDetailsCompanion(isSynced: d.Value(true)));
    }

    // PULL
    final latest = await (_db.select(_db.venteDetails)
          ..where((v) => v.pharmacieId.equals(pharmacieId))
          ..orderBy([(t) => d.OrderingTerm(expression: t.updatedAt, mode: d.OrderingMode.desc)])
          ..limit(1))
        .getSingleOrNull();

    var query = _supabase.from('vente_details').select().eq('pharmacie_id', pharmacieId);
    if (latest != null) query = query.gt('updated_at', latest.updatedAt.toIso8601String());

    final remoteRows = await query;
    for (final r in remoteRows) {
      final local =
          await (_db.select(_db.venteDetails)..where((t) => t.id.equals(r['id']))).getSingleOrNull();
      final remoteUpdatedAt = DateTime.parse(r['updated_at'] as String);
      if (local == null || remoteUpdatedAt.isAfter(local.updatedAt)) {
        await _db.into(_db.venteDetails).insertOnConflictUpdate(VenteDetailsCompanion.insert(
          id: d.Value(r['id'] as String),
          pharmacieId: r['pharmacie_id'] as String,
          venteId: r['vente_id'] as String,
          produitId: r['produit_id'] as String,
          quantite: r['quantite'] as int,
          prixUnitaire: (r['prix_unitaire'] as num).toDouble(),
          sousTotal: (r['sous_total'] as num).toDouble(),
          updatedAt: d.Value(remoteUpdatedAt),
          isSynced: const d.Value(true),
          isDeleted: d.Value(r['is_deleted'] as bool? ?? false),
        ));
      }
    }
  }

  // ─── FACTURES ────────────────────────────────────────────────────────────────

  Future<void> _syncFactures(String pharmacieId) async {
    // PUSH
    final pending =
        await (_db.select(_db.factures)..where((t) => t.isSynced.equals(false))).get();
    for (final row in pending) {
      await _supabase.from('factures').upsert({
        'id': row.id,
        'pharmacie_id': row.pharmacieId,
        'vente_id': row.venteId,
        'numero_facture': row.numeroFacture,
        'date_emission': row.dateEmission.toIso8601String(),
        'chemin_pdf': row.cheminPdf,
        'updated_at': row.updatedAt.toIso8601String(),
        'is_deleted': row.isDeleted,
      });
      await (_db.update(_db.factures)..where((t) => t.id.equals(row.id)))
          .write(const FacturesCompanion(isSynced: d.Value(true)));
    }

    // PULL
    final latest = await (_db.select(_db.factures)
          ..where((f) => f.pharmacieId.equals(pharmacieId))
          ..orderBy([(t) => d.OrderingTerm(expression: t.updatedAt, mode: d.OrderingMode.desc)])
          ..limit(1))
        .getSingleOrNull();

    var query = _supabase.from('factures').select().eq('pharmacie_id', pharmacieId);
    if (latest != null) query = query.gt('updated_at', latest.updatedAt.toIso8601String());

    final remoteRows = await query;
    for (final r in remoteRows) {
      final local =
          await (_db.select(_db.factures)..where((t) => t.id.equals(r['id']))).getSingleOrNull();
      final remoteUpdatedAt = DateTime.parse(r['updated_at'] as String);
      if (local == null || remoteUpdatedAt.isAfter(local.updatedAt)) {
        await _db.into(_db.factures).insertOnConflictUpdate(FacturesCompanion.insert(
          id: d.Value(r['id'] as String),
          pharmacieId: r['pharmacie_id'] as String,
          venteId: r['vente_id'] as String,
          numeroFacture: r['numero_facture'] as String,
          dateEmission: DateTime.parse(r['date_emission'] as String),
          cheminPdf: d.Value(r['chemin_pdf'] as String?),
          updatedAt: d.Value(remoteUpdatedAt),
          isSynced: const d.Value(true),
          isDeleted: d.Value(r['is_deleted'] as bool? ?? false),
        ));
      }
    }
  }
}
