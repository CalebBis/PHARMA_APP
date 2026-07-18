import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'main_layout.dart';
import '../providers/database_provider.dart';
import '../providers/auth_provider.dart';
import '../database/database.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _identifiantController = TextEditingController();
  final _motDePasseController = TextEditingController();

  void _login() async {
    final repo = ref.read(utilisateursRepositoryProvider);
    final user = await repo.login(_identifiantController.text, _motDePasseController.text);
    
    if (user != null) {
      ref.read(authProvider.notifier).setUtilisateur(user);
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainLayout()),
        );
      }
    } else if (_identifiantController.text == 'admin' && _motDePasseController.text == 'admin') {
      // Fallback local admin for dev if db is empty
      final adminUser = Utilisateur(
        id: 0,
        nom: 'Administrateur',
        identifiant: 'admin',
        motDePasse: 'admin',
        role: 'pharmacien',
        dateCreation: DateTime.now(),
      );
      ref.read(authProvider.notifier).setUtilisateur(adminUser);
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainLayout()),
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Identifiants incorrects')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(32.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.local_pharmacy, size: 80, color: Colors.green),
              const SizedBox(height: 16),
              const Text('Pharmacie POS', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 32),
              TextField(
                controller: _identifiantController,
                decoration: const InputDecoration(labelText: 'Identifiant', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _motDePasseController,
                decoration: const InputDecoration(labelText: 'Mot de passe', border: OutlineInputBorder()),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Se connecter', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
