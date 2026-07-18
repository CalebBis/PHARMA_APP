import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/factures_repository.dart';
import 'database_provider.dart';

final facturesRepositoryProvider = Provider<FacturesRepository>((ref) {
  return FacturesRepository(ref.watch(databaseProvider));
});

final facturesProvider = StreamProvider<List<FactureWithDetails>>((ref) {
  final repo = ref.watch(facturesRepositoryProvider);
  return repo.watchToutesLesFactures();
});
