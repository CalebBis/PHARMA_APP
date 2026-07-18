import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import '../database/database.dart';
import '../providers/panier_provider.dart';

class PdfService {
  static Future<Uint8List> generateInvoicePdf({
    required int factureId,
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
                  '${item.produit.prixVente.toStringAsFixed(2)} €',
                  '${item.sousTotal.toStringAsFixed(2)} €',
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
                      pw.Text('TOTAL : ${vente.montantTotal.toStringAsFixed(2)} €', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
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
                    pw.Text('PHARMACIE POS', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                    pw.Text('Rapport d\'Activité'),
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
            pw.Text('1. Résumé des Ventes', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, color: PdfColors.green)),
            pw.Divider(),
            pw.SizedBox(height: 10),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
              children: [
                _buildReportStat('Transactions', '${data['nbTransactions']}'),
                _buildReportStat('Total Ventes', '${(data['totalVentes'] as double).toStringAsFixed(2)} €'),
                _buildReportStat('Panier Moyen', '${(data['panierMoyen'] as double).toStringAsFixed(2)} €'),
                _buildReportStat('Bénéfice Total', '${(data['beneficeTotal'] as double).toStringAsFixed(2)} €'),
              ],
            ),
            pw.SizedBox(height: 30),

            // Stock
            pw.Text('2. Alerte Stock Bas (${stockBas.length} produits)', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, color: PdfColors.orange)),
            pw.Divider(),
            pw.SizedBox(height: 10),
            if (stockBas.isEmpty)
              pw.Text('Aucun produit en stock bas.')
            else
              pw.TableHelper.fromTextArray(
                headers: ['Produit', 'Stock Actuel', 'Seuil'],
                data: stockBas.map((p) => [p.nom, p.quantiteStock.toString(), p.seuilAlerte.toString()]).toList(),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
              ),
            pw.SizedBox(height: 30),

            // Peremption
            pw.Text('3. Péremption Proche (${expiringSoon.length} produits)', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, color: PdfColors.red)),
            pw.Divider(),
            pw.SizedBox(height: 10),
            if (expiringSoon.isEmpty)
              pw.Text('Aucun produit proche de la péremption.')
            else
              pw.TableHelper.fromTextArray(
                headers: ['Produit', 'Stock', 'Date de Péremption'],
                data: expiringSoon.map((p) => [
                  p.nom,
                  p.quantiteStock.toString(),
                  p.datePeremption != null ? dateFormat.format(p.datePeremption!) : '-',
                ]).toList(),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
              ),
          ];
        },
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildReportStat(String label, String value) {
    return pw.Column(
      children: [
        pw.Text(label, style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey)),
        pw.SizedBox(height: 4),
        pw.Text(value, style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
      ]
    );
  }
}
