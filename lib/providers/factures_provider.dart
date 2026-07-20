import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repositories/factures_repository.dart';
import 'database_provider.dart';

// Note: facturesRepositoryProvider is defined in database_provider.dart with pharmacieId support.
// This file only exports additional providers for streaming.

final facturesProvider = StreamProvider<List<FactureWithDetails>>((ref) {
  final repo = ref.watch(facturesRepositoryProvider);
  return repo.watchToutesLesFactures();
});
