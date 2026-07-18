import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database.dart';

class AuthNotifier extends StateNotifier<Utilisateur?> {
  AuthNotifier() : super(null);

  void setUtilisateur(Utilisateur utilisateur) {
    state = utilisateur;
  }

  void logout() {
    state = null;
  }

  bool get isPharmacien => state?.role.toLowerCase() == 'pharmacien';
  bool get isVendeuse => state?.role.toLowerCase() == 'vendeuse';
}

final authProvider = StateNotifierProvider<AuthNotifier, Utilisateur?>((ref) {
  return AuthNotifier();
});
