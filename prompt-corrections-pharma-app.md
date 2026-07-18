# Prompt de correction — Pharma App (Flutter + Drift)

## Instruction de départ à copier-coller dans Gemini/Antigravity

```
Tu vas continuer le développement du projet Flutter "pharma_app" existant (Flutter + Drift/SQLite + Riverpod). Le projet a déjà une base fonctionnelle : écran de connexion, gestion des produits (CRUD), point de vente, et historique des factures.

RÈGLE ABSOLUE — NE PAS Y TOUCHER :
Ne modifie EN AUCUN CAS le thème actuel de l'application (couleurs vert/blanc, style des boutons, des cartes, de la sidebar). Le design actuel doit rester exactement identique. Toutes les nouvelles fonctionnalités doivent réutiliser le même thème (couleurs, arrondis, typographie) déjà en place dans le projet, pour rester cohérentes visuellement.

Voici la liste des corrections et fonctionnalités manquantes à implémenter, dans l'ordre de priorité ci-dessous. Traite-les une par une, teste chaque étape avant de passer à la suivante, et n'invente pas de nouvel écran ou de nouvelle navigation qui ne serait pas listée ici.
```

---

## Priorité 1 — Dashboard (actuellement vide)

L'écran Dashboard n'affiche qu'un message de bienvenue. Il faut implémenter :

1. **4 cartes de statistiques** en haut :
   - Ventes du jour (somme des montants des ventes de la journée en cours)
   - Nombre de transactions du jour
   - Produit le plus vendu (sur les 7 derniers jours)
   - Stock bas (nombre de produits sous leur seuil d'alerte, avec lien/clic vers la liste filtrée dans l'onglet Produits)
2. **Graphique des ventes des 7 derniers jours** (bar chart ou line chart) :
   - Ajouter la dépendance `fl_chart` dans `pubspec.yaml` (elle n'est pas présente actuellement)
   - Une requête Drift qui agrège le total des ventes par jour sur les 7 derniers jours
3. **Historique des ventes récentes** (les 5-10 dernières ventes, avec heure et montant)

## Priorité 2 — Onglet Rapport (actuellement "en construction")

Cet onglet est vide, il faut le construire entièrement :

1. **Rapport de ventes par période** : sélecteur de période (jour/semaine/mois/personnalisé), affichage du total des ventes, nombre de transactions, panier moyen
2. **Rapport de stock** : liste des produits en rupture ou proches du seuil d'alerte, liste des produits proches de la péremption
3. **Rapport de bénéfices** : (prix de vente - prix d'achat) × quantité vendue, sur la période sélectionnée
4. Export PDF ou CSV du rapport (réutiliser le package `pdf`/`printing` déjà présent dans le projet)

## Priorité 3 — Facturation incomplète

Actuellement, l'historique des factures n'a qu'une icône imprimante. Il manque :

1. Un bouton/icône pour **visualiser la facture avant impression** (aperçu PDF), pas seulement l'imprimer directement
2. Vérifier que le PDF généré contient bien : nom de la pharmacie, numéro de facture, date, détail des produits vendus (nom, quantité, prix unitaire, sous-total), total, mode de paiement
3. Un bouton pour **télécharger/enregistrer le PDF** sur le disque, en plus de l'impression directe

## Priorité 4 — Vérifier et finaliser les permissions par rôle

D'après les captures, impossible de vérifier si c'est fait. Confirme que :

1. Le login vérifie bien l'identifiant/mot de passe **contre la table Utilisateurs en base**, avec un `role` associé (pharmacien / vendeuse) — pas de valeurs codées en dur
2. Une fois connectée, une **vendeuse** :
   - a accès à Dashboard, Ventes, Factures, Rapport normalement
   - dans l'onglet Produits, **ne voit PAS** les boutons "Nouveau Produit", modifier (crayon) et supprimer (poubelle) — masqués complètement, pas juste désactivés
   - la vérification du rôle doit aussi exister dans la couche repository, pas uniquement dans l'affichage de l'UI
3. Ajouter dans la sidebar (en bas, comme prévu) le **nom de l'utilisateur connecté**, son rôle, et un bouton de **déconnexion**

## Priorité 5 — Sauvegarde / restauration de la base de données (absent)

Aucune trace de cette fonctionnalité dans les captures. À ajouter :

1. Créer un onglet ou une section **"Paramètres"**, visible uniquement par le rôle pharmacien (accessible depuis la sidebar)
2. Bouton **"Sauvegarder la base de données"** : copie le fichier SQLite vers un emplacement choisi par l'utilisateur, avec un nom horodaté (ex. `pharmacie_backup_2026-07-18.sqlite`)
3. Bouton **"Restaurer une sauvegarde"** : permet de sélectionner un fichier `.sqlite` existant et de l'importer pour remplacer la base actuelle (avec confirmation avant écrasement)
4. Dans cette même section "Paramètres", ajouter la **gestion des utilisateurs** (créer/désactiver un compte vendeuse), réservée au pharmacien

## Priorité 6 — Points mineurs à vérifier

1. Le prix est actuellement affiché en **€** dans Ventes/Produits/Factures — confirme si c'est la devise voulue ou si elle doit être changée partout de façon cohérente
2. Vérifier que le stock d'un produit se décrémente correctement après validation d'une vente, et que ça se reflète immédiatement dans l'onglet Produits sans besoin de relancer l'app
3. Vérifier que si le même produit est ajouté deux fois au panier, la quantité s'additionne sur une seule ligne plutôt que de créer deux lignes séparées

---

### Rappel à donner à l'IA à la fin du prompt

```
Une fois toutes ces corrections faites, fais-moi un résumé de ce qui a été implémenté, de ce qui reste à faire, et de tout écran ou fonctionnalité que tu n'as pas pu terminer et pourquoi.
```
