import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import '../../providers/factures_provider.dart';
import '../../providers/database_provider.dart';
import '../../providers/panier_provider.dart';
import '../../services/pdf_service.dart';

class FacturesScreen extends ConsumerWidget {
  const FacturesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final facturesAsync = ref.watch(facturesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historique des Factures'),
        backgroundColor: Colors.white,
      ),
      body: facturesAsync.when(
        data: (factures) {
          if (factures.isEmpty) {
            return const Center(child: Text('Aucune facture générée.'));
          }

          return SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(Colors.grey.shade100),
                columns: const [
                  DataColumn(label: Text('Numéro')),
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Total')),
                  DataColumn(label: Text('Paiement')),
                  DataColumn(label: Text('Action')),
                ],
                rows: factures.map((fw) {
                  final facture = fw.facture;
                  final vente = fw.vente;
                  
                  return DataRow(cells: [
                    DataCell(Text(facture.numeroFacture, style: const TextStyle(fontWeight: FontWeight.bold))),
                    DataCell(Text(DateFormat('dd/MM/yyyy HH:mm').format(facture.dateEmission))),
                    DataCell(Text('${vente.montantTotal.toStringAsFixed(2)} €')),
                    DataCell(Text(vente.modePaiement)),
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.print, color: Colors.blue),
                            tooltip: 'Aperçu / Imprimer',
                            onPressed: () async {
                              final db = ref.read(databaseProvider);
                              final itemsDb = await (db.select(db.venteDetails)..where((d) => d.venteId.equals(vente.id))).get();
                              
                              final List<CartItem> cartItems = [];
                              for(var item in itemsDb) {
                                final produit = await (db.select(db.produits)..where((p) => p.id.equals(item.produitId))).getSingle();
                                cartItems.add(CartItem(produit: produit, quantite: item.quantite));
                              }
                              
                              final pdfData = await PdfService.generateInvoicePdf(
                                factureId: facture.id,
                                numeroFacture: facture.numeroFacture,
                                vente: vente,
                                items: cartItems,
                              );

                              if (context.mounted) {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text('Facture ${facture.numeroFacture}', style: const TextStyle(color: Colors.green)),
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
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.download, color: Colors.green),
                            tooltip: 'Télécharger le PDF',
                            onPressed: () async {
                              final db = ref.read(databaseProvider);
                              final itemsDb = await (db.select(db.venteDetails)..where((d) => d.venteId.equals(vente.id))).get();
                              
                              final List<CartItem> cartItems = [];
                              for(var item in itemsDb) {
                                final produit = await (db.select(db.produits)..where((p) => p.id.equals(item.produitId))).getSingle();
                                cartItems.add(CartItem(produit: produit, quantite: item.quantite));
                              }
                              
                              final pdfData = await PdfService.generateInvoicePdf(
                                factureId: facture.id,
                                numeroFacture: facture.numeroFacture,
                                vente: vente,
                                items: cartItems,
                              );
                              
                              await Printing.sharePdf(
                                bytes: pdfData,
                                filename: 'facture_${facture.numeroFacture}.pdf',
                              );
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
    );
  }
}
