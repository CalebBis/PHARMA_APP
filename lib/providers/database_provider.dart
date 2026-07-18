import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_provider.dart';
import '../database/database.dart';
import '../repositories/produits_repository.dart';
import '../repositories/utilisateurs_repository.dart';
import '../repositories/categories_repository.dart';
import '../repositories/ventes_repository.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final produitsRepositoryProvider = Provider<ProduitsRepository>((ref) {
  final isPharmacien = ref.watch(authProvider.notifier).isPharmacien;
  return ProduitsRepository(ref.watch(databaseProvider), isPharmacien);
});

final utilisateursRepositoryProvider = Provider<UtilisateursRepository>((ref) {
  return UtilisateursRepository(ref.watch(databaseProvider));
});

final categoriesRepositoryProvider = Provider<CategoriesRepository>((ref) {
  return CategoriesRepository(ref.watch(databaseProvider));
});

final ventesRepositoryProvider = Provider<VentesRepository>((ref) {
  return VentesRepository(ref.watch(databaseProvider));
});
