import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../providers/produits_provider.dart';
import '../../providers/categories_provider.dart';
import '../../providers/database_provider.dart';
import '../../providers/auth_provider.dart';
import '../../utils/currency_formatter.dart';
import 'produit_form_dialog.dart';

class ProduitsScreen extends ConsumerWidget {
  const ProduitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final produitsAsync = ref.watch(filteredProduitsProvider);
    final filter = ref.watch(produitFilterProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final isPharmacien = ref.read(authProvider.notifier).isPharmacien;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion des Produits', 
        style:TextStyle(fontWeight:FontWeight.bold, color:Colors.white)
        
        ),
        backgroundColor: Colors.green,
        scrolledUnderElevation: 0,
        actions: [
          if (isPharmacien)
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Nouveau Produit', style:TextStyle(color:Colors.white),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => const ProduitFormDialog(),
                );
              },
            ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // Filters bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Rechercher par nom',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    onChanged: (val) {
                      ref.read(produitFilterProvider.notifier).state = filter.copyWith(searchQuery: val);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: categoriesAsync.when(
                    data: (categories) {
                      return DropdownButtonFormField<String?>(
                        decoration: const InputDecoration(
                          labelText: 'Catégorie',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        value: filter.categoryId,
                        items: [
                          const DropdownMenuItem(value: null, child: Text('Toutes')),
                          ...categories.map((c) => DropdownMenuItem(value: c.id, child: Text(c.nom))),
                        ],
                        onChanged: (val) {
                          ref.read(produitFilterProvider.notifier).state = filter.copyWith(categoryId: val);
                        },
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (e, st) => const Text('Erreur'),
                  ),
                ),
                const SizedBox(width: 16),
                FilterChip(
                  label: const Text('Stock Bas'),
                  selectedColor: Colors.orange.shade200,
                  selected: filter.showLowStock,
                  onSelected: (val) {
                    ref.read(produitFilterProvider.notifier).state = filter.copyWith(showLowStock: val);
                  },
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('Péremption proche'),
                  selectedColor: Colors.red.shade200,
                  selected: filter.showExpiringSoon,
                  onSelected: (val) {
                    ref.read(produitFilterProvider.notifier).state = filter.copyWith(showExpiringSoon: val);
                  },
                ),
              ],
            ),
          ),
          // Data Table
          Expanded(
            child: produitsAsync.when(
              data: (produits) {
                if (produits.isEmpty) {
                  return const Center(child: Text('Aucun produit trouvé.'));
                }
                return SizedBox(
                  width: double.infinity,
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: produits.length,
                    itemBuilder: (context, index) {
                      final p = produits[index];
                      final isLowStock = p.quantiteStock <= p.seuilAlerte;
                      final isExpiringSoon = p.datePeremption != null && 
                          p.datePeremption!.isBefore(DateTime.now().add(const Duration(days: 30)));

                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Header image / color
                                Container(
                                  height: 80,
                                  width: double.infinity,
                                  color: Colors.green.shade100,
                                  child: Icon(Icons.medication, size: 48, color: Colors.green.shade700),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        p.nom,
                                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Stock: ${p.quantiteStock}', style: TextStyle(fontWeight: FontWeight.bold, color: isLowStock ? Colors.red : Colors.black)),
                                          Text(CurrencyFormatter.format(p.prixVente), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text('Achat: ${CurrencyFormatter.format(p.prixAchat)}', style: const TextStyle(color: Colors.grey, fontSize: 12)),
                                      const SizedBox(height: 4),
                                      Text(
                                        p.datePeremption != null ? 'Péremption: ${DateFormat('dd/MM/yyyy').format(p.datePeremption!)}' : 'Aucune date de péremption',
                                        style: TextStyle(color: isExpiringSoon ? Colors.red : Colors.grey, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                if (isPharmacien)
                                  Container(
                                    color: Colors.grey.shade50,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        TextButton.icon(
                                          icon: const Icon(Icons.edit, color: Colors.blue, size: 16),
                                          label: const Text('Modifier', style: TextStyle(color: Colors.blue)),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (ctx) => ProduitFormDialog(produitToEdit: p),
                                            );
                                          },
                                        ),
                                        TextButton.icon(
                                          icon: const Icon(Icons.delete, color: Colors.red, size: 16),
                                          label: const Text('Supprimer', style: TextStyle(color: Colors.red)),
                                          onPressed: () async {
                                            final confirm = await showDialog<bool>(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                title: const Text('Confirmation'),
                                                content: Text('Voulez-vous vraiment supprimer "${p.nom}" ?'),
                                                actions: [
                                                  TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Non')),
                                                  TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Oui')),
                                                ],
                                              ),
                                            );
                                            if (confirm == true) {
                                              ref.read(produitsRepositoryProvider).supprimerProduit(p);
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                            // Badges
                            if (isLowStock || isExpiringSoon)
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if (isLowStock)
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(12)),
                                        child: const Text('Stock Bas', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                      ),
                                    if (isLowStock && isExpiringSoon) const SizedBox(height: 4),
                                    if (isExpiringSoon)
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(12)),
                                        child: const Text('Périme bientôt', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                      ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text('Erreur: $e')),
            ),
          ),
        ],
      ),
    );
  }
}
