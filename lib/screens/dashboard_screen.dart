import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../providers/dashboard_provider.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardDataAsync = ref.watch(dashboardDataProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: dashboardDataAsync.when(
        data: (data) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cards
                Row(
                  children: [
                    Expanded(child: _buildStatCard('Ventes du jour', '${data.ventesDuJour.toStringAsFixed(2)} €', Icons.attach_money, Colors.green)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildStatCard('Transactions (j)', '${data.transactionsDuJour}', Icons.receipt_long, Colors.blue)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildStatCard('Top Produit (7j)', data.topProduit, Icons.star, Colors.orange)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildStatCard('Stock Bas', '${data.stockBas}', Icons.warning, Colors.red)),
                  ],
                ),
                const SizedBox(height: 32),
                
                // Chart & Recent Sales
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Chart
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Ventes des 7 derniers jours', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: 300,
                              child: _buildChart(data.chartData),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Recent Sales
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Ventes récentes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 16),
                            if (data.ventesRecentes.isEmpty)
                              const Text('Aucune vente récente.')
                            else
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: data.ventesRecentes.length,
                                separatorBuilder: (context, index) => const Divider(),
                                itemBuilder: (context, index) {
                                  final vente = data.ventesRecentes[index];
                                  return ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    title: Text('${vente.montantTotal.toStringAsFixed(2)} €', style: const TextStyle(fontWeight: FontWeight.bold)),
                                    subtitle: Text(DateFormat('dd/MM HH:mm').format(vente.dateVente)),
                                    trailing: const Icon(Icons.receipt, color: Colors.green),
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Erreur: $e')),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChart(List<Map<String, dynamic>> chartData) {
    if (chartData.isEmpty) {
      return const Center(child: Text('Pas assez de données pour le graphique.'));
    }

    // Prepare data for fl_chart
    double maxY = 0;
    final List<BarChartGroupData> barGroups = [];
    
    for (int i = 0; i < chartData.length; i++) {
      final total = chartData[i]['total'] as double;
      if (total > maxY) maxY = total;
      
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: total,
              color: Colors.green,
              width: 16,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
            ),
          ],
        ),
      );
    }

    // Add some padding to maxY
    maxY = (maxY * 1.2).ceilToDouble();
    if (maxY == 0) maxY = 100;

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxY,
        barTouchData: BarTouchData(enabled: true),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index >= 0 && index < chartData.length) {
                  final dateStr = chartData[index]['jour'] as String;
                  // format date from YYYY-MM-DD to DD/MM
                  final parts = dateStr.split('-');
                  if (parts.length == 3) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text('${parts[2]}/${parts[1]}', style: const TextStyle(fontSize: 10)),
                    );
                  }
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                if (value == 0) return const Text('');
                return Text('${value.toInt()}', style: const TextStyle(fontSize: 10));
              },
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: maxY > 0 ? (maxY / 5) : 20,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.grey.withOpacity(0.2),
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: barGroups,
      ),
    );
  }
}
