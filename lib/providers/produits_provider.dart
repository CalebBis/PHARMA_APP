import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database.dart';
import 'database_provider.dart';

class ProduitFilter {
  final String searchQuery;
  final String? categoryId;
  final bool showLowStock;
  final bool showExpiringSoon;

  ProduitFilter({
    this.searchQuery = '',
    this.categoryId,
    this.showLowStock = false,
    this.showExpiringSoon = false,
  });

  ProduitFilter copyWith({
    String? searchQuery,
    String? categoryId,
    bool clearCategoryId = false,
    bool? showLowStock,
    bool? showExpiringSoon,
  }) {
    return ProduitFilter(
      searchQuery: searchQuery ?? this.searchQuery,
      categoryId: clearCategoryId ? null : (categoryId ?? this.categoryId),
      showLowStock: showLowStock ?? this.showLowStock,
      showExpiringSoon: showExpiringSoon ?? this.showExpiringSoon,
    );
  }
}

final produitFilterProvider = StateProvider<ProduitFilter>((ref) => ProduitFilter());

final _allProduitsProvider = StreamProvider<List<Produit>>((ref) {
  final repo = ref.watch(produitsRepositoryProvider);
  return repo.watchTousLesProduits();
});

final filteredProduitsProvider = Provider<AsyncValue<List<Produit>>>((ref) {
  final allAsync = ref.watch(_allProduitsProvider);
  final filter = ref.watch(produitFilterProvider);

  return allAsync.whenData((produits) {
    var result = produits;

    if (filter.searchQuery.isNotEmpty) {
      result = result.where((p) => p.nom.toLowerCase().contains(filter.searchQuery.toLowerCase())).toList();
    }

    if (filter.categoryId != null) {
      result = result.where((p) => p.categorieId == filter.categoryId).toList();
    }

    if (filter.showLowStock) {
      result = result.where((p) => p.quantiteStock <= p.seuilAlerte).toList();
    }

    if (filter.showExpiringSoon) {
      final thirtyDaysFromNow = DateTime.now().add(const Duration(days: 30));
      result = result.where((p) => p.datePeremption != null && p.datePeremption!.isBefore(thirtyDaysFromNow)).toList();
    }

    return result;
  });
});
