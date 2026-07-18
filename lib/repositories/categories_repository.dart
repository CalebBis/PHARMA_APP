import 'package:drift/drift.dart';
import '../database/database.dart';

class CategoriesRepository {
  final AppDatabase _db;
  CategoriesRepository(this._db);

  Future<List<Category>> getAllCategories() => _db.select(_db.categories).get();
  Stream<List<Category>> watchAllCategories() => _db.select(_db.categories).watch();

  Future<int> ajouterCategorie(CategoriesCompanion categorie) => _db.into(_db.categories).insert(categorie);
  Future<bool> modifierCategorie(Category categorie) => _db.update(_db.categories).replace(categorie);
  Future<int> supprimerCategorie(Category categorie) => _db.delete(_db.categories).delete(categorie);
}
