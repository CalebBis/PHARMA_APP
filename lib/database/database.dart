import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

import 'tables/categories.dart';
import 'tables/produits.dart';
import 'tables/utilisateurs.dart';
import 'tables/ventes.dart';
import 'tables/vente_details.dart';
import 'tables/factures.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  Categories,
  Produits,
  Utilisateurs,
  Ventes,
  VenteDetails,
  Factures,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
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
