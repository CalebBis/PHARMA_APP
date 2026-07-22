import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' as d;
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

import 'database/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final dbFolder = await getApplicationDocumentsDirectory();
  final file = File(p.join(dbFolder.path, 'pharmacie_app_db.sqlite'));
  print('--- DB PATH: ${file.path} ---');
  
  if (!file.existsSync()) {
    print('--- ERREUR: DB file does not exist ---');
    exit(1);
  }

  applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
  final db = AppDatabase();
  
  try {
    // 1. Check pharmacy 'teret'
    final query = db.select(db.pharmacies)..where((t) => t.nom.equals('teret'));
    final pharmacie = await query.getSingleOrNull();
    
    if (pharmacie == null) {
      print('--- ERREUR: Aucune pharmacie trouvée avec le nom "teret". ---');
      exit(1);
    }
    
    final pharmacieId = pharmacie.id;
    print('--- Pharmacie "teret" trouvée avec l\'ID: $pharmacieId ---');
    
    // 2. Read CSV
    final csvFile = File('medicaments_rdc.csv');
    if (!csvFile.existsSync()) {
      print('--- ERREUR: Fichier CSV introuvable : medicaments_rdc.csv ---');
      exit(1);
    }
    
    final lines = await csvFile.readAsLines();
    if (lines.isEmpty) {
      print('--- ERREUR: Fichier CSV vide. ---');
      exit(1);
    }
    
    final dataLines = lines.skip(1).where((l) => l.trim().isNotEmpty).toList();
    
    int categoriesCreations = 0;
    int produitsCreations = 0;
    
    final Map<String, String> categoryIds = {};
    
    for (final line in dataLines) {
      final parts = line.split(',');
      if (parts.length < 6) continue;
      
      final nom = parts[0].trim();
      final categorieNom = parts[1].trim();
      final prixAchat = double.tryParse(parts[2].trim()) ?? 0.0;
      final prixVente = double.tryParse(parts[3].trim()) ?? 0.0;
      final stock = int.tryParse(parts[4].trim()) ?? 0;
      final seuil = int.tryParse(parts[5].trim()) ?? 0;
      
      String? catId = categoryIds[categorieNom];
      if (catId == null) {
        final catQuery = db.select(db.categories)..where((t) => t.pharmacieId.equals(pharmacieId) & t.nom.equals(categorieNom));
        final existingCat = await catQuery.getSingleOrNull();
        if (existingCat != null) {
          catId = existingCat.id;
        } else {
          catId = const Uuid().v4();
          await db.into(db.categories).insert(CategoriesCompanion.insert(
            id: d.Value(catId),
            pharmacieId: pharmacieId,
            nom: categorieNom,
            isSynced: const d.Value(false),
          ));
          categoriesCreations++;
        }
        categoryIds[categorieNom] = catId;
      }
      
      final prodQuery = db.select(db.produits)..where((t) => t.pharmacieId.equals(pharmacieId) & t.nom.equals(nom));
      final existingProd = await prodQuery.getSingleOrNull();
      
      if (existingProd == null) {
        await db.into(db.produits).insert(ProduitsCompanion.insert(
          id: d.Value(const Uuid().v4()),
          pharmacieId: pharmacieId,
          nom: nom,
          categorieId: d.Value(catId),
          prixAchat: prixAchat,
          prixVente: prixVente,
          quantiteStock: stock,
          seuilAlerte: seuil,
          isSynced: const d.Value(false),
        ));
        produitsCreations++;
      }
    }
    
    print('--- Importation terminée ! ---');
    print('--- Catégories créées : $categoriesCreations ---');
    print('--- Produits insérés  : $produitsCreations ---');
    
  } catch (e, st) {
    print('--- EXCEPTION: $e\n$st ---');
  } finally {
    await db.close();
    exit(0);
  }
}
