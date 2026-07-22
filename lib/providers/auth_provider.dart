import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database.dart';
import '../services/auth_service.dart';
import '../services/sync_service.dart';
import 'database_provider.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  final db = ref.watch(databaseProvider);
  return AuthService(db);
});

class AuthNotifier extends StateNotifier<Utilisateur?> {
  final AuthService _authService;
  final SyncService _syncService;

  AuthNotifier(this._authService, this._syncService) : super(null) {
    _init();
  }

  Future<void> _init() async {
    final user = await _authService.getCurrentUtilisateur();
    if (user != null) {
      setUtilisateur(user);
    }
  }

  void setUtilisateur(Utilisateur utilisateur) {
    state = utilisateur;
    _syncService.startAutoSync();
  }

  Future<void> logout() async {
    _syncService.stopAutoSync();
    // Pousse les données en attente avant déconnexion
    await _syncService.syncAll();
    await _authService.logout();
    state = null;
  }

  bool get isPharmacien => state?.role.toLowerCase() == 'pharmacien';
  bool get isVendeuse => state?.role.toLowerCase() == 'vendeuse';
}

final authProvider = StateNotifierProvider<AuthNotifier, Utilisateur?>((ref) {
  final authService = ref.watch(authServiceProvider);
  final syncService = ref.watch(syncServiceProvider);
  return AuthNotifier(authService, syncService);
});

final currentPharmacieProvider = StreamProvider<Pharmacy?>((ref) {
  final user = ref.watch(authProvider);
  if (user == null) return Stream.value(null);
  final db = ref.watch(databaseProvider);
  return (db.select(db.pharmacies)..where((t) => t.id.equals(user.pharmacieId))).watchSingleOrNull();
});
