import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import '../database/database.dart';
import '../providers/panier_provider.dart';
import '../utils/currency_formatter.dart';
import '../utils/invoice_formatter.dart';
import '../repositories/factures_repository.dart';

class PdfService {
  static const _sep = '--------------------------------';

  static Future<Uint8List> generateInvoicePdf({
    required String factureId,
    required String numeroFacture,
    required Vente vente,
    required List<CartItem> items,
    String pharmacieNom = 'PHARMACIE POS',
  }) async {
    final pdf = pw.Document();

    // Monospace font (Courier) for clean column alignment
    final monoFont = pw.Font.courier();
    final monoBold = pw.Font.courierBold();

    final dateStr = DateFormat('dd/MM/yyyy HH:mm').format(vente.dateVente);
    final numFact = InvoiceFormatter.formatShort(vente.dateVente);

    pw.TextStyle mono(double size, {bool bold = false}) => pw.TextStyle(
          font: bold ? monoBold : monoFont,
          fontSize: size,
        );

    pw.Widget sep() => pw.Text(_sep, style: mono(8));

    // Build product lines
    final productLines = <pw.Widget>[];
    for (final item in items) {
      final nom = item.produit.nom;
      final qty = item.quantite;
      final pu = CurrencyFormatter.format(item.produit.prixVente);
      final sub = CurrencyFormatter.format(item.sousTotal);

      productLines.add(pw.Text(nom, style: mono(9, bold: true)));
      productLines.add(
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('$qty x $pu', style: mono(8)),
            pw.Text(sub, style: mono(8, bold: true)),
          ],
        ),
      );
      productLines.add(pw.SizedBox(height: 4));
    }

    pdf.addPage(
      pw.Page(
        // 80mm wide thermal roll, dynamic height
        pageFormat: PdfPageFormat(
          80 * PdfPageFormat.mm,
          double.infinity,
          marginAll: 4 * PdfPageFormat.mm,
        ),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              // ─── HEADER ───
              pw.Text(
                pharmacieNom.toUpperCase(),
                style: mono(11, bold: true),
                textAlign: pw.TextAlign.center,
              ),
              pw.SizedBox(height: 6),
              sep(),
              pw.SizedBox(height: 4),

              // ─── REÇU / FACTURE ───
              pw.Text('REÇU DE VENTE', style: mono(10, bold: true), textAlign: pw.TextAlign.center),
              pw.SizedBox(height: 4),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text('N° : $numFact', style: mono(8)),
              ),
              pw.Align(
                alignment: pw.Alignment.centerLeft,
                child: pw.Text('Date : $dateStr', style: mono(8)),
              ),
              pw.SizedBox(height: 4),
              sep(),
              pw.SizedBox(height: 6),

              // ─── PRODUITS ───
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                children: productLines,
              ),
              pw.SizedBox(height: 4),
              sep(),
              pw.SizedBox(height: 6),

              // ─── TOTAL ───
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Paiement:', style: mono(8)),
                  pw.Text(vente.modePaiement, style: mono(8, bold: true)),
                ],
              ),
              pw.SizedBox(height: 6),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('TOTAL', style: mono(11, bold: true)),
                  pw.Text(
                    CurrencyFormatter.format(vente.montantTotal),
                    style: mono(11, bold: true),
                  ),
                ],
              ),
              pw.SizedBox(height: 8),
              sep(),
              pw.SizedBox(height: 8),

              // ─── FOOTER ───
              pw.Text(
                'Merci de votre visite !',
                style: mono(8),
                textAlign: pw.TextAlign.center,
              ),
              pw.Text(
                'Bonne santé à vous.',
                style: mono(8),
                textAlign: pw.TextAlign.center,
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
                    InvoiceFormatter.formatShort(l.facture.dateEmission),
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
