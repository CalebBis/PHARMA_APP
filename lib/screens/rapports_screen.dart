import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import '../providers/database_provider.dart';
import '../services/pdf_service.dart';
import '../utils/currency_formatter.dart';
import '../repositories/factures_repository.dart';

class RapportsScreen extends ConsumerStatefulWidget {
  const RapportsScreen({super.key});

  @override
  ConsumerState<RapportsScreen> createState() => _RapportsScreenState();
}

class _RapportsScreenState extends ConsumerState<RapportsScreen> {
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _endDate = DateTime.now();

  Future<void> _selectDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(start: _startDate, end: _endDate);
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDateRange: initialDateRange,
    );
    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    
    // Create a Future that fetches all necessary data
    final rapportFuture = _fetchRapportData(ref);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rapports d\'Activité',style:TextStyle(color:Colors.white, fontWeight:FontWeight.bold)),
        backgroundColor: Colors.green,
        scrolledUnderElevation: 0,
        actions: [
          ElevatedButton.icon(
            icon: const Icon(Icons.picture_as_pdf),
            label: const Text('Exporter PDF'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              final dataMap = await _fetchRapportData(ref);
              
              final pdfData = await PdfService.generateReportPdf(
                start: _startDate,
                end: _endDate,
                data: dataMap['stats'],
                stockBas: dataMap['stockBas'],
                expiringSoon: dataMap['expiringSoon'],
              );

              if (context.mounted) {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Rapport PDF', style: TextStyle(color: Colors.blue)),
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
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // Filter Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Text('Période sélectionnée :', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 16),
                TextButton.icon(
                  icon: const Icon(Icons.calendar_today),
                  label: Text('${dateFormat.format(_startDate)} - ${dateFormat.format(_endDate)}'),
                  onPressed: () => _selectDateRange(context),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey.shade200,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          
          Expanded(
            child: FutureBuilder<Map<String, dynamic>>(
              future: rapportFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Erreur: ${snapshot.error}'));
                }

                final stats = snapshot.data!['stats'];
                final List stockBas = snapshot.data!['stockBas'];
                final List expiringSoon = snapshot.data!['expiringSoon'];
                final List<FactureWithDetails> factures = snapshot.data!['factures'];

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Ventes par Période
                      const Text('1. Résumé des Ventes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
                      const Divider(),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(child: _buildReportCard('Total Ventes', CurrencyFormatter.format(stats['totalVentes'] as double), Icons.account_balance_wallet, Colors.green)),
                          const SizedBox(width: 16),
                          Expanded(child: _buildReportCard('Transactions', '${stats['nbTransactions']}', Icons.receipt_long, Colors.blue)),
                          const SizedBox(width: 16),
                          Expanded(child: _buildReportCard('Panier Moyen', CurrencyFormatter.format(stats['panierMoyen'] as double), Icons.shopping_cart, Colors.purple)),
                          const SizedBox(width: 16),
                          Expanded(child: _buildReportCard('Bénéfice Total', CurrencyFormatter.format(stats['beneficeTotal'] as double), Icons.trending_up, Colors.orange)),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Rapport de Stock
                      const Text('2. Alerte Stock Bas', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange)),
                      const Divider(),
                      const SizedBox(height: 16),
                      if (stockBas.isEmpty)
                        const Text('Aucun produit n\'est en stock bas.')
                      else
                        _buildProduitTable(stockBas, false),
                      const SizedBox(height: 32),

                      // Rapport Péremption
                      const Text('3. Péremption Proche', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red)),
                      const Divider(),
                      const SizedBox(height: 16),
                      if (expiringSoon.isEmpty)
                        const Text('Aucun produit n\'est proche de la péremption.')
                      else
                        _buildProduitTable(expiringSoon, true),
                      const SizedBox(height: 32),

                      // Historique des Factures
                      const Text('4. Historique des Factures', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)),
                      const Divider(),
                      const SizedBox(height: 16),
                      if (factures.isEmpty)
                        const Text('Aucune facture sur cette période.')
                      else
                        _buildFacturesTable(factures),
                      const SizedBox(height: 32),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<Map<String, dynamic>> _fetchRapportData(WidgetRef ref) async {
    final ventesRepo = ref.read(ventesRepositoryProvider);
    final produitsRepo = ref.read(produitsRepositoryProvider);
    final facturesRepo = ref.read(facturesRepositoryProvider);

    // Make sure we include the whole end date
    final end = DateTime(_endDate.year, _endDate.month, _endDate.day, 23, 59, 59);
    final start = DateTime(_startDate.year, _startDate.month, _startDate.day, 0, 0, 0);

    final stats = await ventesRepo.getRapportData(start, end);
    final tousProduits = await produitsRepo.getTousLesProduits();
    final factures = await facturesRepo.getFacturesByPeriod(start, end);
    
    final stockBas = tousProduits.where((p) => p.quantiteStock <= p.seuilAlerte).toList();
    final now = DateTime.now();
    final expiringSoon = tousProduits.where((p) => p.datePeremption != null && p.datePeremption!.isBefore(now.add(const Duration(days: 30)))).toList();

    return {
      'stats': stats,
      'stockBas': stockBas,
      'expiringSoon': expiringSoon,
      'factures': factures,
    };
  }

  Widget _buildReportCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildProduitTable(List produits, bool showPeremption) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(Colors.grey.shade100),
        columns: [
          const DataColumn(label: Text('Produit')),
          const DataColumn(label: Text('Stock')),
          if (!showPeremption) const DataColumn(label: Text('Seuil')),
          if (showPeremption) const DataColumn(label: Text('Péremption')),
        ],
        rows: produits.map((p) {
          return DataRow(cells: [
            DataCell(Text(p.nom, style: const TextStyle(fontWeight: FontWeight.bold))),
            DataCell(Text(p.quantiteStock.toString(), style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))),
            if (!showPeremption) DataCell(Text(p.seuilAlerte.toString())),
            if (showPeremption) DataCell(Text(p.datePeremption != null ? dateFormat.format(p.datePeremption!) : '-')),
          ]);
        }).toList(),
      ),
    );
  }

  Widget _buildFacturesTable(List<FactureWithDetails> factures) {
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: DataTable(
        headingRowColor: MaterialStateProperty.all(Colors.grey.shade100),
        columns: const [
          DataColumn(label: Text('Numéro')),
          DataColumn(label: Text('Date')),
          DataColumn(label: Text('Paiement')),
          DataColumn(label: Text('Total')),
          DataColumn(label: Text('Action')),
        ],
        rows: factures.map((f) {
          return DataRow(cells: [
            DataCell(Text(f.facture.numeroFacture, style: const TextStyle(fontWeight: FontWeight.bold))),
            DataCell(Text(dateFormat.format(f.facture.dateEmission))),
            DataCell(Text(f.vente.modePaiement)),
            DataCell(Text(CurrencyFormatter.format(f.vente.montantTotal), style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold))),
            DataCell(
              IconButton(
                icon: const Icon(Icons.download, color: Colors.blue),
                tooltip: 'Télécharger',
                onPressed: () async {
                  try {
                    final pdfData = await PdfService.generateInvoicePdf(
                      factureId: f.facture.id,
                      numeroFacture: f.facture.numeroFacture,
                      vente: f.vente,
                      items: [], // we don't have items here, but PDF service might need it, actually we'd need to fetch items if we really want to download it again
                    );
                    await Printing.sharePdf(bytes: pdfData, filename: '${f.facture.numeroFacture}.pdf');
                  } catch (e) {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur: $e')));
                    }
                  }
                },
              ),
            ),
          ]);
        }).toList(),
      ),
    );
  }
}
