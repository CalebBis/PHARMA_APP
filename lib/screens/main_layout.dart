import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import 'dashboard_screen.dart';

import 'produits/produits_screen.dart';
import 'ventes/ventes_screen.dart';
import 'rapports_screen.dart';
import 'parametres_screen.dart';
import 'login_screen.dart';

class MainLayout extends ConsumerStatefulWidget {
  const MainLayout({super.key});

  @override
  ConsumerState<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends ConsumerState<MainLayout> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider);
    final isPharmacien = ref.read(authProvider.notifier).isPharmacien;
    final pharmacieAsync = ref.watch(currentPharmacieProvider);
    
    final List<Widget> pages = [
      DashboardScreen(
        onNavigateToVentes: () {
          setState(() {
            _selectedIndex = 2; // Ventes index
          });
        },
      ),
      const ProduitsScreen(),
      const VentesScreen(),
      const RapportsScreen(),
      const ParametresScreen(),
    ];
    
    // We only show Parametres if the user is a pharmacien
    final destinations = [
      const NavigationRailDestination(
        icon: Icon(Icons.dashboard_outlined),
        selectedIcon: Icon(Icons.dashboard),
        label: Text('Dashboard'),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.medication_outlined),
        selectedIcon: Icon(Icons.medication),
        label: Text('Produits'),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.point_of_sale_outlined),
        selectedIcon: Icon(Icons.point_of_sale),
        label: Text('Ventes'),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.bar_chart_outlined),
        selectedIcon: Icon(Icons.bar_chart),
        label: Text('Rapports'),
      ),
    ];
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: true,
            minExtendedWidth: 250,
            selectedIndex: _selectedIndex < destinations.length ? _selectedIndex : null,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.none,
            backgroundColor: Colors.green.shade50,
            selectedIconTheme: const IconThemeData(color: Colors.green),
            selectedLabelTextStyle: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            leading: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
              child: pharmacieAsync.when(
                data: (ph) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (ph?.logoUrl != null && ph!.logoUrl!.isNotEmpty)
                      Image.network(ph.logoUrl!, height: 80, fit: BoxFit.contain)
                    else
                      const Icon(Icons.local_pharmacy, size: 60, color: Colors.green),
                    const SizedBox(height: 12),
                    Text(
                      ph?.nom ?? 'Ma Pharmacie',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                loading: () => const CircularProgressIndicator(),
                error: (_, __) => const Icon(Icons.local_pharmacy, size: 60, color: Colors.green),
              ),
            ),
            destinations: destinations,
            trailing: Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Divider(),
                      const SizedBox(height: 8),
                      CircleAvatar(
                        backgroundColor: Colors.green.shade200,
                        child: Text(user?.prenom.substring(0, 1).toUpperCase() ?? '?', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 8),
                      Text('${user?.prenom ?? ''} ${user?.nom ?? ''}'.trim().isEmpty ? 'Utilisateur' : '${user?.prenom ?? ''} ${user?.nom ?? ''}'.trim(), style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                      Text(user?.role.toUpperCase() ?? '', style: const TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.center),
                      const SizedBox(height: 8),
                      IconButton(
                        icon: Icon(Icons.settings, color: _selectedIndex == 4 ? Colors.green : Colors.grey),
                        tooltip: 'Paramètres',
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 4;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: pages[_selectedIndex],
          )
        ],
      ),
    );
  }
}
