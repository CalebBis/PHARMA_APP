import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import 'dashboard_screen.dart';

import 'produits/produits_screen.dart';
import 'ventes/ventes_screen.dart';
import 'factures/factures_screen.dart';
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

  final List<Widget> _pages = [
    const DashboardScreen(),
    const ProduitsScreen(),
    const VentesScreen(),
    const FacturesScreen(),
    const RapportsScreen(),
    const ParametresScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider);
    final isPharmacien = ref.read(authProvider.notifier).isPharmacien;
    
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
        icon: Icon(Icons.receipt_long_outlined),
        selectedIcon: Icon(Icons.receipt_long),
        label: Text('Factures'),
      ),
      const NavigationRailDestination(
        icon: Icon(Icons.bar_chart_outlined),
        selectedIcon: Icon(Icons.bar_chart),
        label: Text('Rapports'),
      ),
      if (isPharmacien)
        const NavigationRailDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings),
          label: Text('Paramètres'),
        ),
    ];
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            backgroundColor: Colors.green.shade50,
            selectedIconTheme: const IconThemeData(color: Colors.green),
            selectedLabelTextStyle: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
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
                        child: Text(user?.nom.substring(0, 1).toUpperCase() ?? '?', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 8),
                      Text(user?.nom ?? 'Utilisateur', style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                      Text(user?.role.toUpperCase() ?? '', style: const TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.center),
                      const SizedBox(height: 8),
                      IconButton(
                        icon: const Icon(Icons.logout, color: Colors.red),
                        tooltip: 'Déconnexion',
                        onPressed: () {
                          ref.read(authProvider.notifier).logout();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (_) => const LoginScreen()),
                          );
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
            child: _pages[_selectedIndex],
          )
        ],
      ),
    );
  }
}
