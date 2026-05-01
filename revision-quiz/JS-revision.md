# Concepts cles de JavaScript (hors POO) - Resume et quiz

## Introduction

JavaScript est un langage multi-paradigme. Cette fiche couvre ses **fonctionnalites fondamentales** (portee, closures, asynchrone, prototypes, etc.) **sans se concentrer sur la Programmation Orientee Objet** (classes, heritage, etc.).

---

## 1. Variables : `var`, `let`, `const`

- `var` : portee de fonction, **hoisting** (remontee) avec initialisation a `undefined`.
- `let` : portee de bloc, hoisting mais **Temporal Dead Zone** (TDZ) - pas d'acces avant declaration.
- `const` : comme `let` mais **reaffectation impossible** (l'objet peut etre mute).

```javascript
console.log(a); // undefined (var)
var a = 1;

console.log(b); // ReferenceError (TDZ)
let b = 2;

const c = 3;
c = 4; // TypeError
```

## 2. Types de donnees

- Primitifs : `string`, `number`, `boolean`, `null`, `undefined`, `symbol`, `bigint`
- Reference : objets (y compris tableaux, fonctions)

```javascript
let x = 5, y = x; // copie de valeur
y = 10; // x reste 5

let obj1 = { val: 1 }, obj2 = obj1; // meme reference
obj2.val = 2; // obj1.val vaut aussi 2
```

## 3. Hoisting (remontee)

Les declarations (`var`, `function`) sont remontees en haut de leur portee.  
`let` et `const` sont aussi remontees mais non initialisees (TDZ).

```javascript
console.log(foo); // undefined
var foo = "bar";

hello(); // "Hello" (fonction declaree)
function hello() { console.log("Hello"); }
```

## 4. Portee (scope)

- Globale : accessible partout
- Fonction : accessible uniquement dans la fonction
- Bloc : avec `let` et `const` (entre `{}`)

```javascript
if (true) {
  var x = 1;   // globale/fonction
  let y = 2;   // bloc
}
console.log(x); // 1
console.log(y); // ReferenceError
```

## 5. Closures

Une closure est une fonction qui se souvient de son environnement lexical meme apres l'execution de la fonction externe.

```javascript
function compteur() {
  let count = 0;
  return function() {
    count++;
    return count;
  };
}
const inc = compteur();
console.log(inc()); // 1
console.log(inc()); // 2
```

## 6. Le mot-cle `this`

La valeur de `this` depend du contexte d'appel :

- Globale / fonction simple : `window` (ou `undefined` en mode strict)
- Methode d'objet : l'objet appelant
- Constructeur (`new`) : la nouvelle instance
- `call` / `apply` / `bind` : explicite
- Fonction flechee : pas de `this` propre, herite du parent lexical

```javascript
const obj = {
  name: "Alice",
  greet() { console.log(this.name); },
  greetArrow: () => console.log(this.name)
};
obj.greet();      // Alice
obj.greetArrow(); // undefined (this = window)
```

## 7. Prototypes

Chaque objet possede un prototype (autre objet) duquel il herite des proprietes.  
La chaine de prototypes permet l'heritage (hors classes).

```javascript
const parent = { a: 1 };
const enfant = Object.create(parent);
enfant.b = 2;
console.log(enfant.a); // 1 (herite)
console.log(enfant.hasOwnProperty("a")); // false
```

## 8. Fonctions flechees (arrow functions)

- Syntaxe plus courte
- Pas de `this` propre, pas d'`arguments`, pas constructeur (`new` impossible)
- Ideales pour les callbacks

```javascript
const carre = (x) => x * x;
[1, 2, 3].map(x => x * 2); // [2, 4, 6]
```

## 9. Asynchrone : Callbacks, Promises, async/await

- Callback : fonction passee en argument, executee plus tard.
- Promise : objet representant une valeur future (resolution/rejet).
- `async/await` : syntaxe plus lisible pour gerer les Promises.

```javascript
// Promise
const fetchData = () => Promise.resolve("donnees");
fetchData().then(data => console.log(data));

// async/await
async function getData() {
  const result = await fetchData();
  console.log(result);
}
```

## 10. Event Loop (boucle d'evenements)

JavaScript est mono-thread. Les operations asynchrones (`setTimeout`, Promises, I/O) sont placees dans des files (task queue, microtask queue). L'Event Loop vide d'abord les microtasks (Promises) puis les tasks (`setTimeout`, etc.).

```javascript
console.log("1");
setTimeout(() => console.log("2"), 0);
Promise.resolve().then(() => console.log("3"));
console.log("4");
// Sortie : 1, 4, 3, 2
```

## 11. Destructuration

Extraire des proprietes d'un objet ou des elements d'un tableau.

```javascript
const user = { name: "Bob", age: 30 };
const { name, age } = user;
console.log(name); // Bob

const arr = [1, 2, 3];
const [first, second] = arr; // 1, 2
```

## 12. Operateur spread (`...`) et rest

- Spread : decompose un iterable (tableau, objet).
- Rest : regroupe des arguments en tableau.

```javascript
const tab1 = [1, 2];
const tab2 = [...tab1, 3]; // [1,2,3]

function somme(...args) { return args.reduce((a, b) => a + b); }
somme(1, 2, 3); // 6
```

## 13. Modules ES6

Fichiers JavaScript isoles avec `export` / `import`.

```javascript
// math.js
export const addition = (a, b) => a + b;

// main.js
import { addition } from "./math.js";
```

## 14. Gestion d'erreurs : `try...catch...finally`

```javascript
try {
  throw new Error("Oups");
} catch (err) {
  console.log(err.message);
} finally {
  console.log("toujours execute");
}
```

## 15. Mode strict (`"use strict"`)

Elimine certaines erreurs silencieuses, interdit certaines syntaxes (ex : variables globales implicites, doublons de parametres).

```javascript
"use strict";
x = 10; // ReferenceError (x non declaree)
```

## 16. Egalite : `==` vs `===`

- `==` : egalite avec conversion de type.
- `===` : egalite stricte (type + valeur).

```javascript
0 == false;  // true
0 === false; // false
```

## 17. Short-circuit evaluation (`&&`, `||`)

```javascript
const name = user && user.name;      // si user existe, prend user.name
const port = config.port || 3000;    // valeur par defaut
```

## 18. Operateur Nullish coalescing (`??`)

Retourne l'operande droite uniquement si gauche est `null` ou `undefined` (contrairement a `||` qui reagit a falsy).

```javascript
const val = 0 ?? 42;   // 0
const val2 = 0 || 42;  // 42
```

## 19. Optional chaining (`?.`)

Accede a une propriete sans erreur si l'objet est `null` ou `undefined`.

```javascript
const user = {};
console.log(user?.address?.city); // undefined (pas d'erreur)
```

## 20. Evenements (DOM)

Gestion des interactions via `addEventListener`, propagation (capture, bubbling), delegation.

```javascript
document.getElementById("btn").addEventListener("click", (e) => {
  console.log(e.target);
});
```

---

## 21. Methodes ES6+/ES8+ essentielles (fonctionnalite, type de retour, exemple)

### 21.1 Methodes de tableaux

#### `map()`
- **Fonctionnalite** : transforme chaque element d'un tableau.
- **Type de retour** : `Array` (nouveau tableau, meme longueur).
- **Exemple :**
```javascript
const nums = [1, 2, 3];
const doubles = nums.map(n => n * 2); // [2, 4, 6]
```

#### `filter()`
- **Fonctionnalite** : garde uniquement les elements qui valident une condition.
- **Type de retour** : `Array` (longueur <= tableau d'origine).
- **Exemple :**
```javascript
const nums = [1, 2, 3, 4, 5];
const pairs = nums.filter(n => n % 2 === 0); // [2, 4]
```

#### `reduce()`
- **Fonctionnalite** : accumule les elements pour produire une seule valeur.
- **Type de retour** : `any` (nombre, objet, tableau, etc. selon l'accumulateur).
- **Exemple :**
```javascript
const nums = [10, 20, 30];
const total = nums.reduce((acc, n) => acc + n, 0); // 60
```

#### `find()`
- **Fonctionnalite** : renvoie le premier element qui correspond a la condition.
- **Type de retour** : element trouve ou `undefined`.
- **Exemple :**
```javascript
const users = [{ id: 1 }, { id: 2 }];
const u = users.find(x => x.id === 2); // { id: 2 }
```

#### `findIndex()`
- **Fonctionnalite** : renvoie l'index du premier element trouve.
- **Type de retour** : `number` (ou `-1` si non trouve).
- **Exemple :**
```javascript
const arr = ["a", "b", "c"];
const idx = arr.findIndex(x => x === "b"); // 1
```

#### `some()`
- **Fonctionnalite** : teste si au moins un element valide la condition.
- **Type de retour** : `boolean`.
- **Exemple :**
```javascript
const arr = [1, 3, 5, 6];
const hasPair = arr.some(n => n % 2 === 0); // true
```

#### `every()`
- **Fonctionnalite** : teste si tous les elements valident la condition.
- **Type de retour** : `boolean`.
- **Exemple :**
```javascript
const notes = [12, 14, 10];
const allPass = notes.every(n => n >= 10); // true
```

#### `includes()`
- **Fonctionnalite** : teste la presence d'une valeur.
- **Type de retour** : `boolean`.
- **Exemple :**
```javascript
const roles = ["admin", "editor"];
const ok = roles.includes("admin"); // true
```

#### `flat()`
- **Fonctionnalite** : aplatit un tableau imbrique.
- **Type de retour** : `Array`.
- **Exemple :**
```javascript
const nested = [1, [2, 3], [4, [5]]];
const oneLevel = nested.flat(); // [1, 2, 3, 4, [5]]
```

#### `flatMap()`
- **Fonctionnalite** : combine `map()` puis `flat(1)`.
- **Type de retour** : `Array`.
- **Exemple :**
```javascript
const words = ["hi", "ok"];
const chars = words.flatMap(w => w.split("")); // ["h", "i", "o", "k"]
```

### 21.2 Methodes d'objets (ES8+)

#### `Object.keys()`
- **Fonctionnalite** : retourne les cles propres d'un objet.
- **Type de retour** : `string[]`.
- **Exemple :**
```javascript
const user = { name: "Bob", age: 30 };
const keys = Object.keys(user); // ["name", "age"]
```

#### `Object.values()`
- **Fonctionnalite** : retourne les valeurs propres d'un objet.
- **Type de retour** : `any[]`.
- **Exemple :**
```javascript
const user = { name: "Bob", age: 30 };
const vals = Object.values(user); // ["Bob", 30]
```

#### `Object.entries()`
- **Fonctionnalite** : retourne les paires `[cle, valeur]`.
- **Type de retour** : `[string, any][]`.
- **Exemple :**
```javascript
const user = { name: "Bob", age: 30 };
const entries = Object.entries(user); // [["name","Bob"], ["age",30]]
```

#### `Object.fromEntries()` (ES10)
- **Fonctionnalite** : reconstruit un objet a partir de paires `[cle, valeur]`.
- **Type de retour** : `object`.
- **Exemple :**
```javascript
const pairs = [["name", "Bob"], ["age", 30]];
const user = Object.fromEntries(pairs); // { name: "Bob", age: 30 }
```

### 21.3 Methodes de chaines utiles

#### `startsWith()` / `endsWith()`
- **Fonctionnalite** : teste le debut/la fin d'une chaine.
- **Type de retour** : `boolean`.
- **Exemple :**
```javascript
const file = "report.pdf";
file.startsWith("rep"); // true
file.endsWith(".pdf");  // true
```

#### `includes()` (string)
- **Fonctionnalite** : teste si une sous-chaine existe.
- **Type de retour** : `boolean`.
- **Exemple :**
```javascript
"hello world".includes("world"); // true
```

#### `padStart()` / `padEnd()` (ES2017)
- **Fonctionnalite** : complete une chaine pour atteindre une longueur donnee.
- **Type de retour** : `string`.
- **Exemple :**
```javascript
"7".padStart(3, "0"); // "007"
"A".padEnd(4, ".");   // "A..."
```

#### `trim()`, `trimStart()`, `trimEnd()`
- **Fonctionnalite** : retire les espaces au debut/fin.
- **Type de retour** : `string`.
- **Exemple :**
```javascript
const raw = "  JS  ";
raw.trim(); // "JS"
```

### 21.4 Fonctions asynchrones modernes

#### `async` / `await`
- **Fonctionnalite** : ecrire du code asynchrone de maniere lisible.
- **Type de retour** : une fonction `async` retourne toujours une `Promise`.
- **Exemple :**
```javascript
const getValue = async () => 42;
getValue().then(console.log); // 42
```

#### `Promise.all()`
- **Fonctionnalite** : attend plusieurs promesses en parallele.
- **Type de retour** : `Promise<Array>`.
- **Exemple :**
```javascript
const p1 = Promise.resolve(1);
const p2 = Promise.resolve(2);
Promise.all([p1, p2]).then(console.log); // [1, 2]
```

#### `Promise.allSettled()` (ES2020)
- **Fonctionnalite** : attend toutes les promesses, qu'elles reussissent ou echouent.
- **Type de retour** : `Promise<Array<{status, value|reason}>>`.
- **Exemple :**
```javascript
Promise.allSettled([Promise.resolve("ok"), Promise.reject("err")])
  .then(console.log);
// [{ status: "fulfilled", value: "ok" }, { status: "rejected", reason: "err" }]
```
