Quiz POO – PHP (31 questions)
1. Qu’est-ce qu’une classe en PHP ?
Réponse attendue :
Une classe est un plan ou un modèle qui définit des propriétés (attributs) et des méthodes (fonctions) communes à tous les objets qui en seront issus.

2. Que fait le mot‑clé new ?
Réponse :
new instancie un objet à partir d’une classe, c’est-à-dire qu’il crée une occurrence concrète en mémoire.

3. Comment déclare-t-on une propriété privée dans une classe PHP ?
Réponse :
En utilisant le mot‑clé private devant la propriété, par exemple private $nom;.

4. Quelle est la différence entre public, protected et private ?
Réponse :

public : accessible depuis n’importe où.

protected : accessible depuis la classe elle-même et ses classes filles (héritage).

private : accessible seulement à l’intérieur de la classe qui le déclare.

5. À quoi sert le mot‑clé $this ?
Réponse :
$this est une pseudo-variable qui fait référence à l’objet courant (l’instance à l’intérieur de laquelle on se trouve). Elle permet d’accéder aux propriétés et méthodes non statiques de l’instance.

6. Comment appeler le constructeur de la classe parente depuis une classe enfant ?
Réponse :
Avec parent::__construct(). Par exemple :

php
parent::__construct($param);
7. Qu’est-ce que l’héritage en POO ?
Réponse :
L’héritage est un mécanisme qui permet à une classe enfant (sous-classe) de réutiliser et d’étendre les propriétés et méthodes d’une classe parente (super-classe). En PHP, on utilise le mot‑clé extends.

8. Peut-on hériter de plusieurs classes en PHP ? Expliquez.
Réponse :
Non, PHP n’autorise pas l’héritage multiple. Une classe ne peut étendre qu’une seule classe. En revanche, elle peut implémenter plusieurs interfaces.

9. Que signifie le mot‑clé final sur une méthode ?
Réponse :
Une méthode déclarée final ne peut pas être redéfinie (overridden) par une classe enfant.

10. Que signifie final sur une classe ?
Réponse :
Une classe final ne peut pas être étendue. Aucune classe ne peut hériter d’elle.

11. À quoi sert une interface en PHP ?
Réponse :
Une interface définit un contrat : elle liste des méthodes publiques (sans implémentation) que les classes qui l’implémentent doivent obligatoirement fournir. Une interface ne peut contenir que des signatures de méthodes (ou des constantes).

12. Une interface peut-elle contenir des propriétés (attributs) ?
Réponse :
Non, une interface ne peut pas contenir de propriétés (variables d’instance). Elle peut seulement contenir des constantes et des déclarations de méthodes.

13. Comment une classe implémente-t-elle une interface ?
Réponse :
Avec le mot‑clé implements, suivi du nom de l’interface. Une classe peut implémenter plusieurs interfaces séparées par des virgules.

14. Quelle est la différence entre une classe abstraite et une interface ?
Réponse :

Une classe abstraite peut contenir des propriétés et des méthodes concrètes (avec code), ainsi que des méthodes abstraites.

Une interface ne contient que des signatures de méthodes (jusqu’à PHP 8, elle peut aussi avoir des méthodes concrètes avec default, mais c’est rare).

Une classe peut étendre une seule classe abstraite mais implémenter plusieurs interfaces.

15. Comment déclarer une méthode abstraite dans une classe ?
Réponse :
Avec le mot‑clé abstract avant la signature de la méthode, et sans corps (pas d’accolades ni code). La classe elle-même doit être déclarée abstract.

16. Une classe abstraite peut-elle être instanciée directement ?
Réponse :
Non. On ne peut pas faire new MaClasseAbstraite(). Une classe abstraite sert uniquement à être étendue.

17. Qu’est-ce que le polymorphisme ?
Réponse :
Le polymorphisme est la capacité d’un même nom de méthode à se comporter différemment selon l’objet qui l’exécute. En PHP, il s’obtient principalement par la redéfinition de méthodes (override) et par l’utilisation d’interfaces.

18. Donnez un exemple simple de polymorphisme en PHP.
Réponse :

php
interface Animal {
    public function faireBruit();
}
class Chien implements Animal {
    public function faireBruit() { echo "Woof"; }
}
class Chat implements Animal {
    public function faireBruit() { echo "Miaou"; }
}
function test(Animal $a) { $a->faireBruit(); }
// test(new Chien()) affiche Woof, test(new Chat()) affiche Miaou.
19. Que sont les propriétés et méthodes statiques ?
Réponse :
Les membres static appartiennent à la classe elle-même et non à une instance particulière. On y accède via Classe::$propriete ou Classe::methode() sans avoir besoin d’instancier un objet.

20. Peut-on utiliser $this dans une méthode statique ?
Réponse :
Non. $this dépend d’une instance ; dans une méthode statique, il n’y a pas d’instance courante. Une méthode statique ne peut accéder qu’à d’autres membres statiques via self::.

21. À quoi sert le mot‑clé self ?
Réponse :
self fait référence à la classe elle-même (au niveau du code, pas à une instance). Il est utilisé pour accéder à des membres statiques ou constants de la classe courante, par exemple self::MA_CONSTANTE.

22. Quelle est la différence entre self:: et static:: ?
Réponse :

self:: résout l’appel à la classe dans laquelle le code est écrit (liaison statique précoce).

static:: résout l’appel à la classe réellement utilisée à l’exécution (liaison statique tardive, ou “late static binding”). Utile pour l’héritage.

23. Qu’est-ce que le type void dans une déclaration de méthode PHP ?
Réponse :
void indique qu’une méthode ne retourne aucune valeur. Elle ne peut pas contenir d’instruction return quelque chose ; un simple return; est autorisé mais optionnel.

24. Comment PHP permet-il de typer un paramètre comme étant un objet d’une classe spécifique ?
Réponse :
En utilisant le type hint ou “type declaration”. Par exemple : function maFonction(User $user) { … } exige que $user soit une instance de la classe User.

25. Que signifie ?Type (exemple : ?string) dans un type déclaré ?
Réponse :
Le point d’interrogation avant un type indique que le paramètre ou la valeur de retour peut être soit une valeur de ce type, soit null.

26. Qu’est-ce que le late static binding ?
Réponse :
C’est un mécanisme qui permet à une méthode statique d’être résolue en fonction de la classe appelée au moment de l’exécution (via static::), et non de la classe où la méthode est définie (qui serait self::). Utile dans les hiérarchies d’héritage.

27. Une interface peut-elle étendre une autre interface ?
Réponse :
Oui. Une interface peut extends une ou plusieurs interfaces, héritant ainsi de leurs signatures.

28. Qu’est-ce qu’une constante de classe ? Comment y accéder ?
Réponse :
Une constante de classe est une valeur fixe liée à une classe, déclarée avec const. On y accède avec NomClasse::NOM_CONSTANTE. Les constantes peuvent être redéfinies dans une classe enfant.

29. Que produit le code suivant ?
php
class A { public static $x = 0; }
class B extends A { }
A::$x = 5;
echo B::$x;
Réponse :
Il affiche 5. Les propriétés statiques sont partagées entre la classe parente et ses enfants (sauf si redéfinie explicitement dans l’enfant).

30. Quelle est l’utilité du mot‑clé clone ?
Réponse :
clone crée une copie superficielle (shallow copy) d’un objet. La méthode magique __clone() peut être définie pour ajuster le comportement lors de la copie.

31. À quoi sert le constructeur d’une classe ? Donnez un exemple simple.
Réponse :# Programmation Orientee Objet (POO) - Cours complet

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


Le constructeur (méthode __construct()) est appelé automatiquement lors de l’instanciation d’un objet. Il sert généralement à initialiser les propriétés de l’objet.
Exemple :

php
class User {
    public $name;
    public function __construct($name) {
        $this->name = $name;
    }
}
