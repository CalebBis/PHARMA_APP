# Architecture — Authentification & Synchronisation Cloud (Pharma App)

> ⚠️ Je n'ai pas eu accès au code réel du projet (seulement des captures d'écran et le `pubspec.yaml`). Les noms de tables/champs ci-dessous sont basés sur le planning initial — Gemini/Antigravity doit les adapter au schéma Drift réellement présent dans le projet, en lisant `AGENTS.md` et le code existant avant de commencer.

---

## 1. Décision d'architecture : Supabase

**Choix retenu : Supabase** (Postgres + Auth + RLS), plutôt que Firebase, Appwrite ou un backend custom.

| Critère | Supabase | Firebase | Appwrite | Backend custom |
|---|---|---|---|---|
| Type de base | Postgres (relationnel) | Firestore (NoSQL) | MariaDB/autre | Au choix |
| Compatibilité avec le schéma Drift/SQLite actuel | ✅ Directe (SQL ↔ SQL) | ⚠️ Nécessite de repenser le modèle | ✅ Correcte | ✅ Total contrôle |
| Auth intégrée | ✅ | ✅ | ✅ | ❌ à construire |
| Isolation des données par utilisateur | ✅ Row Level Security au niveau DB | Règles Firestore (plus verbeux) | Permissions par collection | À coder soi-même |
| Effort de développement | Faible | Moyen | Moyen | Élevé |
| Coût pour un petit projet | Gratuit jusqu'à un bon seuil | Gratuit jusqu'à un bon seuil | Gratuit (self-host ou cloud) | Hébergement à ta charge |

**Package Flutter à ajouter :** `supabase_flutter`

---

## 2. Modifications du schéma local (Drift)

Deux changements structurels importants à faire sur **toutes les tables synchronisées** (Produits, Categories, Ventes, VenteDetails, Factures) :

### 2.1 Passer des ID auto-incrémentés aux UUID

**Pourquoi :** si deux machines créent chacune un produit hors-ligne avec l'ID auto-incrémenté `12`, il y a collision au moment de la synchronisation. Un UUID généré côté client évite ce problème.

```dart
// Avant
class Produits extends Table {
  IntColumn get id => integer().autoIncrement()();
  ...
}

// Après
class Produits extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  ...
}
```

Package à ajouter : `uuid`

### 2.2 Ajouter les colonnes de synchronisation

À ajouter sur chaque table concernée :

```dart
class Produits extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get userId => text()();                       // propriétaire (id Supabase Auth)
  DateTimeColumn get updatedAt => dateTime()
      .withDefault(currentDateAndTime)();                  // pour la résolution de conflits
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))(); // suppression douce
  // ... reste des colonnes existantes (nom, prix_achat, prix_vente, etc.)
}
```

**Pourquoi `isDeleted` plutôt qu'une vraie suppression :** une suppression locale doit être propagée au cloud lors de la prochaine synchro. Si tu supprimes la ligne localement avant d'avoir synchronisé, tu perds l'information qu'il faut aussi la supprimer côté cloud. On marque donc `isDeleted = true`, on synchronise, puis on nettoie.

### 2.3 Table `Utilisateurs` locale

Elle change de rôle : elle ne stocke plus le mot de passe (géré par Supabase Auth), mais sert de **cache local** de la session :

```dart
class UtilisateursLocal extends Table {
  TextColumn get id => text()();          // id Supabase Auth (UUID)
  TextColumn get email => text()();
  TextColumn get nom => text()();
  TextColumn get role => text()();         // 'pharmacien' ou 'vendeuse'
  DateTimeColumn get derniereConnexion => dateTime().nullable()();
}
```

---

## 3. Schéma cloud (Supabase / Postgres)

Exemple pour la table `produits` (à dupliquer pour `categories`, `ventes`, `vente_details`, `factures`) :

```sql
create table produits (
  id uuid primary key,
  user_id uuid references auth.users(id) not null,
  nom text not null,
  categorie_id uuid,
  prix_achat numeric not null,
  prix_vente numeric not null,
  quantite_stock integer not null,
  seuil_alerte integer not null,
  date_peremption date,
  updated_at timestamptz not null default now(),
  is_deleted boolean not null default false
);

-- Row Level Security : chaque utilisateur ne voit/modifie que ses propres lignes
alter table produits enable row level security;

create policy "Utilisateurs voient leurs propres produits"
  on produits for select
  using (auth.uid() = user_id);

create policy "Utilisateurs modifient leurs propres produits"
  on produits for insert with check (auth.uid() = user_id);

create policy "Utilisateurs mettent à jour leurs propres produits"
  on produits for update using (auth.uid() = user_id);
```

**Table `utilisateurs_profil`** (complément à `auth.users`, pour stocker le rôle) :

```sql
create table utilisateurs_profil (
  id uuid primary key references auth.users(id),
  nom text not null,
  role text not null check (role in ('pharmacien', 'vendeuse')),
  pharmacie_id uuid  -- utile si plusieurs vendeuses partagent les données d'un même pharmacien, voir section 6
);
```

---

## 4. Authentification

```dart
// Initialisation (main.dart)
await Supabase.initialize(
  url: 'https://xxxx.supabase.co',
  anonKey: 'xxxx',
);

final supabase = Supabase.instance.client;

// Inscription
Future<void> register(String email, String password, String nom, String role) async {
  final res = await supabase.auth.signUp(email: email, password: password);
  if (res.user != null) {
    await supabase.from('utilisateurs_profil').insert({
      'id': res.user!.id,
      'nom': nom,
      'role': role,
    });
  }
}

// Connexion
Future<void> login(String email, String password) async {
  final res = await supabase.auth.signInWithPassword(email: email, password: password);
  // Après connexion réussie : déclencher la synchronisation initiale (section 5)
}

// Déconnexion
Future<void> logout() async {
  await syncBeforeLogout(); // pousser les changements en attente avant de couper
  await supabase.auth.signOut();
}
```

---

## 5. Logique de synchronisation (offline-first)

### 5.1 Déclencheurs de synchronisation

1. **À la connexion** : pull complet (récupérer toutes les données de l'utilisateur depuis le cloud vers le local)
2. **Périodiquement** (ex. toutes les 5 minutes) si une connexion internet est détectée (`connectivity_plus`)
3. **À la déconnexion** : push final des changements en attente avant de fermer la session
4. **Optionnel** : bouton "Synchroniser maintenant" manuel dans Paramètres

### 5.2 Principe général (par table synchronisée)

```dart
Future<void> syncTable(String tableName) async {
  // 1. PUSH — envoyer les changements locaux en attente
  final pending = await localDb.getPendingChanges(tableName); // isSynced == false
  for (final row in pending) {
    await supabase.from(tableName).upsert(row.toCloudMap());
    await localDb.markAsSynced(row.id);
  }

  // 2. PULL — récupérer les changements distants plus récents que la dernière synchro
  final lastSync = await localDb.getLastSyncTimestamp(tableName);
  final remoteChanges = await supabase
      .from(tableName)
      .select()
      .eq('user_id', currentUserId)
      .gt('updated_at', lastSync.toIso8601String());

  for (final remoteRow in remoteChanges) {
    final localRow = await localDb.getById(tableName, remoteRow['id']);
    if (localRow == null || remoteRow['updated_at'].isAfter(localRow.updatedAt)) {
      // Résolution de conflit : la version la plus récente gagne
      await localDb.upsertFromCloud(tableName, remoteRow);
    }
  }

  await localDb.setLastSyncTimestamp(tableName, DateTime.now());
}
```

### 5.3 Résolution de conflits — Last-Write-Wins

- Chaque ligne a un `updated_at`.
- Si une ligne existe des deux côtés avec des valeurs différentes, **celle avec le `updated_at` le plus récent l'emporte**.
- Limite connue de cette approche : si deux utilisateurs modifient la même ligne hors-ligne en même temps, une des deux modifications sera silencieusement écrasée. Pour un usage mono-pharmacien avec une vendeuse, le risque est faible (peu de modifications concurrentes sur la même ligne), donc acceptable pour une v1. Une évolution possible plus tard : journaliser les conflits pour review manuelle.

### 5.4 Détection de connectivité

```dart
// Package: connectivity_plus
final connectivity = Connectivity();
connectivity.onConnectivityChanged.listen((status) {
  if (status != ConnectivityResult.none) {
    syncAllTables(); // relance la synchro dès que la connexion revient
  }
});
```

---

## 6. Partage des données entre pharmacien et vendeuse — `pharmacie_id`

Avec le modèle initial (`user_id` = propriétaire des données), **chaque compte aurait ses propres données isolées** — ce qui ne convient pas ici : le pharmacien et sa vendeuse doivent voir **les mêmes** produits/ventes/stock.

**Solution retenue — simple, un seul champ ajouté :** `pharmacie_id`, sans complexité supplémentaire (pas besoin d'un identifiant séparé pour la vendeuse, pas de table d'invitation).

- Une table `pharmacies` (id, nom du pharmacien propriétaire)
- Chaque utilisateur (`utilisateurs_profil`) a deux champs : `pharmacie_id` (à quelle pharmacie il appartient) et `role` (`pharmacien` ou `vendeuse`)
- Toutes les tables de données (produits, ventes, factures...) sont liées à `pharmacie_id`, pas à `user_id`
- Les policies RLS vérifient que le `pharmacie_id` de l'utilisateur connecté correspond au `pharmacie_id` de la ligne consultée

**Fonctionnement concret :**
1. Le pharmacien crée son compte → une ligne `pharmacies` est créée → son profil reçoit ce `pharmacie_id` et le rôle `pharmacien`.
2. Pour ajouter une vendeuse, le pharmacien crée un second compte (email/mot de passe) et lui assigne **le même `pharmacie_id`**, avec le rôle `vendeuse`.
3. Résultat : les deux comptes interrogent les mêmes données (`pharmacie_id` identique), mais avec des droits différents selon `role` (tableau de permissions déjà défini dans AGENTS.md).

```sql
create policy "Accès aux données de sa pharmacie"
  on produits for select
  using (
    pharmacie_id in (
      select pharmacie_id from utilisateurs_profil where id = auth.uid()
    )
  );
```

`pharmacie_id` = qui voit quoi. `role` = qui a le droit de faire quoi. Les deux champs sont indépendants et suffisent, sans ajouter d'autre identifiant.

---

## 7. Plan de migration (ne pas casser l'existant)

1. Ajouter Supabase au projet, créer le projet Supabase, définir le schéma cloud (sections 2-3)
2. Implémenter l'auth (login/register) en remplaçant l'authentification actuelle basée sur la table locale, **sans casser l'écran de login existant visuellement**
3. Migrer le schéma local : ajouter les colonnes `user_id`, `updated_at`, `isSynced`, `isDeleted`, passer aux UUID — écrire une migration Drift propre (pas de perte des données de test existantes si possible)
4. Implémenter le service de synchronisation (section 5), déclenché login/logout/périodique
5. Adapter tous les repositories existants pour qu'ils filtrent par `pharmacie_id` et marquent `isSynced = false` + `updated_at = now()` à chaque écriture locale
6. Tester le scénario complet : créer un produit hors-ligne → repasser en ligne → vérifier la synchro → se connecter depuis une autre "machine" (ou un autre profil de test) → vérifier que les données apparaissent

---

## Prompt à donner à Gemini/Antigravity

```
Lis d'abord AGENTS.md à la racine du projet pour comprendre l'état actuel et les règles à respecter (ne pas casser l'existant, ne pas changer le thème visuel).

Implémente la synchronisation cloud décrite dans ce document, dans l'ordre du plan de migration (section 7). Avant de commencer, analyse le schéma Drift réellement présent dans le projet et adapte les noms de tables/colonnes proposés ici à la structure existante plutôt que de les imposer tels quels.

Points non négociables :
- L'application doit continuer à fonctionner hors-ligne (la base locale reste la source de vérité rapide)
- Ne change pas le thème visuel de l'application
- Respecte le tableau de permissions pharmacien/vendeuse déjà défini dans AGENTS.md
- Implémente le partage de données via "pharmacie_id" uniquement (section 6) plutôt qu'une isolation stricte par utilisateur — un seul champ pharmacie_id + un champ role, pas de mécanisme d'invitation ou d'identifiant supplémentaire

Une fois terminé, mets à jour AGENTS.md (état actuel + journal des modifications) et fais-moi un résumé de ce qui a été fait, y compris les identifiants/clés Supabase que je dois configurer moi-même.
```
