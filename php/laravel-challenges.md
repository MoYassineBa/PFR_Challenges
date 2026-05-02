# Laravel — Défis Eloquent (`all()` + boucle uniquement)

**Contrainte pour tous les défis ci-dessous**

- Charger les données avec **`Model::all()`** uniquement (pas de `where`, `orderBy`, `groupBy`, `withCount`, jointures, scopes sur la requête).
- Traiter le résultat avec une **boucle** (`foreach`) et de la logique PHP (tableaux, compteurs, `if`, etc.).
- **Interdit** : filtrer ou agréger au niveau SQL / query builder avant `get()`.

*Note pédagogique : en Laravel, on écrit `User::all()` ; il n’existe pas `getAll()` sur Eloquent.*

---

### 1) Utilisateurs actifs uniquement

#### Task Description

À partir de `User::all()`, retourner un **tableau de tableaux** `id` et `name` pour les utilisateurs dont `is_active` vaut `true` (comparaison stricte ou loose selon ton modèle — ici booléen / 1).

#### Input Data

*Données obtenues après `User::all()` (équivalent seed / colonnes) :*

```json
[
  { "id": 1, "name": "Ali", "is_active": true },
  { "id": 2, "name": "Sara", "is_active": false },
  { "id": 3, "name": "Omar", "is_active": true }
]
```

#### Expected Output

```json
[
  { "id": 1, "name": "Ali" },
  { "id": 3, "name": "Omar" }
]
```

---

### 2) Grouper les utilisateurs par ville (manuel)

#### Task Description

Parcourir `User::all()`. Construire un **objet / tableau associatif** dont les clés sont les `city` et les valeurs des **tableaux de noms** (`name`).

#### Input Data

```json
[
  { "id": 1, "name": "Ali", "city": "Safi" },
  { "id": 2, "name": "Sara", "city": "Rabat" },
  { "id": 3, "name": "Omar", "city": "Safi" }
]
```

#### Expected Output

```json
{
  "Safi": ["Ali", "Omar"],
  "Rabat": ["Sara"]
}
```

---

### 3) Total des montants de commandes

#### Task Description

Avec `Order::all()`, calculer la **somme** de `amount_cents` et le **nombre** de commandes, uniquement en boucle.

#### Input Data

```json
[
  { "id": 10, "amount_cents": 5000 },
  { "id": 11, "amount_cents": 12000 },
  { "id": 12, "amount_cents": 3000 }
]
```

#### Expected Output

```json
{
  "total_cents": 20000,
  "count": 3
}
```

---

### 4) Produit au prix le plus élevé

#### Task Description

Avec `Product::all()`, trouver le produit dont `price` est **maximum** (une boucle, variables `$max` / garde du modèle ou ligne).

#### Input Data

```json
[
  { "id": 1, "name": "Souris", "price": 120 },
  { "id": 2, "name": "Clavier", "price": 450 },
  { "id": 3, "name": "Casque", "price": 450 }
]
```

#### Expected Output

*Si égalité : retourner le **premier** rencontré avec le max.*

```json
{
  "id": 2,
  "name": "Clavier",
  "price": 450
}
```

---

### 5) Emails en double

#### Task Description

Avec `Student::all()`, déterminer quels **email** apparaissent **plus d’une fois**. Retourner la liste unique des emails concernés (tableau trié alphabétiquement).

#### Input Data

```json
[
  { "id": 1, "email": "a@school.ma", "name": "Ali" },
  { "id": 2, "email": "b@school.ma", "name": "Sara" },
  { "id": 3, "email": "a@school.ma", "name": "Omar" },
  { "id": 4, "email": "c@school.ma", "name": "Lina" }
]
```

#### Expected Output

```json
["a@school.ma"]
```

---

### 6) Clients fidèles — plus de X rendez-vous

#### Task Description

Avec `Appointment::all()`, compter les lignes par `client_id`, puis retourner les **client_id** ayant **strictement plus de** `seuil` rendez-vous (tableau d’entiers trié croissant).

#### Input Data

```json
{
  "seuil": 2,
  "appointments": [
    { "id": 1, "client_id": 10 },
    { "id": 2, "client_id": 10 },
    { "id": 3, "client_id": 10 },
    { "id": 4, "client_id": 20 },
    { "id": 5, "client_id": 20 }
  ]
}
```

#### Expected Output

```json
[10]
```

*(Client 10 → 3 RDV > 2 ; client 20 → 2 RDV, pas strictement > 2.)*

---

### 7) Titres de posts avec nom d’auteur — deux `all()` + index

#### Task Description

Charger `Post::all()` et `User::all()`. Sans requête jointe : construire pour chaque post `{ post_id, title, author_name }`.  
**Recommandation** : une première boucle pour indexer les users par `id`, puis boucle sur les posts (éviter double boucle imbriquée lourde).

#### Input Data

```json
{
  "users": [
    { "id": 1, "name": "Achraf" },
    { "id": 2, "name": "Saad" }
  ],
  "posts": [
    { "id": 100, "user_id": 1, "title": "Laravel tips" },
    { "id": 101, "user_id": 2, "title": "Eloquent basics" }
  ]
}
```

#### Expected Output

```json
[
  { "post_id": 100, "title": "Laravel tips", "author_name": "Achraf" },
  { "post_id": 101, "title": "Eloquent basics", "author_name": "Saad" }
]
```

---

### 8) Trier les leçons par date en PHP

#### Task Description

Après `Lesson::all()`, produire un **nouveau tableau** des mêmes objets (ou champs utiles) trié par `starts_at` **croissant**, en utilisant uniquement `usort()` ou un tri manuel en boucle (pas de `orderBy` SQL).

#### Input Data

```json
[
  { "id": 1, "title": "B", "starts_at": "2026-05-10" },
  { "id": 2, "title": "A", "starts_at": "2026-05-02" },
  { "id": 3, "title": "C", "starts_at": "2026-05-02" }
]
```

#### Expected Output

*Tri par `starts_at` croissant ; si même date, ordre stable ou par `id` — ici par `id` croissant pour les ex-aequo.*

```json
[
  { "id": 2, "title": "A", "starts_at": "2026-05-02" },
  { "id": 3, "title": "C", "starts_at": "2026-05-02" },
  { "id": 1, "title": "B", "starts_at": "2026-05-10" }
]
```

---

### 9) Compter par catégorie (manuel)

#### Task Description

Avec `Product::all()`, construire un objet **catégorie → nombre de produits** (une boucle + compteur par clé `category`).

#### Input Data

```json
[
  { "id": 1, "name": "A", "category": "keyboard" },
  { "id": 2, "name": "B", "category": "mouse" },
  { "id": 3, "name": "C", "category": "keyboard" }
]
```

#### Expected Output

```json
{
  "keyboard": 2,
  "mouse": 1
}
```

---

### 10) Apprenants absents plus de N fois

#### Task Description

Avec `Learner::all()` (champ `absence_count` ou `absences` selon ton modèle — ici entier), retourner les **id** des apprenants avec `absence_count` **strictement supérieur** à `seuil` (tableau trié croissant).

#### Input Data

```json
{
  "seuil": 5,
  "learners": [
    { "id": 1, "name": "Ali", "absence_count": 4 },
    { "id": 2, "name": "Sara", "absence_count": 6 },
    { "id": 3, "name": "Omar", "absence_count": 7 }
  ]
}
```

#### Expected Output

```json
[2, 3]
```

---

### 11) Moyenne des notes (boucle uniquement)

#### Task Description

Avec `Grade::all()` (champ `score`), calculer la **moyenne arithmétique** (float arrondi à 2 décimales) et le **nombre** de notes. Pas de `avg()` SQL.

#### Input Data

```json
[
  { "id": 1, "student_id": 10, "score": 12 },
  { "id": 2, "student_id": 10, "score": 16 },
  { "id": 3, "student_id": 11, "score": 14 }
]
```

#### Expected Output

```json
{
  "average": 14,
  "count": 3
}
```

---

### 12) Premier élément qui satisfait une condition

#### Task Description

Parcourir `Order::all()` dans l’ordre. Retourner le **premier** objet (id + total_cents) tel que `total_cents` ≥ `min_total`. Si aucun : `null`.

#### Input Data

```json
{
  "min_total": 8000,
  "orders": [
    { "id": 1, "total_cents": 5000 },
    { "id": 2, "total_cents": 9000 },
    { "id": 3, "total_cents": 12000 }
  ]
}
```

#### Expected Output

```json
{
  "id": 2,
  "total_cents": 9000
}
```

---

### 13) Filtre à deux conditions (ET)

#### Task Description

Avec `User::all()`, retourner les utilisateurs où `is_active` est vrai **et** `role` vaut exactement `coach` (tableau d’objets `id`, `name`).

#### Input Data

```json
[
  { "id": 1, "name": "Ali", "is_active": true, "role": "coach" },
  { "id": 2, "name": "Sara", "is_active": true, "role": "student" },
  { "id": 3, "name": "Omar", "is_active": false, "role": "coach" }
]
```

#### Expected Output

```json
[
  { "id": 1, "name": "Ali" }
]
```

---

### 14) Joindre commandes et clients (deux `all()`, clé étrangère)

#### Task Description

`Order::all()` contient `customer_id`. `Customer::all()` contient `id` et `email`. Produire la liste `{ order_id, total_cents, customer_email }` en utilisant un **index** `customer_id → email` construit en une passe.

#### Input Data

```json
{
  "customers": [
    { "id": 10, "email": "a@mail.ma" },
    { "id": 20, "email": "b@mail.ma" }
  ],
  "orders": [
    { "id": 100, "customer_id": 20, "total_cents": 1500 },
    { "id": 101, "customer_id": 10, "total_cents": 800 }
  ]
}
```

#### Expected Output

```json
[
  { "order_id": 100, "total_cents": 1500, "customer_email": "b@mail.ma" },
  { "order_id": 101, "total_cents": 800, "customer_email": "a@mail.ma" }
]
```

---

### 15) Pagination en mémoire (page et taille)

#### Task Description

Après `Item::all()`, trier par `id` croissant en PHP, puis retourner uniquement la **page** `page` (1-based) avec `per_page` éléments. Ex. `page=2`, `per_page=2` sur 5 lignes → éléments index 2 et 3 (0-based).

#### Input Data

```json
{
  "page": 2,
  "per_page": 2,
  "items": [
    { "id": 1, "label": "a" },
    { "id": 2, "label": "b" },
    { "id": 3, "label": "c" },
    { "id": 4, "label": "d" },
    { "id": 5, "label": "e" }
  ]
}
```

#### Expected Output

```json
[
  { "id": 3, "label": "c" },
  { "id": 4, "label": "d" }
]
```

---

### 16) Liste des emails uniques (ordre d’apparition)

#### Task Description

Avec `Student::all()`, extraire les `email` **uniques** en conservant l’**ordre de première apparition**.

#### Input Data

```json
[
  { "id": 1, "email": "z@school.ma" },
  { "id": 2, "email": "a@school.ma" },
  { "id": 3, "email": "z@school.ma" }
]
```

#### Expected Output

```json
["z@school.ma", "a@school.ma"]
```

---

### 17) Produit au prix minimum

#### Task Description

Comme le défi « prix max », mais retourner le produit au **prix le plus bas**. En cas d’égalité, prendre le **premier** rencontré.

#### Input Data

```json
[
  { "id": 1, "name": "A", "price": 100 },
  { "id": 2, "name": "B", "price": 50 },
  { "id": 3, "name": "C", "price": 50 }
]
```

#### Expected Output

```json
{
  "id": 2,
  "name": "B",
  "price": 50
}
```

---

### 18) Tous les éléments vérifient une propriété

#### Task Description

Avec `User::all()`, retourner `true` si **chaque** utilisateur a `is_active === true`, sinon `false` (court-circuit possible dès qu’un faux).

#### Input Data

```json
[
  { "id": 1, "is_active": true },
  { "id": 2, "is_active": true }
]
```

#### Expected Output

```json
true
```

*Variante pour tester `false` : ajouter un utilisateur `is_active: false` → sortie `false`.*

---

### 19) Somme des montants par client_id (manuel)

#### Task Description

Avec `Payment::all()` (`client_id`, `amount_cents`), produire un objet **client_id → total_cents** (boucle + accumulation).

#### Input Data

```json
[
  { "id": 1, "client_id": 1, "amount_cents": 1000 },
  { "id": 2, "client_id": 2, "amount_cents": 500 },
  { "id": 3, "client_id": 1, "amount_cents": 300 }
]
```

#### Expected Output

```json
{
  "1": 1300,
  "2": 500
}
```

---

### 20) Mapper vers un tableau d’IDs seulement

#### Task Description

Avec `Tag::all()`, produire un tableau simple `[1, 2, 3, ...]` des `id` dans l’**ordre du parcours** de `all()`.

#### Input Data

```json
[
  { "id": 5, "slug": "php" },
  { "id": 8, "slug": "js" },
  { "id": 2, "slug": "sql" }
]
```

#### Expected Output

```json
[5, 8, 2]
```

---

### 21) Inverser l’ordre du tableau en PHP

#### Task Description

Après `Article::all()`, retourner les mêmes éléments dans l’**ordre inverse** (dernier en premier) sans `orderBy` SQL — utiliser `array_reverse` ou une boucle.

#### Input Data

```json
[
  { "id": 1, "title": "First" },
  { "id": 2, "title": "Second" },
  { "id": 3, "title": "Third" }
]
```

#### Expected Output

```json
[
  { "id": 3, "title": "Third" },
  { "id": 2, "title": "Second" },
  { "id": 1, "title": "First" }
]
```

---

### 22) Compter les lignes satisfaisant une plage

#### Task Description

Avec `Score::all()` (champ `value`), retourner combien de scores sont **strictement** entre `min` et `max` (bornes exclusives).

#### Input Data

```json
{
  "min": 10,
  "max": 20,
  "scores": [
    { "id": 1, "value": 10 },
    { "id": 2, "value": 15 },
    { "id": 3, "value": 20 },
    { "id": 4, "value": 12 }
  ]
}
```

#### Expected Output

```json
{
  "count_in_range": 2
}
```

*(15 et 12 sont dans ]10,20[ ; 10 et 20 exclus.)*

---

## Corrigé type (pseudo-code non obligatoire pour l’énoncé)

```php
$users = User::all();
$result = [];
foreach ($users as $user) {
    if ($user->is_active) {
        $result[] = ['id' => $user->id, 'name' => $user->name];
    }
}
return response()->json($result);
```
