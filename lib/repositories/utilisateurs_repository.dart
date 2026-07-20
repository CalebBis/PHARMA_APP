import '../database/database.dart';

// ignore_for_file: unused_field
class UtilisateursRepository {
  final AppDatabase _db;
  UtilisateursRepository(this._db);

  // Repository is currently not used heavily because AuthService handles local cache.
  // Can be extended later if needed.
}
