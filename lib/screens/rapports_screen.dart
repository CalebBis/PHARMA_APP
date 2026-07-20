import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import '../providers/database_provider.dart';
import '../services/pdf_service.dart';
import '../utils/currency_formatter.dart';
import '../repositories/factures_repository.dart';
import '../providers/auth_provider.dart';

enum FilterPeriod {
  journalier,
  hebdo,
  mensuel,
  semestriel,
  annuel
}

class RapportsScreen extends ConsumerStatefulWidget {
  const RapportsScreen({super.key});

  @override
  ConsumerState<RapportsScreen> createState() => _RapportsScreenState();
}

class _RapportsScreenState extends ConsumerState<RapportsScreen> {
  FilterPeriod _selectedPeriod = FilterPeriod.mensuel;

  DateTimeRange _getDateRangeForPeriod(FilterPeriod period) {
    final now = DateTime.now();
    final end = DateTime(now.year, now.month, now.day, 23, 59, 59);
    DateTime start;

    switch (period) {
      case FilterPeriod.journalier:
        start = DateTime(now.year, now.month, now.day, 0, 0, 0);
        break;
      case FilterPeriod.hebdo:
        start = end.subtract(Duration(days: now.weekday - 1));
        start = DateTime(start.year, start.month, start.day, 0, 0, 0);
        break;
      case FilterPeriod.mensuel:
        start = DateTime(now.year, now.month, 1, 0, 0, 0);
        break;
      case FilterPeriod.semestriel:
        int currentMonth = now.month;
        int startMonth = currentMonth <= 6 ? 1 : 7;
        start = DateTime(now.year, startMonth, 1, 0, 0, 0);
        break;
      case FilterPeriod.annuel:
        start = DateTime(now.year, 1, 1, 0, 0, 0);
        break;
    }

    return DateTimeRange(start: start, end: end);
  }

  @override
  Widget build(BuildContext context) {
    final range = _getDateRangeForPeriod(_selectedPeriod);
    final rapportFuture = _fetchRapportData(ref, range);
    final pharmacieAsync = ref.watch(currentPharmacieProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FBF9), // Lighter background matching the mock
      appBar: AppBar(
        title: const Text('Rapports d\'Activité', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
              final dataMap = await _fetchRapportData(ref, range);
              String pharmacieNom = 'PHARMACIE POS';
              
              if (pharmacieAsync.hasValue && pharmacieAsync.value != null) {
                 pharmacieNom = pharmacieAsync.value!.nom;
              }

              final pdfData = await PdfService.generateReportPdf(
                start: range.start,
                end: range.end,
                data: dataMap['stats'],
                stockBas: dataMap['stockBas'],
                expiringSoon: dataMap['expiringSoon'],
                factureLignes: dataMap['factureLignes'],
                pharmacieNom: pharmacieNom,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                _buildFilterButton('Journalier', FilterPeriod.journalier),
                const SizedBox(width: 8),
                _buildFilterButton('Hebdo', FilterPeriod.hebdo),
                const SizedBox(width: 8),
                _buildFilterButton('Mensuel', FilterPeriod.mensuel),
                const SizedBox(width: 8),
                _buildFilterButton('Semestriel', FilterPeriod.semestriel),
                const SizedBox(width: 8),
                _buildFilterButton('Annuel', FilterPeriod.annuel),
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
                final List<FactureLigne> factureLignes = snapshot.data!['factureLignes'];

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Ventes par Période
                      const Text('Résumé des Ventes', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
                      const Divider(color: Colors.green),
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
                      const SizedBox(height: 16),

                      // Rapport de Stock et Péremption (Affichés sous forme de cartes d'alerte)
                      Row(
                        children: [
                          Expanded(
                            child: _buildReportCard(
                              'Alerte Stock Bas',
                              stockBas.isEmpty ? 'Aucun produit' : '${stockBas.length} produit(s)',
                              Icons.error_outline,
                              Colors.orange,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildReportCard(
                              'Péremption Proche',
                              expiringSoon.isEmpty ? 'Aucun produit' : '${expiringSoon.length} produit(s)',
                              Icons.event_busy,
                              Colors.red,
                            ),
                          ),
                          const Spacer(flex: 2), // To keep the cards the same size as the top ones if we want, or adjust flex
                        ],
                      ),
                      const SizedBox(height: 32),

                      // Historique des Factures
                      const Text('Historique des Factures', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue)),
                      const Divider(color: Colors.blue),
                      const SizedBox(height: 16),
                      if (factureLignes.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('Aucune donnée pour cette période.', style: TextStyle(fontStyle: FontStyle.italic)),
                        )
                      else
                        _buildFacturesLignesTable(factureLignes),
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

  Widget _buildFilterButton(String label, FilterPeriod period) {
    final isActive = _selectedPeriod == period;
    return OutlinedButton(
      onPressed: () {
        setState(() {
          _selectedPeriod = period;
        });
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: isActive ? Colors.green : Colors.white,
        foregroundColor: isActive ? Colors.white : Colors.black87,
        side: BorderSide(color: isActive ? Colors.green : Colors.grey.shade300),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(label),
    );
  }

  Future<Map<String, dynamic>> _fetchRapportData(WidgetRef ref, DateTimeRange range) async {
    final ventesRepo = ref.read(ventesRepositoryProvider);
    final produitsRepo = ref.read(produitsRepositoryProvider);
    final facturesRepo = ref.read(facturesRepositoryProvider);

    final stats = await ventesRepo.getRapportData(range.start, range.end);
    final tousProduits = await produitsRepo.getTousLesProduits();
    final factureLignes = await facturesRepo.getFactureLignesByPeriod(range.start, range.end);
    
    final stockBas = tousProduits.where((p) => p.quantiteStock <= p.seuilAlerte).toList();
    final now = DateTime.now();
    final expiringSoon = tousProduits.where((p) => p.datePeremption != null && p.datePeremption!.isBefore(now.add(const Duration(days: 30)))).toList();

    return {
      'stats': stats,
      'stockBas': stockBas,
      'expiringSoon': expiringSoon,
      'factureLignes': factureLignes,
    };
  }

  Widget _buildReportCard(String title, String value, IconData icon, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(height: 12),
          Text(title, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildFacturesLignesTable(List<FactureLigne> lignes) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(Colors.grey.shade100),
          columns: const [
            DataColumn(label: Text('N° de Facture', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Nom du Produit', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Date', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Quantité', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Prix Unitaire', style: TextStyle(fontWeight: FontWeight.bold))),
            DataColumn(label: Text('Total', style: TextStyle(fontWeight: FontWeight.bold))),
          ],
          rows: lignes.map((l) {
            final double totalLigne = l.produit.prixVente * l.detail.quantite;
            return DataRow(cells: [
              DataCell(Text(l.facture.numeroFacture)),
              DataCell(Text(l.produit.nom)),
              DataCell(Text(dateFormat.format(l.facture.dateEmission))),
              DataCell(Text(l.detail.quantite.toString())),
              DataCell(Text(CurrencyFormatter.format(l.produit.prixVente))),
              DataCell(Text(CurrencyFormatter.format(totalLigne))),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
