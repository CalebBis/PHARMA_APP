import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database.dart';

class CartItem {
  final Produit produit;
  final int quantite;

  CartItem({required this.produit, required this.quantite});

  CartItem copyWith({Produit? produit, int? quantite}) {
    return CartItem(
      produit: produit ?? this.produit,
      quantite: quantite ?? this.quantite,
    );
  }

  double get sousTotal => produit.prixVente * quantite;
}

class PanierNotifier extends StateNotifier<List<CartItem>> {
  PanierNotifier() : super([]);

  void ajouterProduit(Produit produit) {
    // Si la quantité en stock est épuisée, on empêche l'ajout
    if (produit.quantiteStock <= 0) return;

    final existingIndex = state.indexWhere((item) => item.produit.id == produit.id);
    if (existingIndex >= 0) {
      // Check stock before incrementing
      final existingItem = state[existingIndex];
      if (existingItem.quantite < produit.quantiteStock) {
        final newList = List<CartItem>.from(state);
        newList[existingIndex] = existingItem.copyWith(quantite: existingItem.quantite + 1);
        state = newList;
      }
    } else {
      state = [...state, CartItem(produit: produit, quantite: 1)];
    }
  }

  void diminuerQuantite(Produit produit) {
    final existingIndex = state.indexWhere((item) => item.produit.id == produit.id);
    if (existingIndex >= 0) {
      final existingItem = state[existingIndex];
      if (existingItem.quantite > 1) {
        final newList = List<CartItem>.from(state);
        newList[existingIndex] = existingItem.copyWith(quantite: existingItem.quantite - 1);
        state = newList;
      } else {
        retirerProduit(produit);
      }
    }
  }

  void retirerProduit(Produit produit) {
    state = state.where((item) => item.produit.id != produit.id).toList();
  }

  void viderPanier() {
    state = [];
  }

  double getTotal() {
    return state.fold(0.0, (sum, item) => sum + item.sousTotal);
  }
}

final panierProvider = StateNotifierProvider<PanierNotifier, List<CartItem>>((ref) {
  return PanierNotifier();
});

final totalPanierProvider = Provider<double>((ref) {
  final items = ref.watch(panierProvider);
  return items.fold(0.0, (sum, item) => sum + item.sousTotal);
});
