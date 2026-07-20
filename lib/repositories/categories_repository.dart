import 'package:drift/drift.dart';
import '../database/database.dart';
import 'package:uuid/uuid.dart';

class CategoriesRepository {
  final AppDatabase _db;
  final String _pharmacieId;
  CategoriesRepository(this._db, this._pharmacieId);

  Future<List<Category>> getAllCategories() => (_db.select(_db.categories)
        ..where((c) => c.pharmacieId.equals(_pharmacieId))
        ..where((c) => c.isDeleted.equals(false)))
      .get();
      
  Stream<List<Category>> watchAllCategories() => (_db.select(_db.categories)
        ..where((c) => c.pharmacieId.equals(_pharmacieId))
        ..where((c) => c.isDeleted.equals(false)))
      .watch();

  Future<String> ajouterCategorie(CategoriesCompanion categorie) async {
    final String id = categorie.id.present ? categorie.id.value : const Uuid().v4();
    final c = categorie.copyWith(
      id: Value(id),
      pharmacieId: Value(_pharmacieId),
      updatedAt: Value(DateTime.now()),
      isSynced: const Value(false),
    );
    await _db.into(_db.categories).insert(c);
    return id;
  }
  
  Future<bool> modifierCategorie(Category categorie) {
    final c = categorie.copyWith(
      updatedAt: DateTime.now(),
      isSynced: false,
    );
    return _db.update(_db.categories).replace(c);
  }
  
  Future<int> supprimerCategorie(Category categorie) {
    final c = categorie.copyWith(
      isDeleted: true,
      updatedAt: DateTime.now(),
      isSynced: false,
    );
    return _db.update(_db.categories).replace(c).then((_) => 1);
  }
}
