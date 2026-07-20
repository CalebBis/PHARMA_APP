import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_provider.dart';
import '../database/database.dart';
import '../repositories/produits_repository.dart';
import '../repositories/utilisateurs_repository.dart';
import '../repositories/categories_repository.dart';
import '../repositories/ventes_repository.dart';
import '../repositories/factures_repository.dart';
import '../services/sync_service.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final produitsRepositoryProvider = Provider<ProduitsRepository>((ref) {
  final isPharmacien = ref.watch(authProvider.notifier).isPharmacien;
  final pharmacieId = ref.watch(authProvider)?.pharmacieId ?? '';
  return ProduitsRepository(ref.watch(databaseProvider), isPharmacien, pharmacieId);
});

final utilisateursRepositoryProvider = Provider<UtilisateursRepository>((ref) {
  return UtilisateursRepository(ref.watch(databaseProvider));
});

final categoriesRepositoryProvider = Provider<CategoriesRepository>((ref) {
  final pharmacieId = ref.watch(authProvider)?.pharmacieId ?? '';
  return CategoriesRepository(ref.watch(databaseProvider), pharmacieId);
});

final ventesRepositoryProvider = Provider<VentesRepository>((ref) {
  final pharmacieId = ref.watch(authProvider)?.pharmacieId ?? '';
  return VentesRepository(ref.watch(databaseProvider), pharmacieId);
});

final facturesRepositoryProvider = Provider<FacturesRepository>((ref) {
  final pharmacieId = ref.watch(authProvider)?.pharmacieId ?? '';
  return FacturesRepository(ref.watch(databaseProvider), pharmacieId);
});

final syncServiceProvider = Provider<SyncService>((ref) {
  return SyncService(ref.watch(databaseProvider));
});
