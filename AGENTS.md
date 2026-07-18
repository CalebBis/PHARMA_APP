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

- ✅ Écran de connexion (login) — Connecté à la table Utilisateurs via AuthProvider
- ✅ CRUD Produits — Masqué pour les vendeuses (vérification de rôle)
- ✅ Point de Vente — fonctionnel
- ✅ Historique des Factures — Impression et téléchargement PDF
- ✅ Dashboard — Statistiques, graphique des ventes 7j, liste des ventes
- ✅ Rapport — Période de temps, bénéfices, alertes stock/péremption, export PDF
- ✅ Paramètres — Backup / Restauration, Gestion simple de compte vendeuse
- ✅ Permissions par rôle — UI et repository sécurisés

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
