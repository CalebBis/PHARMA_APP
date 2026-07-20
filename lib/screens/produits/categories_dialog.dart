import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../../database/database.dart';
import '../../providers/database_provider.dart';
import '../../providers/categories_provider.dart';
import '../../utils/text_formatters.dart';

class CategoriesDialog extends ConsumerStatefulWidget {
  const CategoriesDialog({super.key});

  @override
  ConsumerState<CategoriesDialog> createState() => _CategoriesDialogState();
}

class _CategoriesDialogState extends ConsumerState<CategoriesDialog> {
  final _nomController = TextEditingController();

  void _ajouter() async {
    if (_nomController.text.trim().isEmpty) return;
    
    final repo = ref.read(categoriesRepositoryProvider);
    await repo.ajouterCategorie(CategoriesCompanion(
      nom: drift.Value(toTitleCase(_nomController.text.trim())),
    ));
    _nomController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return AlertDialog(
      title: const Text('Gestion des Catégories'),
      content: SizedBox(
        width: 400,
        height: 400,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nomController,
                    decoration: const InputDecoration(
                      labelText: 'Nouvelle catégorie',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    inputFormatters: [TitleCaseTextInputFormatter()],
                    onSubmitted: (_) => _ajouter(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _ajouter,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Ajouter'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            Expanded(
              child: categoriesAsync.when(
                data: (categories) {
                  if (categories.isEmpty) {
                    return const Center(child: Text('Aucune catégorie.'));
                  }
                  return ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final cat = categories[index];
                      return ListTile(
                        title: Text(cat.nom),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            final repo = ref.read(categoriesRepositoryProvider);
                            await repo.supprimerCategorie(cat);
                          },
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, st) => Center(child: Text('Erreur: $e')),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Fermer'),
        ),
      ],
    );
  }
}
