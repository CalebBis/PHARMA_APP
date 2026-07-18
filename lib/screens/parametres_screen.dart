import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import '../../providers/database_provider.dart';
import '../../providers/auth_provider.dart';
import '../../database/database.dart';

class ParametresScreen extends ConsumerStatefulWidget {
  const ParametresScreen({super.key});

  @override
  ConsumerState<ParametresScreen> createState() => _ParametresScreenState();
}

class _ParametresScreenState extends ConsumerState<ParametresScreen> {
  bool _isLoading = false;

  Future<void> _backupDatabase() async {
    setState(() => _isLoading = true);
    try {
      final dbFolder = await getApplicationDocumentsDirectory();
      final dbPath = p.join(dbFolder.path, 'pharmacie_app_db.sqlite');
      final file = File(dbPath);

      if (!await file.exists()) {
        throw Exception("Fichier de base de données introuvable.");
      }

      final dateStr = DateFormat('yyyy-MM-dd').format(DateTime.now());
      String? outputFile = await FilePicker.platform.saveFile(
        dialogTitle: 'Sauvegarder la base de données',
        fileName: 'pharmacie_backup_$dateStr.sqlite',
        type: FileType.custom,
        allowedExtensions: ['sqlite', 'db'],
      );

      if (outputFile != null) {
        await file.copy(outputFile);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Sauvegarde réussie : $outputFile'), backgroundColor: Colors.green),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la sauvegarde : $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _restoreDatabase() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Attention', style: TextStyle(color: Colors.red)),
        content: const Text('La restauration écrasera toutes les données actuelles. L\'application devra être redémarrée.\n\nVoulez-vous continuer ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Restaurer'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() => _isLoading = true);
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        dialogTitle: 'Sélectionner une sauvegarde',
        type: FileType.custom,
        allowedExtensions: ['sqlite', 'db'],
      );

      if (result != null && result.files.single.path != null) {
        final backupFile = File(result.files.single.path!);
        final dbFolder = await getApplicationDocumentsDirectory();
        final dbPath = p.join(dbFolder.path, 'pharmacie_app_db.sqlite');
        final currentFile = File(dbPath);

        // Close the database to avoid lock issues
        await ref.read(databaseProvider).close();
        
        await backupFile.copy(currentFile.path);
        
        if (mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (ctx) => AlertDialog(
              title: const Text('Restauration réussie'),
              content: const Text('La base de données a été restaurée.\nVeuillez redémarrer l\'application pour appliquer les changements.'),
              actions: [
                TextButton(
                  onPressed: () => exit(0), // Exits the app (works on Desktop)
                  child: const Text('Quitter'),
                ),
              ],
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la restauration : $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _creerVendeuse() async {
    final identifiantCtrl = TextEditingController();
    final motDePasseCtrl = TextEditingController();
    final nomCtrl = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Créer un compte Vendeuse', style: TextStyle(color: Colors.green)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nomCtrl, decoration: const InputDecoration(labelText: 'Nom complet')),
            const SizedBox(height: 8),
            TextField(controller: identifiantCtrl, decoration: const InputDecoration(labelText: 'Identifiant')),
            const SizedBox(height: 8),
            TextField(controller: motDePasseCtrl, decoration: const InputDecoration(labelText: 'Mot de passe')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Annuler')),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
            child: const Text('Créer'),
          ),
        ],
      ),
    );

    if (result == true && identifiantCtrl.text.isNotEmpty && motDePasseCtrl.text.isNotEmpty) {
      final repo = ref.read(utilisateursRepositoryProvider);
      await repo.ajouterUtilisateur(UtilisateursCompanion.insert(
        nom: nomCtrl.text,
        identifiant: identifiantCtrl.text,
        motDePasse: motDePasseCtrl.text,
        role: 'vendeuse',
        dateCreation: DateTime.now(),
      ));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Compte vendeuse créé avec succès !'), backgroundColor: Colors.green),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPharmacien = ref.read(authProvider.notifier).isPharmacien;
    if (!isPharmacien) {
      return const Center(child: Text('Accès refusé.'));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres'),
        backgroundColor: Colors.white,
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              const Text('Base de données', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
              const Divider(),
              const SizedBox(height: 16),
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.backup, color: Colors.blue, size: 40),
                        title: const Text('Sauvegarder la base de données', style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: const Text('Crée une copie du fichier de base de données.'),
                        trailing: ElevatedButton(
                          onPressed: _backupDatabase,
                          child: const Text('Sauvegarder'),
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.restore, color: Colors.red, size: 40),
                        title: const Text('Restaurer une sauvegarde', style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: const Text('Remplace les données actuelles par une sauvegarde. Attention, irréversible !'),
                        trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                          onPressed: _restoreDatabase,
                          child: const Text('Restaurer'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const Text('Gestion des Utilisateurs', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
              const Divider(),
              const SizedBox(height: 16),
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListTile(
                    leading: const Icon(Icons.people, color: Colors.orange, size: 40),
                    title: const Text('Comptes Vendeuses', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text('Créer ou gérer les comptes des vendeuses.'),
                    trailing: ElevatedButton(
                      onPressed: _creerVendeuse,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
                      child: const Text('Ajouter'),
                    ),
                  ),
                ),
              )
            ],
          ),
    );
  }
}
