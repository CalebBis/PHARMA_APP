import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database.dart';
import 'database_provider.dart';

class DashboardData {
  final double ventesDuJour;
  final double tendanceVentes; // percentage
  final int transactionsDuJour;
  final double tendanceTransactions; // percentage
  final String topProduit;
  final int stockBas;
  final List<Map<String, dynamic>> chartData;
  final List<Vente> ventesRecentes;

  DashboardData({
    required this.ventesDuJour,
    required this.tendanceVentes,
    required this.transactionsDuJour,
    required this.tendanceTransactions,
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
  final ventesVeille = await ventesRepo.getVentesDeLaVeille();
  final transactionsDuJour = await ventesRepo.getNombreTransactionsDuJour();
  final transactionsVeille = await ventesRepo.getTransactionsDeLaVeille();
  
  final topProduit = await ventesRepo.getTopProduit(7) ?? 'Aucun';
  final stockBas = await produitsRepo.getCompteStockBas();
  final chartData = await ventesRepo.getVentesParJour(7);
  final ventesRecentes = await ventesRepo.getVentesRecentes(10);

  double tendanceVentes = 0;
  if (ventesVeille > 0) {
    tendanceVentes = ((ventesDuJour - ventesVeille) / ventesVeille) * 100;
  } else if (ventesDuJour > 0) {
    tendanceVentes = 100;
  }

  double tendanceTransactions = 0;
  if (transactionsVeille > 0) {
    tendanceTransactions = ((transactionsDuJour - transactionsVeille) / transactionsVeille) * 100;
  } else if (transactionsDuJour > 0) {
    tendanceTransactions = 100;
  }

  return DashboardData(
    ventesDuJour: ventesDuJour,
    tendanceVentes: tendanceVentes,
    transactionsDuJour: transactionsDuJour,
    tendanceTransactions: tendanceTransactions,
    topProduit: topProduit,
    stockBas: stockBas,
    chartData: chartData,
    ventesRecentes: ventesRecentes,
  );
});
