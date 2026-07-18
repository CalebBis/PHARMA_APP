import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../providers/produits_provider.dart';
import '../../providers/categories_provider.dart';
import '../../providers/database_provider.dart';
import '../../providers/auth_provider.dart';
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
        title: const Text('Gestion des Produits'),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        actions: [
          if (isPharmacien)
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Nouveau Produit'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
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
                      return DropdownButtonFormField<int?>(
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
                  child: SingleChildScrollView(
                    child: DataTable(
                      headingRowColor: MaterialStateProperty.all(Colors.grey.shade100),
                      columns: [
                        const DataColumn(label: Text('ID')),
                        const DataColumn(label: Text('Nom')),
                        const DataColumn(label: Text('Stock')),
                        const DataColumn(label: Text('Prix Achat')),
                        const DataColumn(label: Text('Prix Vente')),
                        const DataColumn(label: Text('Péremption')),
                        if (isPharmacien) const DataColumn(label: Text('Actions')),
                      ],
                      rows: produits.map((p) {
                        final isLowStock = p.quantiteStock <= p.seuilAlerte;
                        final isExpiringSoon = p.datePeremption != null && 
                            p.datePeremption!.isBefore(DateTime.now().add(const Duration(days: 30)));

                        return DataRow(cells: [
                          DataCell(Text(p.id.toString())),
                          DataCell(
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (isLowStock)
                                  const Icon(Icons.warning, color: Colors.orange, size: 18),
                                if (isExpiringSoon)
                                  const Icon(Icons.timer, color: Colors.red, size: 18),
                                if (isLowStock || isExpiringSoon) const SizedBox(width: 8),
                                Text(p.nom, style: const TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          DataCell(
                            Text(
                              p.quantiteStock.toString(),
                              style: TextStyle(
                                color: isLowStock ? Colors.red : Colors.black,
                                fontWeight: isLowStock ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                          DataCell(Text('${p.prixAchat.toStringAsFixed(2)} €')),
                          DataCell(Text('${p.prixVente.toStringAsFixed(2)} €')),
                          DataCell(
                            Text(p.datePeremption != null
                                ? DateFormat('dd/MM/yyyy').format(p.datePeremption!)
                                : '-'),
                          ),
                          if (isPharmacien)
                            DataCell(
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit, color: Colors.blue),
                                    tooltip: 'Modifier',
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (ctx) => ProduitFormDialog(produitToEdit: p),
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    tooltip: 'Supprimer',
                                    onPressed: () async {
                                      final confirm = await showDialog<bool>(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                          title: const Text('Confirmation'),
                                          content: Text('Voulez-vous vraiment supprimer "${p.nom}" ?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(ctx, false),
                                              child: const Text('Non'),
                                            ),
                                            TextButton(
                                              onPressed: () => Navigator.pop(ctx, true),
                                              child: const Text('Oui'),
                                            ),
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
                        ]);
                      }).toList(),
                    ),
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
