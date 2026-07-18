import 'package:drift/drift.dart';
import '../database/database.dart';

class UtilisateursRepository {
  final AppDatabase _db;
  UtilisateursRepository(this._db);

  Future<Utilisateur?> login(String identifiant, String motDePasse) {
    return (_db.select(_db.utilisateurs)
          ..where((u) => u.identifiant.equals(identifiant))
          ..where((u) => u.motDePasse.equals(motDePasse)))
        .getSingleOrNull();
  }

  Future<int> ajouterUtilisateur(UtilisateursCompanion utilisateur) => _db.into(_db.utilisateurs).insert(utilisateur);
}
