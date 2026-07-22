import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import '../database/database.dart';
import '../providers/panier_provider.dart';
import '../utils/currency_formatter.dart';
import '../repositories/factures_repository.dart';

class PdfService {
  static Future<Uint8List> generateInvoicePdf({
    required String factureId,
    required String numeroFacture,
    required Vente vente,
    required List<CartItem> items,
  }) async {
    final pdf = pw.Document();
    
    final date = DateFormat('dd/MM/yyyy HH:mm').format(vente.dateVente);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('PHARMACIE POS', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                      pw.Text('123 Rue de la Santé'),
                      pw.Text('75000 Paris, France'),
                      pw.Text('Tél : 01 23 45 67 89'),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text('FACTURE', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold, color: PdfColors.green)),
                      pw.SizedBox(height: 8),
                      pw.Text('N° $numeroFacture'),
                      pw.Text('Date : $date'),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 40),
              
              // Table
              pw.TableHelper.fromTextArray(
                headers: ['Produit', 'Qté', 'Prix unitaire', 'Sous-total'],
                data: items.map((item) => [
                  item.produit.nom,
                  item.quantite.toString(),
                  CurrencyFormatter.format(item.produit.prixVente),
                  CurrencyFormatter.format(item.sousTotal),
                ]).toList(),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.white),
                headerDecoration: const pw.BoxDecoration(color: PdfColors.green),
                cellAlignment: pw.Alignment.centerRight,
                cellAlignments: {
                  0: pw.Alignment.centerLeft,
                },
              ),
              pw.SizedBox(height: 20),
              
              // Totals
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text('Mode de paiement : ${vente.modePaiement}', style: const pw.TextStyle(fontSize: 14)),
                      pw.SizedBox(height: 8),
                      pw.Text('TOTAL : ${CurrencyFormatter.format(vente.montantTotal)}', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
                    ],
                  ),
                ],
              ),
              pw.Spacer(),
              
              // Footer
              pw.Center(
                child: pw.Text(
                  'Merci de votre confiance !',
                  style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey),
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  static Future<Uint8List> generateReportPdf({
    required DateTime start,
    required DateTime end,
    required Map<String, dynamic> data,
    required List<Produit> stockBas,
    required List<Produit> expiringSoon,
    required List<FactureLigne> factureLignes,
    required String pharmacieNom,
  }) async {
    final pdf = pw.Document();
    
    final dateFormat = DateFormat('dd/MM/yyyy');
    final period = '${dateFormat.format(start)} au ${dateFormat.format(end)}';

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            // Header
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(pharmacieNom, style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                    pw.Text('Rapports d\'Activité'),
                  ],
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.end,
                  children: [
                    pw.Text('Période :', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text(period),
                    pw.Text('Généré le : ${dateFormat.format(DateTime.now())}'),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 40),
            
            // Stats
            pw.Text('Résumé des Ventes', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, color: PdfColors.green)),
            pw.Divider(color: PdfColors.green),
            pw.SizedBox(height: 10),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                _buildReportStatCard('Total Ventes', CurrencyFormatter.format(data['totalVentes'] as double), PdfColors.green),
                _buildReportStatCard('Transactions', '${data['nbTransactions']}', PdfColors.blue),
                _buildReportStatCard('Panier Moyen', CurrencyFormatter.format(data['panierMoyen'] as double), PdfColors.purple),
                _buildReportStatCard('Bénéfice Total', CurrencyFormatter.format(data['beneficeTotal'] as double), PdfColors.orange),
              ],
            ),
            pw.SizedBox(height: 30),

            // Alertes
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                _buildReportStatCard(
                  'Alerte Stock Bas',
                  stockBas.isEmpty ? 'Aucun produit' : '${stockBas.length} produit(s)',
                  PdfColors.orange,
                  width: 150,
                ),
                pw.SizedBox(width: 20),
                _buildReportStatCard(
                  'Péremption Proche',
                  expiringSoon.isEmpty ? 'Aucun produit' : '${expiringSoon.length} produit(s)',
                  PdfColors.red,
                  width: 150,
                ),
              ]
            ),
            pw.SizedBox(height: 30),

            // Factures
            pw.Text('Historique des Factures', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, color: PdfColors.blue)),
            pw.Divider(color: PdfColors.blue),
            pw.SizedBox(height: 10),
            if (factureLignes.isEmpty)
              pw.Text('Aucune donnée pour cette période.', style: const pw.TextStyle(color: PdfColors.grey))
            else
              pw.TableHelper.fromTextArray(
                headers: ['N° de Facture', 'Nom du Produit', 'Date', 'Quantité', 'Prix Unitaire', 'Total'],
                data: factureLignes.map((l) {
                  final total = l.detail.prixUnitaire * l.detail.quantite;
                  return [
                    l.facture.numeroFacture,
                    l.produit.nom,
                    dateFormat.format(l.facture.dateEmission),
                    l.detail.quantite.toString(),
                    CurrencyFormatter.format(l.detail.prixUnitaire),
                    CurrencyFormatter.format(total),
                  ];
                }).toList(),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                headerDecoration: const pw.BoxDecoration(color: PdfColors.grey200),
                cellAlignments: {
                  0: pw.Alignment.centerLeft,
                  1: pw.Alignment.centerLeft,
                  2: pw.Alignment.centerLeft,
                  3: pw.Alignment.centerRight,
                  4: pw.Alignment.centerRight,
                  5: pw.Alignment.centerRight,
                },
              ),
          ];
        },
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildReportStatCard(String label, String value, PdfColor iconColor, {double width = 110}) {
    return pw.Container(
      width: width,
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(label, style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600)),
          pw.SizedBox(height: 4),
          pw.Text(value, style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
        ]
      )
    );
  }
}
