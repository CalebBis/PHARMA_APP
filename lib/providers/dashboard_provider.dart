import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database.dart';
import 'database_provider.dart';

class DashboardData {
  final double ventesDuJour;
  final int transactionsDuJour;
  final String topProduit;
  final int stockBas;
  final List<Map<String, dynamic>> chartData;
  final List<Vente> ventesRecentes;

  DashboardData({
    required this.ventesDuJour,
    required this.transactionsDuJour,
    required this.topProduit,
    required this.stockBas,
    required this.chartData,
    required this.ventesRecentes,
  });
}

final dashboardDataProvider = FutureProvider.autoDispose<DashboardData>((ref) async {
  final ventesRepo = ref.watch(ventesRepositoryProvider);
  final produitsRepo = ref.watch(produitsRepositoryProvider);

  final ventesDuJour = await ventesRepo.getVentesDuJour();
  final transactionsDuJour = await ventesRepo.getNombreTransactionsDuJour();
  final topProduit = await ventesRepo.getTopProduit(7) ?? 'Aucun';
  final stockBas = await produitsRepo.getCompteStockBas();
  final chartData = await ventesRepo.getVentesParJour(7);
  final ventesRecentes = await ventesRepo.getVentesRecentes(10);

  return DashboardData(
    ventesDuJour: ventesDuJour,
    transactionsDuJour: transactionsDuJour,
    topProduit: topProduit,
    stockBas: stockBas,
    chartData: chartData,
    ventesRecentes: ventesRecentes,
  );
});
