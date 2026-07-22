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
                        isExpanded: true,
                        decoration: const InputDecoration(
                          labelText: 'Catégorie',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        value: filter.categoryId,
                        items: [
                          const DropdownMenuItem(value: null, child: Text('Toutes')),
                          ...categories.map((c) => DropdownMenuItem(value: c.id, child: Text(c.nom, overflow: TextOverflow.ellipsis))),
                        ],
                        onChanged: (val) {
                          ref.read(produitFilterProvider.notifier).state = filter.copyWith(
                            categoryId: val,
                            clearCategoryId: val == null,
                          );
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
                      maxCrossAxisExtent: 320,
                      mainAxisExtent: 310,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: produits.length,
                    itemBuilder: (context, index) {
                      final p = produits[index];
                      final isLowStock = p.quantiteStock <= p.seuilAlerte;
                      final isExpiringSoon = p.datePeremption != null && 
                          p.datePeremption!.isBefore(DateTime.now().add(const Duration(days: 30)));
                      
                      final category = categoriesAsync.value?.where((c) => c.id == p.categorieId).firstOrNull;
                      final categoryName = category?.nom ?? 'Non catégorisé';
                      
                      final int maxStock = p.quantiteStock > 100 ? p.quantiteStock : 100;
                      final double stockProgress = (p.quantiteStock / maxStock).clamp(0.0, 1.0);
                      
                      final bool hasDate = p.datePeremption != null;
                      final Color peremptionColor = !hasDate ? Colors.grey.shade700 : (isExpiringSoon ? Colors.orange.shade800 : Colors.green.shade800);
                      final Color peremptionBgColor = !hasDate ? Colors.grey.shade100 : (isExpiringSoon ? Colors.orange.shade50 : Colors.green.shade50);
                      final Color peremptionBorderColor = !hasDate ? Colors.grey.shade300 : (isExpiringSoon ? Colors.orange.shade300 : Colors.green.shade300);

                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(color: Colors.grey.shade200),
                        ),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Header image / color
                            Container(
                              height: 60,
                              color: Colors.green.shade100,
                              child: Icon(Icons.medication, size: 36, color: Colors.green.shade600),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  // Title & Category
                                  Text(
                                    p.nom,
                                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Catégorie: $categoryName',
                                      style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 12),
                                    // Row Stock / Prix
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Stock Block
                                        Expanded(
                                          flex: 5,
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              border: Border.all(color: Colors.orange.shade200),
                                              borderRadius: BorderRadius.circular(8),
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                RichText(
                                                  text: TextSpan(
                                                    style: const TextStyle(color: Colors.black, fontSize: 11),
                                                    children: [
                                                      const TextSpan(text: 'Stock: ', style: TextStyle(fontWeight: FontWeight.bold)),
                                                      TextSpan(text: '${p.quantiteStock} / $maxStock'),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(height: 6),
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(4),
                                                  child: LinearProgressIndicator(
                                                    value: stockProgress,
                                                    backgroundColor: Colors.orange.shade100,
                                                    valueColor: AlwaysStoppedAnimation<Color>(
                                                      isLowStock ? Colors.orange : Colors.orange.shade300,
                                                    ),
                                                    minHeight: 6,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        // Prix Block
                                        Expanded(
                                          flex: 4,
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.green.shade100,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text('Prix Vente:', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black87)),
                                                const SizedBox(height: 4),
                                                FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    CurrencyFormatter.format(p.prixVente),
                                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    // Péremption Block
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                      decoration: BoxDecoration(
                                        color: peremptionBgColor,
                                        border: Border.all(color: peremptionBorderColor),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          if (hasDate && isExpiringSoon)
                                            Icon(Icons.warning_amber_rounded, color: peremptionColor, size: 16),
                                          if (hasDate && isExpiringSoon)
                                            const SizedBox(width: 4),
                                          Flexible(
                                            child: Text(
                                              hasDate 
                                                ? 'Péremption: ${DateFormat('dd/MM/yyyy').format(p.datePeremption!)}' 
                                                : 'Aucune date de péremption',
                                              style: TextStyle(
                                                color: peremptionColor,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            const Spacer(),
                            // Action Buttons
                            if (isPharmacien)
                              Container(
                                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton.icon(
                                        icon: const Icon(Icons.edit, size: 16),
                                        label: const Text('Éditer', style: TextStyle(fontSize: 12)),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: Colors.blue.shade700,
                                          side: BorderSide(color: Colors.blue.shade200),
                                          backgroundColor: Colors.blue.shade50,
                                          padding: const EdgeInsets.symmetric(vertical: 8),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (ctx) => ProduitFormDialog(produitToEdit: p),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: OutlinedButton.icon(
                                        icon: const Icon(Icons.delete, size: 16),
                                        label: const Text('Supprimer', style: TextStyle(fontSize: 12)),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: Colors.red.shade700,
                                          side: BorderSide(color: Colors.red.shade200),
                                          backgroundColor: Colors.red.shade50,
                                          padding: const EdgeInsets.symmetric(vertical: 8),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        ),
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
