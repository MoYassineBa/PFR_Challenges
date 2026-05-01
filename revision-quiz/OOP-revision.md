# Programmation Orientee Objet (POO) - Cours complet

## Qu'est-ce que la POO ?

La **Programmation Orientee Objet** est un paradigme qui organise le code autour d'**objets** (contenant des donnees et des comportements) plutot qu'autour de fonctions separees.  
Un objet est une **instance** d'une **classe** (le plan ou le moule).

**Avantages :**
- Modelisation du monde reel
- Reutilisabilite du code (DRY)
- Modularite et maintenance facilitee
- Encapsulation de la complexite

---

## Les 4 piliers de la POO (avec exemples Java)

### 1. Encapsulation

**Definition**  
L'encapsulation consiste a regrouper les donnees et les methodes qui les manipulent dans une seule classe, tout en **masquant les details internes** avec des modificateurs d'acces (`private`, `protected`, `public`).

**Avantages**
- Protege l'etat interne de l'objet contre les modifications directes
- Permet de controler les regles metier via des methodes publiques
- Rend le code plus sur et plus facile a maintenir

**Code Example**

```java
public class CompteBancaire {
    private String proprietaire;
    private double solde;   // prive : invisible depuis l'exterieur

    public CompteBancaire(String proprietaire, double soldeInitial) {
        this.proprietaire = proprietaire;
        if (soldeInitial > 0) this.solde = soldeInitial;
    }

    public void deposer(double montant) {
        if (montant > 0) {
            solde += montant;
            System.out.println("Depot de " + montant + " EUR. Nouveau solde : " + solde);
        }
    }

    public double getSolde() { return solde; }  // getter
}
```

**Brief Code Explanation**  
`solde` est `private`, donc il n'est pas modifiable directement depuis l'exterieur. On passe par des methodes (`deposer`, `getSolde`) qui appliquent des regles de validation.

### 2. Heritage

**Definition**  
L'heritage permet a une classe enfant de recuperer les attributs et les methodes d'une classe parent.

**Avantages**
- Evite la duplication de code
- Facilite la reutilisation des comportements communs
- Permet d'etendre un modele existant proprement

Une classe enfant peut :

- utiliser les membres herites
- redefinir (`override`) une methode
- ajouter ses propres membres

**Code Example**

```java
class Animal {
    protected String nom;
    public Animal(String nom) { this.nom = nom; }
    public void parler() { System.out.println(nom + " fait un bruit."); }
}

class Chien extends Animal {
    public Chien(String nom) { super(nom); }
    @Override
    public void parler() { System.out.println(nom + " dit : Woof !"); }
}
```

**Brief Code Explanation**  
`Chien` herite de `Animal` avec `extends`. Il reutilise l'attribut `nom`, appelle le constructeur parent via `super(nom)`, et redefinit `parler()`.

### 3. Polymorphisme

**Definition**  
Le polymorphisme ("plusieurs formes") permet d'utiliser une meme reference ou methode pour manipuler differents types d'objets.

**Avantages**
- Rend le code plus flexible et extensible
- Permet de coder contre des abstractions (parent/interface)
- Reduit les `if/else` bases sur le type concret

Polymorphisme d'execution (redefinition) :

**Code Example**

```java
Animal monAnimal = new Chien("Rex");
monAnimal.parler();  // Rex dit : Woof !
```

Surcharge (compilation) :

```java
class Calculatrice {
    int add(int a, int b) { return a + b; }
    int add(int a, int b, int c) { return a + b + c; }
}
```

**Brief Code Explanation**  
Dans le premier exemple, la reference est de type `Animal`, mais la methode executee est celle de `Chien` (polymorphisme d'execution).  
Dans le second, `add` existe avec plusieurs signatures (surcharge compilee).

### 4. Abstraction

**Definition**  
L'abstraction consiste a cacher les details d'implementation et a exposer uniquement les fonctionnalites essentielles, via des classes abstraites ou des interfaces.

**Avantages**
- Clarifie les responsabilites de chaque composant
- Force un contrat commun entre implementations
- Simplifie l'evolution du code sans casser les usages

**Code Example**

```java
abstract class Forme {
    abstract double calculerAire();   // methode abstraite
}

interface Roulant {
    void avancer();   // contrat
}
```

**Brief Code Explanation**  
`Forme` impose la methode `calculerAire()` sans definir son contenu.  
`Roulant` definit un contrat (`avancer()`) que chaque classe concrete devra implementer.

---

## Les mots-cles de la POO (Java) - exemples et breves explications

| Mot-cle | Exemple | Breve explication |
|---|---|---|
| `class` | `class Personne { }` | Declare une nouvelle classe (plan pour objets). |
| `new` | `Personne p = new Personne();` | Cree un objet (instance) a partir d'une classe. |
| `this` | `this.nom = nom;` | Reference a l'objet courant (distingue attribut / parametre). |
| `super` | `super(nom);` | Appelle le constructeur ou une methode de la classe parente. |
| `extends` | `class Chien extends Animal { }` | Etablit l'heritage (Chien herite d'Animal). |
| `implements` | `class Cercle implements Dessinable { }` | Une classe realise une interface (doit fournir le code). |
| `abstract` | `abstract void dessiner();` | Methode sans corps (obligatoire pour les sous-classes). |
| `interface` | `interface Louable { void louer(); }` | Contrat : liste de methodes a implementer. |
| `final` | `final class ClasseFinale { }` | Empeche l'heritage (classe) ou la redefinition (methode). |
| `static` | `static int compteur;` | Membre appartenant a la classe, non aux instances. |
| `public` | `public void methode() { }` | Accessible partout (toutes les classes). |
| `private` | `private int solde;` | Accessible uniquement dans la classe ou il est declare. |
| `protected` | `protected String nom;` | Accessible dans la classe, les sous-classes et le meme package. |
| `instanceof` | `if (objet instanceof String)` | Teste si un objet est d'un type donne. |
| `return` | `return a + b;` | Termine une methode et renvoie une valeur. |
| `void` | `public void afficher() { }` | Indique qu'une methode ne retourne rien. |

---

## Exemple complet (tous concepts et mots-cles)

```java
interface Travailleur {
    void travailler();
    double getSalaire();
}

abstract class Employe implements Travailleur {
    private String nom;
    private double salaireBase;

    public Employe(String nom, double salaireBase) {
        this.nom = nom;
        this.salaireBase = salaireBase;
    }

    public String getNom() { return nom; }
    protected double getSalaireBase() { return salaireBase; }
    public abstract void travailler();
}

class Developpeur extends Employe {
    public Developpeur(String nom, double salaire) { super(nom, salaire); }

    @Override
    public void travailler() { System.out.println(getNom() + " ecrit du code."); }

    @Override
    public double getSalaire() { return getSalaireBase() + 5000; }
}

public class Entreprise {
    public static void main(String[] args) {
        Travailleur alice = new Developpeur("Alice", 70000);
        alice.travailler();
        System.out.println("Salaire : " + alice.getSalaire());
    }
}
```

---

## Remarques pour PHP

Les memes mots-cles existent en PHP avec quelques nuances :

- `$this` au lieu de `this`
- `parent::` au lieu de `super`
- `::` pour `static`
- `final`, `abstract`, `interface`, `implements`, `extends` identiques
- `instanceof` identique
- `: void` (PHP 7.1+) pour le type de retour

Exemple PHP :

```php
class Chien extends Animal {
    public function parler(): void {
        echo $this->nom . " dit Woof !";
    }
}
```

---

## Conclusion

La POO repose sur l'encapsulation, l'heritage, le polymorphisme, l'abstraction et s'appuie sur des mots-cles precis (`class`, `extends`, `implements`, `abstract`, `interface`, `static`, `final`, `public`, `private`, `protected`, `super`, `this`, `instanceof`, `return`, `void`).  
Maitriser ces concepts permet de concevoir des applications robustes, evolutives et maintenables.

