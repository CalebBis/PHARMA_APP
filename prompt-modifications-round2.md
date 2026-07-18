# Prompt — Nouvelle série de modifications (Pharma App)

## Instruction de départ à copier-coller dans Gemini/Antigravity

```
Avant toute chose, lis intégralement le fichier AGENTS.md à la racine du projet pour comprendre l'état actuel et les règles à respecter. Une fois les modifications ci-dessous terminées, complète le journal des modifications dans AGENTS.md et mets à jour la section "État actuel du projet" en conséquence.

Voici les modifications à apporter, dans l'ordre. Traite-les une par une et teste chaque étape avant de passer à la suivante.
```

---

## 1. Fusionner l'onglet Factures dans l'onglet Rapports

- Retirer "Factures" de la sidebar comme onglet séparé.
- L'historique des factures (liste actuellement dans l'onglet Factures, avec numéro, date, total, mode de paiement, impression) devient une **section à l'intérieur de l'onglet Rapports**.
- Garde toutes les fonctionnalités déjà présentes (impression, visualisation du PDF).

## 2. Reconstruire l'onglet Rapports avec des filtres par période

L'onglet Rapports doit maintenant contenir :

1. Un **sélecteur de période** en haut : Jour / Semaine / Mois / Année (+ idéalement une option période personnalisée avec deux dates).
2. Selon la période choisie, affichage de :
   - **Historique des factures** de la période sélectionnée (section fusionnée du point 1)
   - **Total des ventes** et **nombre de transactions** sur la période
   - **Rapport de stock** : produits en rupture ou proches du seuil, produits proches de la péremption
   - **Rapport de bénéfices** : (prix vente - prix achat) × quantité vendue, sur la période sélectionnée
3. Un bouton d'export PDF ou CSV du rapport correspondant à la période affichée.

## 3. Refonte visuelle de l'onglet Produits — avec une touche d'originalité

Le tableau actuel est fonctionnel mais très basique. Améliore le design en gardant la palette de couleurs actuelle (vert/blanc) mais en la rendant plus vivante et moderne :
- Tu es libre sur la mise en forme (cartes produits au lieu d'un simple tableau, icônes par catégorie, badges colorés pour le stock bas/péremption proche, etc.)
- Garde toutes les fonctionnalités existantes (recherche, filtres catégorie/stock bas/péremption proche, ajout/modification/suppression, restriction du rôle vendeuse)
- Le formulaire "Ajouter/Modifier Produit" doit rester fonctionnellement identique, mais peut être amélioré visuellement dans le même esprit.

## 4. Refonte visuelle de l'onglet Ventes (Point de Vente) — avec une touche d'originalité

Même principe que pour l'onglet Produits :
- Garde la palette de couleurs actuelle
- Améliore la présentation des produits disponibles à la vente et du panier (mise en page plus travaillée, retours visuels plus clairs lors de l'ajout au panier, etc.)
- Garde toutes les fonctionnalités existantes (recherche produit, gestion des quantités, mode de paiement, validation de vente, vidage du panier, décrémentation du stock)

## 5. Amélioration du Dashboard

Le dashboard de base (cartes stats, graphique 7 jours, historique récent) doit être amélioré :
- Rendre les cartes de statistiques plus visuelles (icônes, mise en valeur des chiffres, éventuellement petites tendances comme "+12% par rapport à hier" si les données le permettent)
- Améliorer le graphique des ventes 7 jours (labels clairs, tooltip au survol si possible avec `fl_chart`)
- Ajouter, si pas déjà fait, un raccourci rapide vers "Nouvelle vente" depuis le dashboard

## 6. Changement de devise — Franc Congolais (FC)

- Remplacer **partout dans l'application** (Produits, Ventes, Factures/Rapports, Dashboard) le symbole **€** par **FC** (Franc Congolais).
- Utiliser un format cohérent, ex. `48 200 FC` (séparateur de milliers avec espace, symbole après le montant).
- Si un formateur de devise centralisé existe déjà (`utils/`), le modifier à un seul endroit plutôt que de chercher/remplacer dans chaque écran.

## 7. Mise en forme automatique du texte saisi dans les formulaires (Title Case)

Dans **tous les champs de texte** de l'application (nom de produit, catégorie, nom d'utilisateur, etc.) :
- Peu importe si l'utilisateur tape en majuscules, minuscules, ou mélange les deux, le texte affiché/enregistré doit automatiquement mettre **la première lettre de chaque mot en majuscule**, le reste en minuscule.
- Exemple : `doliprane 1g` ou `DOLIPRANE 1G` → affiché comme `Doliprane 1g`
- Implémente ça sous forme d'un `TextInputFormatter` réutilisable (ou d'une fonction utilitaire appliquée à la sauvegarde) plutôt que de dupliquer la logique dans chaque formulaire.
- Cette règle s'applique à la saisie ET à l'enregistrement en base, pour que l'affichage soit cohérent partout dans l'application (listes, factures, rapports).

---

### Rappel à donner à l'IA à la fin du prompt

```
Une fois toutes ces modifications faites, mets à jour AGENTS.md (section état actuel + journal des modifications), puis fais-moi un résumé de ce qui a été fait et de ce qui reste à faire.
```
