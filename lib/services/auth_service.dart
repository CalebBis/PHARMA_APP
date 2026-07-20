import 'package:flutter/foundation.dart' show debugPrint;
import 'package:supabase_flutter/supabase_flutter.dart' as sp;
import '../database/database.dart';

import 'package:drift/drift.dart' as d;
import 'package:uuid/uuid.dart';

class AuthService {
  final supabase = sp.Supabase.instance.client;
  final AppDatabase _db;

  AuthService(this._db);

  Future<Utilisateur?> login(String email, String password) async {
    try {
      final res = await supabase.auth.signInWithPassword(email: email, password: password);
      if (res.user != null) {
        // Fetch user profile to get role and pharmacie_id
        final profile = await supabase
            .from('utilisateurs_profil')
            .select()
            .eq('id', res.user!.id)
            .single();

        final pharmacieId = profile['pharmacie_id'] as String;
        
        // Fetch pharmacy info to cache it locally for the sidebar
        try {
          final pharmacieRes = await supabase
              .from('pharmacies')
              .select()
              .eq('id', pharmacieId)
              .single();
              
          final ph = PharmaciesCompanion.insert(
            id: pharmacieId,
            nom: pharmacieRes['nom'] as String,
            logoUrl: d.Value(pharmacieRes['logo_url'] as String?),
            isSynced: const d.Value(true),
          );
          await _db.into(_db.pharmacies).insertOnConflictUpdate(ph);
        } catch (e) {
          debugPrint('Error fetching pharmacy for cache: $e');
        }

        final u = Utilisateur(
          id: res.user!.id,
          pharmacieId: pharmacieId,
          email: res.user!.email ?? email,
          prenom: profile['prenom'] as String? ?? '',
          nom: profile['nom'] as String,
          role: profile['role'] as String,
          derniereConnexion: DateTime.now(),
        );

        // Save to local cache
        await _db.into(_db.utilisateurs).insertOnConflictUpdate(u);

        return u;
      }
    } catch (e) {
      debugPrint('Login error: $e');
    }
    return null;
  }

  Future<Utilisateur?> signUp({
    required String prenom,
    required String nom,
    required String email,
    required String password,
    String? pharmacieNom,
  }) async {
    try {
      final res = await supabase.auth.signUp(email: email, password: password);
      final userId = res.user?.id;
      if (userId == null) throw Exception("Failed to create user auth");

      String pharmacieId = '';
      if (pharmacieNom != null && pharmacieNom.isNotEmpty) {
        pharmacieId = const Uuid().v4();
        await supabase
            .from('pharmacies')
            .insert({'id': pharmacieId, 'nom': pharmacieNom});
        
        // Cache local
        final ph = PharmaciesCompanion.insert(
          id: pharmacieId,
          nom: pharmacieNom,
          isSynced: const d.Value(true),
        );
        await _db.into(_db.pharmacies).insertOnConflictUpdate(ph);
      } else {
        throw Exception("Le nom de la pharmacie est requis.");
      }

      await supabase.from('utilisateurs_profil').insert({
        'id': userId,
        'prenom': prenom,
        'nom': nom,
        'role': 'pharmacien', // Par défaut
        'pharmacie_id': pharmacieId,
      });

      final u = Utilisateur(
        id: userId,
        pharmacieId: pharmacieId,
        email: email,
        prenom: prenom,
        nom: nom,
        role: 'pharmacien',
        derniereConnexion: DateTime.now(),
      );

      await _db.into(_db.utilisateurs).insertOnConflictUpdate(u);
      return u;
    } catch (e) {
      debugPrint('SignUp error: $e');
      rethrow;
    }
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
  }
}
