import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:uuid/uuid.dart';

import 'tables/categories.dart';
import 'tables/produits.dart';
import 'tables/utilisateurs.dart';
import 'tables/ventes.dart';
import 'tables/vente_details.dart';
import 'tables/factures.dart';
import 'tables/pharmacies.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  Categories,
  Produits,
  Utilisateurs,
  Ventes,
  VenteDetails,
  Factures,
  Pharmacies,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 3) {
          // Écraser la base de test lors de la migration
          for (final table in allTables) {
            await m.deleteTable(table.actualTableName);
          }
          await m.createAll();
        } else {
          if (from < 4) {
            await m.addColumn(venteDetails, venteDetails.prixAchat);
            await customStatement('UPDATE vente_details SET prix_achat = (SELECT prix_achat FROM produits WHERE id = vente_details.produit_id)');
          }
          if (from < 5) {
            await m.alterTable(TableMigration(produits));
          }
        }
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'pharmacie_app_db.sqlite'));

    // Workaround for sqlite3_flutter_libs
    applyWorkaroundToOpenSqlite3OnOldAndroidVersions();

    return NativeDatabase.createInBackground(file);
  });
}
