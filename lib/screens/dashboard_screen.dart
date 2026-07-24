import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../providers/dashboard_provider.dart';
import '../../utils/currency_formatter.dart';

class DashboardScreen extends ConsumerWidget {
  final VoidCallback? onNavigateToVentes;
  const DashboardScreen({super.key, this.onNavigateToVentes});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardDataAsync = ref.watch(dashboardDataProvider);

    return Scaffold(
      appBar: AppBar(
        
        title: const Text('Dashboard',
        style:TextStyle(fontWeight:FontWeight.bold, color:Colors.white)
        ),
        backgroundColor: Colors.green,
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
                    Expanded(child: _buildStatCard('Ventes du jour', CurrencyFormatter.format(data.ventesDuJour), Icons.attach_money, Colors.green, tendance: data.tendanceVentes )), 
                    const SizedBox(width: 16),
                    Expanded(child: _buildStatCard('Transactions (j)', '${data.transactionsDuJour}', Icons.receipt_long, Colors.blue, tendance: data.tendanceTransactions)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildStatCard('Top Produit (7j)', data.topProduit, Icons.star, Colors.orange)), 
                    const SizedBox(width: 16),
                    Expanded(child: _buildStatCard('Stock Bas', '${data.stockBas}', Icons.warning, Colors.red)),
                  ],
                ),
                const SizedBox(height: 16),
                
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Ventes des ${ref.watch(dashboardPeriodProvider) == 'Mois' ? '30 derniers jours' : ref.watch(dashboardPeriodProvider) == 'Année' ? '12 derniers mois' : '7 derniers jours'}',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                                ),
                                Row(
                                  children: [
                                    _buildPeriodButton(context, ref, '7 jours'),
                                    const SizedBox(width: 4),
                                    _buildPeriodButton(context, ref, 'Mois'),
                                    const SizedBox(width: 4),
                                    _buildPeriodButton(context, ref, 'Année'),
                                  ],
                                ),
                              ],
                            ),
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
                                    title: Text('${vente.description} — ${CurrencyFormatter.format(vente.montantTotal)}', style: const TextStyle(fontWeight: FontWeight.bold)),
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

  Widget _buildStatCard(String title, String value, IconData icon, Color color, {double? tendance}) {
    Widget? tendanceWidget;
    if (tendance != null) {
      final isPositive = tendance >= 0;
      tendanceWidget = Row(
        children: [
          Icon(isPositive ? Icons.arrow_upward : Icons.arrow_downward, color: isPositive ? Colors.green : Colors.red, size: 16),
          Text('${tendance.abs().toStringAsFixed(1)}%', style: TextStyle(color: isPositive ? Colors.green : Colors.red, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      );
    }

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                    if (tendanceWidget != null) tendanceWidget,
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodButton(BuildContext context, WidgetRef ref, String title) {
    final currentPeriod = ref.watch(dashboardPeriodProvider);
    final isActive = currentPeriod == title;

    return InkWell(
      onTap: () => ref.read(dashboardPeriodProvider.notifier).state = title,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? Colors.green : Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black87,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
        ),
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
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (group) => Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                CurrencyFormatter.format(rod.toY),
                const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              );
            },
          ),
        ),
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
                  } else if (parts.length == 2) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text('${parts[1]}/${parts[0].substring(2)}', style: const TextStyle(fontSize: 10)),
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
