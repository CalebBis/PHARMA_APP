import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../../providers/produits_provider.dart';
import '../../providers/panier_provider.dart';
import '../../database/database.dart';
import '../../providers/database_provider.dart';
import '../../services/pdf_service.dart';
import '../../utils/currency_formatter.dart';
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
                      return GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 3 / 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: produits.length,
                        itemBuilder: (context, index) {
                          final p = produits[index];
                          final isOutOfStock = p.quantiteStock <= 0;
                          return Card(
                            elevation: 2,
                            color: isOutOfStock ? Colors.grey.shade200 : Colors.white,
                            child: InkWell(
                              onTap: isOutOfStock
                                  ? null
                                  : () => ref.read(panierProvider.notifier).ajouterProduit(p),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      p.nom,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: isOutOfStock ? Colors.grey : Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(CurrencyFormatter.format(p.prixVente), style: const TextStyle(color: Colors.green, fontSize: 16)),
                                    const Spacer(),
                                    Text(
                                      isOutOfStock ? 'Rupture' : 'Stock: ${p.quantiteStock}',
                                      style: TextStyle(color: isOutOfStock ? Colors.red : Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
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
