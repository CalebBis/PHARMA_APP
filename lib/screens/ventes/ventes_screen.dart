import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../../providers/produits_provider.dart';
import '../../providers/panier_provider.dart';
import '../../database/database.dart';
import '../../providers/database_provider.dart';
import '../../providers/categories_provider.dart';
import 'package:intl/intl.dart';

import '../../services/pdf_service.dart';
import '../../utils/currency_formatter.dart';
import '../../providers/auth_provider.dart';
import 'package:printing/printing.dart';

class VentesScreen extends ConsumerStatefulWidget {
  const VentesScreen({super.key});

  @override
  ConsumerState<VentesScreen> createState() => _VentesScreenState();
}

class _VentesScreenState extends ConsumerState<VentesScreen> {
  String _modePaiement = 'Espèces';

  void _validerVente() async {
    final items = ref.read(panierProvider);
    if (items.isEmpty) return;

    final total = ref.read(totalPanierProvider);
    final repo = ref.read(ventesRepositoryProvider);

    final vente = VentesCompanion(
      dateVente: drift.Value(DateTime.now()),
      montantTotal: drift.Value(total),
      modePaiement: drift.Value(_modePaiement),
    );

    final details = items.map((item) {
      return VenteDetailsCompanion(
        produitId: drift.Value(item.produit.id),
        quantite: drift.Value(item.quantite),
        prixUnitaire: drift.Value(item.produit.prixVente),
        prixAchat: drift.Value(item.produit.prixAchat),
        sousTotal: drift.Value(item.sousTotal),
      );
    }).toList();

    try {
      final venteId = await repo.enregistrerVente(vente, details);
      
      final dateNow = DateTime.now();
      final numeroFacture = 'FACT-${dateNow.year}${dateNow.month.toString().padLeft(2, '0')}${dateNow.day.toString().padLeft(2, '0')}-$venteId';
      
      final facturesRepo = ref.read(facturesRepositoryProvider);
      final factureId = await facturesRepo.ajouterFacture(FacturesCompanion(
        venteId: drift.Value(venteId),
        numeroFacture: drift.Value(numeroFacture),
        dateEmission: drift.Value(dateNow),
      ));

      final venteObj = Vente(
        id: venteId,
        pharmacieId: '',  // will be filled by syncService on push
        dateVente: vente.dateVente.value,
        montantTotal: vente.montantTotal.value,
        modePaiement: vente.modePaiement.value,
        updatedAt: DateTime.now(),
        isSynced: false,
        isDeleted: false,
      );

      final pdfData = await PdfService.generateInvoicePdf(
        factureId: factureId,
        numeroFacture: numeroFacture,
        vente: venteObj,
        items: items,
        pharmacieNom: ref.read(currentPharmacieProvider).value?.nom ?? 'PHARMACIE POS',
      );

      if (mounted) {
        ref.read(panierProvider.notifier).viderPanier();
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Facture Générée', style: TextStyle(color: Colors.green)),
            content: SizedBox(
              width: 800,
              height: 600,
              child: PdfPreview(
                build: (format) => pdfData,
                allowPrinting: true,
                allowSharing: true,
                canChangeOrientation: false,
                canChangePageFormat: false,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Fermer'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e', style: const TextStyle(color: Colors.white)), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final produitsAsync = ref.watch(filteredProduitsProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final filter = ref.watch(produitFilterProvider);
    final panier = ref.watch(panierProvider);
    final total = ref.watch(totalPanierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Point de Vente',style:TextStyle(color:Colors.white, fontWeight:FontWeight.bold)),
        backgroundColor: Colors.green,
        scrolledUnderElevation: 0,
      ),
      body: Row(
        children: [
          // GAUCHE : Liste des produits
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Rechercher un produit',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (val) {
                      ref.read(produitFilterProvider.notifier).state = filter.copyWith(searchQuery: val);
                    },
                  ),
                ),
                Expanded(
                  child: produitsAsync.when(
                    data: (produits) {
                      if (produits.isEmpty) return const Center(child: Text('Aucun produit disponible.'));
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          // maxHeight - 32 (padding top/bottom 16x2) - 32 (spacing 16x2 between 3 rows) = height for 3 items
                          final double itemHeight = (constraints.maxHeight - 64) / 3;
                          
                          return GridView.builder(
                            padding: const EdgeInsets.all(16),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisExtent: itemHeight,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            itemCount: produits.length,
                            itemBuilder: (context, index) {
                          final p = produits[index];
                          final isOutOfStock = p.quantiteStock <= 0;
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
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: isOutOfStock ? Colors.red.shade200 : Colors.grey.shade200),
                            ),
                            clipBehavior: Clip.antiAlias,
                            color: isOutOfStock ? Colors.grey.shade50 : Colors.white,
                            child: InkWell(
                              onTap: isOutOfStock
                                  ? null
                                  : () => ref.read(panierProvider.notifier).ajouterProduit(p),
                              child: Opacity(
                                opacity: isOutOfStock ? 0.6 : 1.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    // Header image / color
                                    Container(
                                      height: 36,
                                      color: Colors.green.shade100,
                                      child: Icon(Icons.medication, size: 24, color: Colors.green.shade600),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                        child: Column(
                                          children: [
                                            // Title & Category
                                            Text(
                                              p.nom,
                                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                            ),
                                            Text(
                                              categoryName,
                                              style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const Spacer(),
                                            // Row Stock / Prix
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                // Stock Block
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    padding: const EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(color: Colors.orange.shade200),
                                                      borderRadius: BorderRadius.circular(6),
                                                      color: Colors.white,
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          'Stock: ${p.quantiteStock}',
                                                          style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                        const SizedBox(height: 4),
                                                        ClipRRect(
                                                          borderRadius: BorderRadius.circular(2),
                                                          child: LinearProgressIndicator(
                                                            value: stockProgress,
                                                            backgroundColor: Colors.orange.shade100,
                                                            valueColor: AlwaysStoppedAnimation<Color>(
                                                              isLowStock ? Colors.orange : Colors.orange.shade300,
                                                            ),
                                                            minHeight: 4,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 4),
                                                // Prix Block
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    padding: const EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                      color: Colors.green.shade100,
                                                      borderRadius: BorderRadius.circular(6),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        const Text('Prix Vente:', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.black87)),
                                                        const SizedBox(height: 2),
                                                        FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                            CurrencyFormatter.format(p.prixVente),
                                                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            // Péremption Block
                                            Container(
                                              width: double.infinity,
                                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                                              decoration: BoxDecoration(
                                                color: peremptionBgColor,
                                                border: Border.all(color: peremptionBorderColor),
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  if (hasDate && isExpiringSoon)
                                                    Icon(Icons.warning_amber_rounded, color: peremptionColor, size: 12),
                                                  if (hasDate && isExpiringSoon)
                                                    const SizedBox(width: 2),
                                                  Flexible(
                                                    child: Text(
                                                      hasDate 
                                                        ? 'Péremption: ${DateFormat('dd/MM/yy').format(p.datePeremption!)}' 
                                                        : 'Aucune date',
                                                      style: TextStyle(
                                                        color: peremptionColor,
                                                        fontSize: 9,
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
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }, // closes builder of LayoutBuilder
                  ); // closes LayoutBuilder
                }, // closes data of when
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, st) => Center(child: Text('Erreur: $e')),
                  ),
                ),
              ],
            ),
          ),
          
          const VerticalDivider(width: 1, thickness: 1),

          // DROITE : Panier
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.grey.shade50,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.green.shade50,
                    child: const Row(
                      children: [
                        Icon(Icons.shopping_cart, color: Colors.green),
                        SizedBox(width: 8),
                        Text('Panier', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: panier.isEmpty
                        ? const Center(child: Text('Le panier est vide.'))
                        : ListView.separated(
                            itemCount: panier.length,
                            separatorBuilder: (_, __) => const Divider(height: 1),
                            itemBuilder: (context, index) {
                              final item = panier[index];
                              return ListTile(
                                title: Text(item.produit.nom, style: const TextStyle(fontWeight: FontWeight.bold)),
                                subtitle: Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                                      onPressed: () => ref.read(panierProvider.notifier).diminuerQuantite(item.produit),
                                    ),
                                    Text('${item.quantite}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    IconButton(
                                      icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                                      onPressed: () => ref.read(panierProvider.notifier).ajouterProduit(item.produit),
                                    ),
                                  ],
                                ),
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(CurrencyFormatter.format(item.sousTotal), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    Text('${CurrencyFormatter.format(item.produit.prixVente)}/u', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                  ],
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              );
                            },
                          ),
                  ),
                  if (panier.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, -2))],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Total', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                              Text(CurrencyFormatter.format(total), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            isExpanded: true,
                            value: _modePaiement,
                            decoration: const InputDecoration(labelText: 'Mode de paiement', border: OutlineInputBorder()),
                            items: const [
                              DropdownMenuItem(value: 'Espèces', child: Text('Espèces')),
                             /* DropdownMenuItem(value: 'Carte Bancaire', child: Text('Carte Bancaire')),
                              DropdownMenuItem(value: 'Mobile Money', child: Text('Mobile Money')) */
                            ],
                            onChanged: (val) {
                              if (val != null) {
                                setState(() {
                                  _modePaiement = val;
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.check_circle),
                              label: const Text('Valider la vente', style: TextStyle(fontSize: 18)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: _validerVente,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextButton.icon(
                            icon: const Icon(Icons.delete_sweep),
                            label: const Text('Vider le panier'),
                            style: TextButton.styleFrom(foregroundColor: Colors.red),
                            onPressed: () {
                              ref.read(panierProvider.notifier).viderPanier();
                            },
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
