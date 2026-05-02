# Achraf - PHP Challenges (OOP, données, concepts)

---

### 1) Client et Fournisseur héritant de Entreprise

#### Task Description

Créer une classe de base `Entreprise` et deux classes `Client` et `Fournisseur` qui en héritent.  
La méthode `afficherType()` affiche le **nom**, le **pays** et le **type** d’entreprise (`Client` ou `Fournisseur`).  
*(MES : encapsulation recommandée ; polymorphisme sur `afficherType()`.)*

#### Input Data

```json
{
  "entreprises": [
    { "type": "client", "nom": "ACME", "pays": "MA" },
    { "type": "fournisseur", "nom": "TechSupply", "pays": "FR" }
  ]
}
```

#### Expected Output

```json
[
  "ACME (MA) — type: Client",
  "TechSupply (FR) — type: Fournisseur"
]
```

---

### 2) Clients fidèles (boucle sur les rendez-vous)

#### Task Description

À partir d’une liste de rendez-vous par client, retourner les **clients fidèles** : ceux qui ont **strictement plus de** `seuil` rendez-vous.  
*(Utiliser une boucle et/ou agrégation ; un client = identifiant unique.)*

#### Input Data

```json
{
  "seuil": 3,
  "appointments": [
    { "clientId": 1, "date": "2026-01-01" },
    { "clientId": 2, "date": "2026-01-02" },
    { "clientId": 1, "date": "2026-01-05" },
    { "clientId": 1, "date": "2026-01-10" },
    { "clientId": 1, "date": "2026-01-15" },
    { "clientId": 3, "date": "2026-01-20" }
  ]
}
```

#### Expected Output

```json
[1]
```

---

### 3) Apprenants absents plus de 5 fois

#### Task Description

Parcourir la structure fournie et retourner les **identifiants** des apprenants dont le **nombre d’absences** est **supérieur à 5**.

#### Input Data

```json
{
  "learners": [
    { "id": 10, "name": "Ali", "absences": 3 },
    { "id": 11, "name": "Sara", "absences": 6 },
    { "id": 12, "name": "Omar", "absences": 5 },
    { "id": 13, "name": "Lina", "absences": 8 }
  ]
}
```

#### Expected Output

```json
[11, 13]
```

---

### 4) Qu’est-ce qu’un contrôleur ? (concept MVC)

#### Task Description

Répondre en une courte définition : rôle d’un **contrôleur** dans une architecture MVC / application web PHP.

#### Input Data

```json
{
  "context": "PHP MVC"
}
```

#### Expected Output

```json
{
  "definition": "Le contrôleur reçoit la requête HTTP, appelle le modèle pour les données, choisit la logique métier adaptée, puis prépare la réponse (souvent en déléguant l’affichage à une vue). Il ne doit pas contenir toute la logique métier ni le HTML détaillé."
}
```

---

### 5) Etudiant et Enseignant héritant de Personne

#### Task Description

Créer `Personne` (ou classe abstraite selon ta conception) avec `sePresenter()` : afficher **nom**, **âge** et **type** (étudiant ou enseignant).

#### Input Data

```json
{
  "people": [
    { "type": "etudiant", "nom": "Karim", "age": 19 },
    { "type": "enseignant", "nom": "Mme Alami", "age": 42 }
  ]
}
```

#### Expected Output

```json
[
  "Je suis Karim, j'ai 19 ans, je suis étudiant.",
  "Je suis Mme Alami, j'ai 42 ans, je suis enseignant."
]
```

---

### 6) Animal abstrait — Chien et Chat

#### Task Description

Créer une classe abstraite `Animal` avec une méthode abstraite `afficher()`.  
Implémenter `Chien` et `Chat` avec des comportements différents.

#### Input Data

```json
{
  "animals": [
    { "type": "chien", "nom": "Rex" },
    { "type": "chat", "nom": "Minou" }
  ]
}
```

#### Expected Output

```json
[
  "Chien Rex : Woof",
  "Chat Minou : Miaou"
]
```

---

### 7) Classe Mathematiques — méthodes statiques

#### Task Description

Créer une classe `Mathematiques` avec :
- `addition(a, b)` statique
- `division(a, b)` statique (gérer division par zéro)

#### Input Data

```json
{
  "ops": [
    { "op": "addition", "a": 10, "b": 5 },
    { "op": "division", "a": 20, "b": 4 },
    { "op": "division", "a": 3, "b": 0 }
  ]
}
```

#### Expected Output

```json
[
  15,
  5,
  "Division par zéro impossible"
]
```

---

### 8) Compte bancaire — solde jamais négatif

#### Task Description

Un compte a un **titulaire** et un **solde**. Fournir `depot(montant)` et `retrait(montant)`. Le solde ne doit **jamais** devenir négatif : un retrait impossible laisse le solde inchangé.

#### Input Data

```json
{
  "titulaire": "Achraf",
  "operations": [
    { "type": "depot", "montant": 100 },
    { "type": "retrait", "montant": 30 },
    { "type": "retrait", "montant": 200 }
  ]
}
```

#### Expected Output

```json
{
  "titulaire": "Achraf",
  "solde": 70,
  "logs": [
    "depot 100 → solde 100",
    "retrait 30 → solde 70",
    "retrait 200 refusé → solde 70"
  ]
}
```

---

### 9) Boutique — produits physiques et numériques

#### Task Description

Modéliser des **produits physiques** (`nom`, `prixUnitaire`, `poids`) et **numériques** (`nom`, `prixUnitaire`, `lienTelechargement`).  
Chaque produit expose une **fiche complète** (méthode dédiée). Le **prix ne doit jamais être négatif** (validation).

#### Input Data

```json
{
  "products": [
    { "kind": "physique", "nom": "Clavier", "prixUnitaire": 350, "poids": 0.5 },
    { "kind": "numerique", "nom": "Ebook PHP", "prixUnitaire": 120, "lienTelechargement": "https://shop.ma/ebook-php" }
  ]
}
```

#### Expected Output

```json
[
  "Physique | Clavier | 350 DH | 0.5 kg",
  "Numerique | Ebook PHP | 120 DH | https://shop.ma/ebook-php"
]
```

---

### 10) École — étudiants et enseignants se présentent

#### Task Description

Tous ont **nom** et **âge**. Chaque personne doit pouvoir **se présenter** avec une phrase incluant son rôle métier (filière pour l’étudiant, matière pour l’enseignant).

#### Input Data

```json
{
  "people": [
    {
      "role": "etudiant",
      "nom": "Karim",
      "age": 20,
      "filiere": "informatique"
    },
    {
      "role": "enseignant",
      "nom": "Mme Alami",
      "age": 45,
      "matiere": "mathématiques"
    }
  ]
}
```

#### Expected Output

```json
[
  "Je suis Karim, 20 ans, étudiant en informatique",
  "Je suis Mme Alami, 45 ans, enseignante de mathématiques"
]
```

---

### 11) Calculatrice statique — garder le premier résultat de division

#### Task Description

Créer une classe avec une méthode statique `diviser(a, b)` qui effectue la division **sans instanciation**. Conserver en mémoire le **premier** résultat de division calculé ; exposer `getPremierResultat()`.

#### Input Data

```json
{
  "divisions": [
    [6, 2],
    [8, 4],
    [15, 3]
  ]
}
```

#### Expected Output

```json
{
  "results": [3, 2, 5],
  "premierResultat": 3
}
```

---

### 12) Prestataire et Sous-traitant héritant de Partenaire

#### Task Description

Même idée que `Entreprise` / `Client` / `Fournisseur` : classe parent `Partenaire` avec `afficherProfil()` ; enfants `Prestataire` et `SousTraitant` (nom, ville, type).

#### Input Data

```json
{
  "partenaires": [
    { "type": "prestataire", "nom": "DevTeam", "ville": "Safi" },
    { "type": "soustraitant", "nom": "LogiX", "ville": "Casa" }
  ]
}
```

#### Expected Output

```json
[
  "DevTeam — Safi — Prestataire",
  "LogiX — Casa — Sous-traitant"
]
```

---

### 13) Clients fidèles — compter les RDV par client

#### Task Description

À partir de la même logique que le défi « clients fidèles », retourner un **tableau associatif** `clientId => nombre de rendez-vous` (pas seulement la liste des fidèles).

#### Input Data

```json
{
  "appointments": [
    { "clientId": 1, "date": "2026-01-01" },
    { "clientId": 2, "date": "2026-01-02" },
    { "clientId": 1, "date": "2026-01-03" },
    { "clientId": 1, "date": "2026-01-04" }
  ]
}
```

#### Expected Output

```json
{
  "1": 3,
  "2": 1
}
```

---

### 14) Apprenants — au moins 5 absences (seuil inclus)

#### Task Description

Retourner les apprenants dont le nombre d’**absences est supérieur ou égal à** `seuil` (ici 5).

#### Input Data

```json
{
  "seuil": 5,
  "learners": [
    { "id": 10, "absences": 4 },
    { "id": 11, "absences": 5 },
    { "id": 12, "absences": 7 }
  ]
}
```

#### Expected Output

```json
[11, 12]
```

---

### 15) Rôle du modèle (MVC) — définition courte

#### Task Description

Expliquer en une phrase le rôle du **modèle** dans MVC (PHP).

#### Input Data

```json
{ "theme": "MVC" }
```

#### Expected Output

```json
{
  "definition": "Le modèle représente les données et les règles métier (accès BDD, validation, calculs) indépendamment de l’interface et du contrôleur."
}
```

---

### 16) Médecin et Patient héritant de Personne

#### Task Description

`Personne` avec `sePresenter()` ; `Medecin` (spécialité) et `Patient` (numéro dossier) avec messages distincts.

#### Input Data

```json
{
  "people": [
    { "type": "medecin", "nom": "Dr. Benani", "age": 50, "specialite": "cardiologie" },
    { "type": "patient", "nom": "Omar", "age": 33, "dossier": "P-9921" }
  ]
}
```

#### Expected Output

```json
[
  "Je suis Dr. Benani, 50 ans, médecin en cardiologie",
  "Je suis Omar, 33 ans, patient (dossier P-9921)"
]
```

---

### 17) Animal — Oiseau en plus de Chien et Chat

#### Task Description

Étendre le modèle Animal : `Oiseau` implémente `afficher()` différemment de `Chien` et `Chat`.

#### Input Data

```json
{
  "animals": [
    { "type": "chien", "nom": "Rex" },
    { "type": "oiseau", "nom": "Titi" }
  ]
}
```

#### Expected Output

```json
[
  "Chien Rex : Woof",
  "Oiseau Titi : Cui cui"
]
```

---

### 18) Mathematiques — multiplication et modulo statiques

#### Task Description

Ajouter à `Mathematiques` : `multiplier(a, b)` et `modulo(a, b)` statiques (`modulo` avec gestion de `b === 0`).

#### Input Data

```json
{
  "ops": [
    { "op": "multiplier", "a": 6, "b": 7 },
    { "op": "modulo", "a": 17, "b": 5 },
    { "op": "modulo", "a": 4, "b": 0 }
  ]
}
```

#### Expected Output

```json
[
  42,
  2,
  "Modulo par zéro impossible"
]
```

---

### 19) Compte virtuel vs compte physique (abstraction)

#### Task Description

À partir d’un `Compte` abstrait ou d’une interface commune, modéliser `CompteVirtuel` (frais de transaction 2 %) et `ComptePhysique` (frais fixes 10 DH par retrait).  
Après un **retrait de 50** depuis un solde initial **200**, retourner le solde restant pour chaque type.

#### Input Data

```json
{
  "soldeInitial": 200,
  "montantRetrait": 50
}
```

#### Expected Output

```json
{
  "virtuel": { "solde": 147 },
  "physique": { "solde": 140 }
}
```

*Calcul attendu (documenter dans le corrigé) : virtuel 200 - 50 - 3 (2 % de 150) = 147 ; physique 200 - 50 - 10 = 140.*

---

### 20) Boutique — rejeter un prix négatif

#### Task Description

Lors de la création d’un produit, si `prixUnitaire < 0`, ne pas créer l’objet : retourner un message d’erreur clair.

#### Input Data

```json
{
  "kind": "physique",
  "nom": "Souris",
  "prixUnitaire": -10,
  "poids": 0.1
}
```

#### Expected Output

```json
{
  "error": "Le prix unitaire ne peut pas être négatif"
}
```

---

### 21) École — personnel administratif

#### Task Description

Ajouter un rôle `administratif` à côté de `etudiant` et `enseignant`, avec phrase de présentation du type : service + nom.

#### Input Data

```json
{
  "people": [
    {
      "role": "administratif",
      "nom": "Nadia",
      "age": 38,
      "service": "scolarité"
    }
  ]
}
```

#### Expected Output

```json
[
  "Je suis Nadia, 38 ans, personnel administratif (service scolarité)"
]
```

---

### 22) Calculatrice statique — historique des divisions

#### Task Description

Comme le défi 11, mais en plus : stocker un **historique** des opérations `"a/b=resultat"` pour chaque division réussie ; les divisions invalides ne sont pas ajoutées à l’historique.

#### Input Data

```json
{
  "divisions": [
    [10, 2],
    [9, 0],
    [12, 3]
  ]
}
```

#### Expected Output

```json
{
  "results": [5, "Division impossible", 4],
  "premierResultat": 5,
  "historique": ["10/2=5", "12/3=4"]
}
```
