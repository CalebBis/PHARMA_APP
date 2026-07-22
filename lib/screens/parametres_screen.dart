import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import '../providers/database_provider.dart';
import '../providers/auth_provider.dart';
import '../utils/text_formatters.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sp;
import '../widgets/confirm_dialog.dart';
import 'login_screen.dart';
class ParametresScreen extends ConsumerStatefulWidget {
  const ParametresScreen({super.key});

  @override
  ConsumerState<ParametresScreen> createState() => _ParametresScreenState();
}

class _ParametresScreenState extends ConsumerState<ParametresScreen> {
  bool _isLoading = false;

  Future<void> _confirmerDeconnexion() async {
    final confirmer = await ConfirmDialog.show(
      context: context,
      title: 'Déconnexion',
      message: 'Êtes-vous sûr de vouloir vous déconnecter ?',
      confirmText: 'Se déconnecter',
      confirmColor: Colors.red,
    );

    if (confirmer == true && mounted) {
      ref.read(authProvider.notifier).logout();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

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
            TextField(
              controller: nomCtrl, 
              decoration: const InputDecoration(labelText: 'Nom complet'),
              inputFormatters: [TitleCaseTextInputFormatter()],
            ),
            const SizedBox(height: 8),
            TextField(controller: identifiantCtrl, decoration: const InputDecoration(labelText: 'Email (Identifiant)')),
            const SizedBox(height: 8),
            TextField(controller: motDePasseCtrl, decoration: const InputDecoration(labelText: 'Mot de passe (min 6 caractères)')),
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
      try {
        setState(() => _isLoading = true);
        final supabase = ref.read(authServiceProvider).supabase; 
        final currentUser = ref.read(authProvider);
        
        if (currentUser == null) throw Exception("Non authentifié");

        final res = await supabase.auth.signUp(
          email: identifiantCtrl.text.trim(),
          password: motDePasseCtrl.text,
        );
        
        if (res.user != null) {
          // Insert into utilisateurs_profil
          await supabase.from('utilisateurs_profil').insert({
            'id': res.user!.id,
            'prenom': '', // Placeholder since prenom is now required in DB
            'nom': toTitleCase(nomCtrl.text.trim()),
            'role': 'vendeuse',
            'pharmacie_id': currentUser.pharmacieId,
          });
        }
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Compte vendeuse créé avec succès ! Veuillez vous reconnecter.'), backgroundColor: Colors.green),
          );
          // Logout current user because signup logs in the new user in Supabase
          ref.read(authProvider.notifier).logout();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur: $e'), backgroundColor: Colors.red),
          );
        }
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _updatePharmacieNom(String pharmacieId, String currentNom) async {
    final nomCtrl = TextEditingController(text: currentNom);
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Modifier le nom', style: TextStyle(color: Colors.green)),
        content: TextField(controller: nomCtrl, decoration: const InputDecoration(labelText: 'Nom de la pharmacie')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Annuler')),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
            child: const Text('Enregistrer'),
          ),
        ],
      ),
    );

    if (result == true && nomCtrl.text.isNotEmpty) {
      setState(() => _isLoading = true);
      try {
        final supabase = ref.read(authServiceProvider).supabase;
        await supabase.from('pharmacies').update({
          'nom': nomCtrl.text, 
          'updated_at': DateTime.now().toIso8601String()
        }).eq('id', pharmacieId);
        
        await ref.read(syncServiceProvider).syncAll();
      } catch (e) {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur: $e')));
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _uploadLogo(String pharmacieId) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.single.path != null) {
        setState(() => _isLoading = true);
        final file = File(result.files.single.path!);
        final ext = result.files.single.extension;
        final fileName = 'logo_$pharmacieId.$ext';
        
        final supabase = ref.read(authServiceProvider).supabase;
        
        await supabase.storage.from('logos').upload(fileName, file, fileOptions: const sp.FileOptions(upsert: true));
        final url = supabase.storage.from('logos').getPublicUrl(fileName);
        
        await supabase.from('pharmacies').update({
          'logo_url': url, 
          'updated_at': DateTime.now().toIso8601String()
        }).eq('id', pharmacieId);
        
        await ref.read(syncServiceProvider).syncAll();
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Logo mis à jour', style: TextStyle(color: Colors.white)), backgroundColor: Colors.green));
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur: $e'), backgroundColor: Colors.red));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPharmacien = ref.read(authProvider.notifier).isPharmacien;
    final pharmacieAsync = ref.watch(currentPharmacieProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paramètres',style:TextStyle(color:Colors.white, fontWeight:FontWeight.bold)),
        backgroundColor: Colors.green,
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              if (isPharmacien) ...[
                const Text('Informations de la Pharmacie', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
              const Divider(),
              const SizedBox(height: 16),
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: pharmacieAsync.when(
                    data: (ph) {
                      if (ph == null) return const Text('Chargement...');
                      return Column(
                        children: [
                          ListTile(
                            leading: ph.logoUrl != null && ph.logoUrl!.isNotEmpty 
                                ? Image.network(ph.logoUrl!, width: 40, height: 40, fit: BoxFit.contain)
                                : const Icon(Icons.image, color: Colors.green, size: 40),
                            title: Text(ph.nom, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                            subtitle: const Text('Modifier le nom ou le logo de la pharmacie'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () => _updatePharmacieNom(ph.id, ph.nom),
                                  tooltip: 'Modifier le nom',
                                ),
                                IconButton(
                                  icon: const Icon(Icons.upload_file, color: Colors.orange),
                                  onPressed: () => _uploadLogo(ph.id),
                                  tooltip: 'Changer le logo',
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (_, __) => const Text('Erreur de chargement de la pharmacie'),
                  ),
                ),
              ),
              const SizedBox(height: 32),
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
              ),
              ],
              const SizedBox(height: 32),
              const Text('Session', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
              const Divider(),
              const SizedBox(height: 16),
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red, size: 40),
                    title: const Text('Se déconnecter', style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text('Fermer votre session actuelle.'),
                    trailing: ElevatedButton(
                      onPressed: _confirmerDeconnexion,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
                      child: const Text('Se déconnecter'),
                    ),
                  ),
                ),
              )
            ],
          ),
    );
  }
}
