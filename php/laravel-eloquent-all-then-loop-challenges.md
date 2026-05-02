# Laravel + Eloquent — défis « all() puis boucle »

## Règle pédagogique (obligatoire pour ces défis)

Les apprenants doivent :

1. Charger **toutes** les lignes d’un modèle avec **`Model::all()`** (équivalent acceptable : **`Model::get()`** sans `where` / sans filtres en chaîne).
2. Parcourir le résultat avec une **boucle** (`foreach`).
3. Appliquer **filtres, comptages, regroupements et transformations uniquement en PHP** (conditions `if`, tableaux accumulés, `continue`, etc.).

**Interdit pour ces exercices** (sauf variante « niveau avancé » explicitement séparée) :

- `where`, `orderBy`, `groupBy`, `having`, `withCount`, `withAvg`, jointures, scopes, etc.
- `filter()` / `groupBy()` sur **Query Builder** avant `get()`.

**Autorisé** : après `all()`, utiliser les méthodes de **Collection Laravel** sur le résultat (`collect($users)->filter(...)`) **uniquement si** tu acceptes cette variante — sinon impose du PHP pur sur un tableau (`foreach` + `$result[] = ...`).

Objectif : maîtriser **objets Eloquent**, **tableaux**, **Collections**, et la **logique métier** sans déléguer au SQL.

---

## Propositions de défis (compatibles « all + boucle »)

### 1. Filtrer les actifs

- **Données** : table `users` avec colonne `is_active`.
- **Tâche** : `$users = User::all();` puis construire un tableau des **id + name** pour `is_active === true`.

### 2. Grouper par ville (manuel)

- **Données** : `users` avec `city`.
- **Tâche** : boucler sur `User::all()` et remplir un tableau associatif `['Safi' => [...], 'Rabat' => [...]]` (liste de noms ou d’objets légers).

### 3. Somme ou total manuel

- **Données** : `orders` avec `amount_cents`.
- **Tâche** : `Order::all()`, boucle, calculer **total des montants** + nombre de commandes (sans `sum()` SQL).

### 4. Maximum / minimum en PHP

- **Données** : `products` avec `price`.
- **Tâche** : trouver le produit **le plus cher** en parcourant toutes les lignes (variables `$max`, `$product_id`).

### 5. Doublons (email)

- **Données** : `students` avec `email`.
- **Tâche** : détecter les **emails présents plus d’une fois** (compteur manuel par email dans un tableau associatif).

### 6. Plus de N occurrences (fidélité / RDV)

- **Données** : table `appointments` avec `client_id` (une ligne = un RDV).
- **Tâche** : `Appointment::all()`, compter les RDV **par** `client_id` dans un tableau, retourner les `client_id` avec **strictement plus de X** RDV.

### 7. Jointure « logique » sans SQL (deux `all()`)

- **Données** : `posts` (`user_id`), `users`.
- **Tâche** : `$posts = Post::all();` `$users = User::all();` — construire pour chaque post un tableau `{ title, author_name }` en cherchant l’utilisateur en boucle (double boucle ou index utilisateur par id dans un tableau associatif — recommander l’index pour éviter O(n²)).

### 8. Tri en PHP

- **Données** : `lessons` avec `starts_at`.
- **Tâche** : charger tout, copier dans un tableau, **trier** par date avec `usort()` ou tri à bulles (pédagogique) — ou comparer en boucle pour les débutants.

### 9. Réponse API JSON

- **Tâche** : à partir du tableau construit en boucle, retourner `response()->json([...])` avec la **forme exacte** demandée (contrat de sortie).

### 10. Pagination « fake » (optionnel)

- **Tâche** : après filtrage en mémoire sur `all()`, retourner **la page k** (slice du tableau) — pour comprendre offset/limit sans `paginate()` SQL.

---

## Forme type d’un énoncé (copier-coller)

```text
Contrainte : utiliser uniquement User::all(), puis une boucle foreach.
Interdit : User::where(...), scopes, agrégations SQL.

Entrée : (schéma ou seed décrit)
Sortie JSON attendue : { ... }

Critères : pas de N+1 si deux modèles — construire un index par id en une passe.
```

---

## Variante « niveau 2 » (optionnelle, fichier séparé)

Quand la logique est comprise, proposer le **même exercice** refait avec `where`, `with`, `groupBy` SQL pour comparer **performance** et **lisibilité**.
