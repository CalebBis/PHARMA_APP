import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import 'package:intl/intl.dart';
import '../../database/database.dart';
import '../../providers/database_provider.dart';
import '../../providers/categories_provider.dart';
import '../../utils/text_formatters.dart';
import 'categories_dialog.dart';

class ProduitFormDialog extends ConsumerStatefulWidget {
  final Produit? produitToEdit;
  
  const ProduitFormDialog({super.key, this.produitToEdit});

  @override
  ConsumerState<ProduitFormDialog> createState() => _ProduitFormDialogState();
}

class _ProduitFormDialogState extends ConsumerState<ProduitFormDialog> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _nomController;
  late TextEditingController _prixAchatController;
  late TextEditingController _prixVenteController;
  late TextEditingController _stockController;
  late TextEditingController _seuilController;
  
  String? _selectedCategoryId;
  DateTime? _selectedDatePeremption;

  @override
  void initState() {
    super.initState();
    final p = widget.produitToEdit;
    _nomController = TextEditingController(text: p?.nom ?? '');
    _prixAchatController = TextEditingController(text: p != null ? p.prixAchat.toString() : '');
    _prixVenteController = TextEditingController(text: p != null ? p.prixVente.toString() : '');
    _stockController = TextEditingController(text: p != null ? p.quantiteStock.toString() : '');
    _seuilController = TextEditingController(text: p != null ? p.seuilAlerte.toString() : '5');
    
    _selectedCategoryId = p?.categorieId;
    _selectedDatePeremption = p?.datePeremption;
  }

  void _sauvegarder() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Veuillez sélectionner une catégorie.')));
      return;
    }

    final repo = ref.read(produitsRepositoryProvider);
    
    final pNom = toTitleCase(_nomController.text.trim());
    final pAchat = double.parse(_prixAchatController.text);
    final pVente = double.parse(_prixVenteController.text);
    final pStock = int.parse(_stockController.text);
    final pSeuil = int.parse(_seuilController.text);

    if (widget.produitToEdit == null) {
      // Add
      await repo.ajouterProduit(ProduitsCompanion(
        nom: drift.Value(pNom),
        categorieId: drift.Value(_selectedCategoryId),
        prixAchat: drift.Value(pAchat),
        prixVente: drift.Value(pVente),
        quantiteStock: drift.Value(pStock),
        seuilAlerte: drift.Value(pSeuil),
        datePeremption: drift.Value(_selectedDatePeremption),
      ));
    } else {
      // Update
      await repo.modifierProduit(widget.produitToEdit!.copyWith(
        nom: pNom,
        categorieId: drift.Value(_selectedCategoryId),
        prixAchat: pAchat,
        prixVente: pVente,
        quantiteStock: pStock,
        seuilAlerte: pSeuil,
        datePeremption: drift.Value(_selectedDatePeremption),
      ));
    }

    if (mounted) Navigator.of(context).pop(true);
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDatePeremption ?? DateTime.now().add(const Duration(days: 365)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() {
        _selectedDatePeremption = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.produitToEdit != null;
    final categoriesAsync = ref.watch(categoriesProvider);

    return AlertDialog(
      title: Text(isEditing ? 'Modifier Produit' : 'Ajouter Produit'),
      content: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nomController,
                  decoration: const InputDecoration(labelText: 'Nom du produit'),
                  inputFormatters: [TitleCaseTextInputFormatter()],
                  validator: (val) => (val == null || val.isEmpty) ? 'Requis' : null,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: categoriesAsync.when(
                        data: (categories) {
                          return DropdownButtonFormField<String>(
                            isExpanded: true,
                            decoration: const InputDecoration(
                              labelText: 'Catégorie *',
                              border: OutlineInputBorder(),
                            ),
                            value: _selectedCategoryId,
                            items: categories.map((c) => DropdownMenuItem(value: c.id, child: Text(c.nom, overflow: TextOverflow.ellipsis))).toList(),
                            onChanged: (val) {
                              setState(() {
                                _selectedCategoryId = val;
                              });
                            },
                            validator: (val) => val == null ? 'Veuillez choisir une catégorie' : null,
                          );
                        },
                        loading: () => const CircularProgressIndicator(),
                        error: (e, st) => Text('Erreur: $e'),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle, color: Colors.green),
                      tooltip: 'Nouvelle catégorie',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => const CategoriesDialog(),
                        );
                      },
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _prixAchatController,
                        decoration: const InputDecoration(labelText: 'Prix d\'achat'),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        validator: (val) => (val == null || double.tryParse(val) == null) ? 'Invalide' : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _prixVenteController,
                        decoration: const InputDecoration(labelText: 'Prix de vente'),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        validator: (val) => (val == null || double.tryParse(val) == null) ? 'Invalide' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _stockController,
                        decoration: const InputDecoration(labelText: 'Quantité en stock'),
                        keyboardType: TextInputType.number,
                        validator: (val) => (val == null || int.tryParse(val) == null) ? 'Invalide' : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _seuilController,
                        decoration: const InputDecoration(labelText: 'Seuil d\'alerte'),
                        keyboardType: TextInputType.number,
                        validator: (val) => (val == null || int.tryParse(val) == null) ? 'Invalide' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDatePeremption == null
                            ? 'Aucune date de péremption'
                            : 'Péremption: ${DateFormat('dd/MM/yyyy').format(_selectedDatePeremption!)}',
                      ),
                    ),
                    TextButton.icon(
                      onPressed: _pickDate,
                      icon: const Icon(Icons.calendar_today),
                      label: const Text('Choisir une date'),
                    ),
                    if (_selectedDatePeremption != null)
                      IconButton(
                        icon: const Icon(Icons.clear, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            _selectedDatePeremption = null;
                          });
                        },
                      )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: _sauvegarder,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
          child: Text(isEditing ? 'Mettre à jour' : 'Ajouter'),
        ),
      ],
    );
  }
}
