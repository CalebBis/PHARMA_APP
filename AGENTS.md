# AGENTS.md — Règles du projet Pharma App

> **⚠️ Ce fichier doit être lu intégralement par toute IA avant de modifier le code.**
> **Il doit être mis à jour par l'IA après chaque intervention**, en ajoutant une entrée dans le journal en bas de ce fichier (section "Journal des modifications"). Ne jamais supprimer ou réécrire l'historique existant du journal — uniquement y ajouter une nouvelle entrée à la fin.

---

## 1. Résumé du projet

**Nom :** pharma_app
**Objectif :** Logiciel desktop de gestion de pharmacie (produits, ventes, factures, rapports, dashboard).

**Stack technique :**
- Flutter (Desktop)
- Drift (SQLite) pour la base de données locale
- Riverpod (`flutter_riverpod`) pour la gestion d'état
- `pdf` + `printing` pour la génération de factures/rapports PDF
- `fl_chart` pour les graphiques du dashboard

**Utilisateurs cibles :** un pharmacien (accès complet) et une vendeuse (accès limité, voir section 4).

---

## 2. Architecture du projet

```
lib/
├── main.dart
├── database/
│   ├── database.dart          # Config Drift + tables
│   ├── tables/                # produits, ventes, vente_details, factures, categories, utilisateurs
├── models/
├── repositories/               # Couche d'accès aux données (CRUD)
├── providers/                  # Providers Riverpod (état + logique métier)
├── screens/
│   ├── login/
│   ├── dashboard/
│   ├── produits/
│   ├── ventes/
│   ├── factures/
│   ├── rapports/
│   └── parametres/
├── widgets/                    # Composants réutilisables
└── utils/
```

**Règle de structure :** toute nouvelle fonctionnalité doit respecter cette organisation (repository pour l'accès DB, provider pour la logique/état, screen pour l'UI). Ne pas mélanger requêtes DB directement dans les widgets.

---

## 3. Design — RÈGLE STRICTE

**Le thème actuel (couleurs vert/blanc, style des boutons, cartes, sidebar) est validé et ne doit JAMAIS être modifié**, sauf demande explicite de l'utilisateur. Toute nouvelle fonctionnalité ou tout nouvel écran doit :
- Réutiliser les mêmes couleurs déjà définies dans le thème de l'app
- Réutiliser les mêmes composants/styles déjà existants (boutons, cartes, tableaux) plutôt qu'en recréer de nouveaux
- Garder le fond blanc par défaut

---

## 4. Règles de permissions par rôle

| Fonctionnalité | Pharmacien | Vendeuse |
|---|---|---|
| Dashboard, Ventes, Factures, Rapport | ✅ | ✅ |
| Produits — consulter | ✅ | ✅ |
| Produits — ajouter/modifier/supprimer | ✅ | ❌ (boutons masqués, pas seulement désactivés) |
| Paramètres (backup, gestion utilisateurs) | ✅ | ❌ |

La vérification du rôle doit exister **à la fois** dans l'UI (masquer les boutons) et dans la couche repository/logique métier (empêcher l'action même si elle est déclenchée). Ne jamais affaiblir cette double vérification.

---

## 5. État actuel du projet (dernière mise à jour connue)

> Cette section doit être tenue à jour à chaque modification. Elle résume ce qui est fonctionnel, pas les détails (le détail va dans le journal plus bas).

- ✅ Écran de connexion (login) — Connecté à **Supabase Auth** (email/mot de passe), profil récupéré depuis `utilisateurs_profil`
- ✅ CRUD Produits — UI moderne (cartes), masqué pour les vendeuses
- ✅ Point de Vente — Interface améliorée, gestion de panier, validation
- ✅ Dashboard — Statistiques avec tendances, raccourci vente, graphiques interactifs
- ✅ Rapport & Factures — Onglet fusionné avec filtres de date, statistiques avancées, alertes stocks/péremptions, historique des factures et export PDF
- ✅ Paramètres — Backup / Restauration, Gestion de compte vendeuse (via Supabase SignUp)
- ✅ Permissions par rôle — UI et repository sécurisés
- ✅ Devise & Formatage — Utilisation du Franc Congolais (FC) et formatage automatique (Title Case)
- ✅ **Synchronisation Cloud (Supabase)** — Schéma local migré vers UUID, colonnes sync (`pharmacieId`, `updatedAt`, `isSynced`, `isDeleted`), SyncService Push/Pull offline-first, déclenchement auto à la connexion/déconnexion et au retour d'internet

---

## 6. Règles avant toute modification

1. **Lire ce fichier en entier avant de toucher au code.**
2. Ne pas casser une fonctionnalité existante listée comme "✅" en section 5 pour en implémenter une nouvelle.
3. Ne pas changer le thème (voir section 3).
4. Ne pas renommer ou déplacer des fichiers/dossiers existants sans raison technique justifiée.
5. Si une fonctionnalité demandée entre en conflit avec une règle de ce fichier, le signaler à l'utilisateur plutôt que de trancher seul.
6. Tester (au minimum manuellement) chaque fonctionnalité modifiée avant de la considérer terminée.

---

## 7. Règle après toute modification

Avant de terminer ta session de travail, tu dois :
1. Mettre à jour la section **"5. État actuel du projet"** ci-dessus si l'état d'une fonctionnalité a changé.
2. Ajouter une nouvelle entrée en bas du **Journal des modifications** (section 8), en suivant le format donné. Ne jamais supprimer les entrées précédentes.

---

## 8. Journal des modifications

> Format à respecter pour chaque nouvelle entrée :
> ```
> ### [DATE] — [Nom de l'agent/IA si connu]
> **Ce qui a été fait :**
> - ...
> **Fichiers créés/modifiés :**
> - ...
> **Points d'attention pour la suite :**
> - ...
> ```

### [Aucune entrée pour l'instant — la première IA qui modifie ce projet doit ajouter la sienne ici]

### 2026-07-18 — Antigravity (Claude)
**Ce qui a été fait :**
- Implémentation du Dashboard (fl_chart, stats, ventes récentes)
- Création de l'onglet Rapport avec export PDF
- Ajout du téléchargement direct de PDF pour les factures
- Mise en place d'un AuthProvider et sécurité des rôles (UI et Repository)
- Création de l'écran Paramètres avec Backup/Restore SQLite et création de compte Vendeuse
**Fichiers créés/modifiés :**
- `pubspec.yaml`
- `dashboard_screen.dart`, `dashboard_provider.dart`
- `rapports_screen.dart`
- `parametres_screen.dart`
- `ventes_repository.dart`, `produits_repository.dart`
- `main_layout.dart`, `login_screen.dart`, `produits_screen.dart`
- `auth_provider.dart`, `database_provider.dart`
- `pdf_service.dart`
**Points d'attention pour la suite :**
- Le Backup/Restore écrase le fichier `.sqlite` et nécessite un redémarrage manuel ou auto (Desktop exit `exit(0)`) pour recharger Drift proprement.
- Assurez-vous d'avoir au moins un utilisateur 'pharmacien' en base, sinon le compte admin local de secours est utilisé.

### 2026-07-18 — Antigravity (Claude) - Round 2
**Ce qui a été fait :**
- Fusion de l'onglet Factures dans l'onglet Rapports.
- Refonte de l'onglet Rapports avec des filtres par période de date, ajout du rapport de bénéfices, et liste des factures.
- Refonte visuelle de l'onglet Produits et Ventes (cartes interactives, badges de statut).
- Amélioration du Dashboard (tendances par rapport à la veille, raccourci "Nouvelle Vente", tooltip du graphique).
- Changement de devise partout de € vers FC (Franc Congolais) via `CurrencyFormatter`.
- Mise en forme automatique du texte saisi dans les formulaires (Title Case) au niveau de l'UI et avant sauvegarde (`toTitleCase`).
**Fichiers créés/modifiés :**
- `currency_formatter.dart`, `text_formatters.dart`
- `main_layout.dart`
- `dashboard_screen.dart`, `dashboard_provider.dart`
- `rapports_screen.dart`, `produits_screen.dart`, `ventes_screen.dart`
- `produit_form_dialog.dart`, `categories_dialog.dart`, `parametres_screen.dart`
- `pdf_service.dart`, `ventes_repository.dart`, `factures_repository.dart`
**Points d'attention pour la suite :**
- L'onglet `factures_screen.dart` original a été conservé ou est obsolète, il pourrait être supprimé pour nettoyer le projet.
- La gestion des dates (hier vs aujourd'hui) dans le Dashboard se base sur l'heure locale de l'appareil.

### 2026-07-19 — Antigravity (Gemini / Claude) - Round 3 : Synchronisation Cloud Supabase
**Ce qui a été fait :**
- Intégration de Supabase Flutter (`supabase_flutter`, `uuid`, `connectivity_plus`)
- Migration du schéma Drift : toutes les tables (`produits`, `categories`, `ventes`, `vente_details`, `factures`) passées aux UUID avec colonnes de sync (`pharmacieId`, `updatedAt`, `isSynced`, `isDeleted`)
- Table `utilisateurs` transformée en cache de session locale (plus de mot de passe stocké localement)
- `schemaVersion` passé de 1 à 2, migration onUpgrade écrasant la base de test
- Authentification remplacée par Supabase Auth dans `AuthService` + profil récupéré depuis `utilisateurs_profil` (inclut `pharmacieId` et `role`)
- `AuthProvider` refactorisé pour utiliser `AuthService`, déclenche `SyncService` à la connexion/déconnexion
- `SyncService` créé : Push/Pull offline-first pour les 5 tables, résolution de conflit Last-Write-Wins, écoute `connectivity_plus`
- Tous les repositories (`produits`, `categories`, `ventes`, `factures`) filtrés par `pharmacieId` et `isDeleted = false`
- Création de vendeuse via `parametres_screen.dart` redirigée vers Supabase `signUp` + insertion dans `utilisateurs_profil`
- Supabase initialisé dans `main.dart`
- `factureId` changé de `int` à `String` dans `PdfService`
**Fichiers créés/modifiés :**
- `pubspec.yaml` (+ supabase_flutter, uuid, connectivity_plus)
- `lib/database/database.dart` (schemaVersion 2, migration, import uuid)
- `lib/database/tables/*.dart` (toutes les 6 tables migrées)
- `lib/database/database.g.dart` (régénéré par build_runner)
- `lib/main.dart` (init Supabase)
- `lib/services/auth_service.dart` (NOUVEAU)
- `lib/services/sync_service.dart` (NOUVEAU)
- `lib/providers/auth_provider.dart` (refactorisé)
- `lib/providers/database_provider.dart` (+ facturesRepositoryProvider, syncServiceProvider, pharmacieId)
- `lib/providers/factures_provider.dart` (nettoyé)
- `lib/providers/produits_provider.dart` (categoryId: int → String, stream via repo)
- `lib/repositories/produits_repository.dart`, `categories_repository.dart`, `ventes_repository.dart`, `factures_repository.dart`, `utilisateurs_repository.dart` (tous mis à jour)
- `lib/screens/login_screen.dart` (utilise AuthService)
- `lib/screens/parametres_screen.dart` (vendeuse via Supabase)
- `lib/screens/ventes/ventes_screen.dart` (Vente constructor mis à jour)
- `lib/screens/produits/produit_form_dialog.dart` (categorieId: int → String)
- `lib/screens/produits/produits_screen.dart` (dropdown: int → String)
- `lib/screens/rapports_screen.dart` (import corrigé)
- `lib/services/pdf_service.dart` (factureId: int → String)
**Points d'attention pour la suite :**
- **Clés Supabase à configurer** : URL `https://meedlusaawhnwwioztoa.supabase.co` et la clé dans `lib/main.dart` — déjà renseignées par l'utilisateur.
- **Tables Supabase côté cloud** : l'utilisateur confirme avoir créé les tables et policies RLS dans son projet Supabase. Vérifier que les noms de colonnes correspondent (snake_case: `pharmacie_id`, `updated_at`, `is_synced`, `is_deleted`).
- **Inscription Pharmacien** : il n'y a pas encore d'écran d'inscription pour le pharmacien principal. Pour l'instant, il faut créer le compte manuellement dans l'interface Supabase Auth, puis insérer une ligne dans `utilisateurs_profil` et une dans `pharmacies`.
- La résolution de conflit est Last-Write-Wins (updatedAt) — acceptable pour v1 mono-pharmacien.
- Le backup/restore SQLite local est maintenu, mais après restauration d'une vieille sauvegarde, la synchro peut repousser des données déjà supprimées (comportement attendu en v1).

