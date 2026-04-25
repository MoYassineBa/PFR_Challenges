# Révision & quiz — Fil Rouge (C1 à C8)

Document de **synthèse**, **révision approfondie** et **quiz** pour les huit compétences du **Projet Fil Rouge** (compte rendu 2ᵉ année + grille type soutenance). Chaque section combine **définitions détaillées**, un **glossaire de termes techniques** (chaque sigle ou notion est explicité), **exemples** (commandes, code HTML/CSS/JS/SQL/PHP, scénarios métier école) et **pièges courants** pour aller au-delà du simple listing.

Les **défis notés** restent dans `javascript/`, `sql/`, `php/`. Ce fichier complète la préparation **orale** et l’**auto-évaluation**.

**Mode d’emploi :** lire *Synthèse* → *Glossaire* (termes + définitions) → *Révision* → *Exemples concrets* ; faire le *Quiz* sans regarder les *Corrigés* ; en cas d’erreur, relire l’exemple ou la ligne du glossaire correspondante.

---

## Synthèse globale — carte des compétences

| Code | Compétence | Objectif principal | Livrables / évaluation typique |
|------|------------|-------------------|--------------------------------|
| **C1** | Git | Historique, branches, conflits, PR | Dépôt GitHub, commits lisibles, workflow |
| **C2** | Maquettage | Concevoir l’interface avant le code | Maquettes (wireframes / mockups), parcours |
| **C3** | HTML / CSS | Structurer et styliser | Pages sémantiques, responsive, organisation CSS |
| **C4** | JavaScript | Données, ES moderne, formulaires (données) | Scripts ; tableaux, spread ; DOM non obligatoire à l’éval |
| **C5** | UML | Modéliser | Cas d’utilisation + classes + argumentation |
| **C6** | SQL / BD | Requêtes, jointures, agrégats, DML | Scripts SQL, schéma cohérent, intégrité |
| **C7** | POO | Classes, héritage, polymorphisme, abstraction | Code PHP OO, architecture simple |
| **C8** | Docker, déploiement, sécurité | Environnements reproductibles, socle sécu | Oral + Dockerfile / Sail ; bonnes pratiques |

**Restrictions techniques (Laravel Fil Rouge)** — ne pas utiliser : Breeze, Spatie (auth, etc.), Livewire, Laravel Voyager, Laravel Easy Panel, Datatables Yajra et équivalents. Objectif : **fondamentaux** maison plutôt que « boîtes noires ».

---

## C1 — Git

### Synthèse des concepts

**Git** est un **DVCS** (*Distributed Version Control System* : système de gestion de versions **distribué**). Chaque clone contient **l’historique complet** (tous les **commits**), pas seulement la dernière version. Un **commit** est un **instantané immuable** (*snapshot*) de l’arborescence suivie, identifié par un **hash** de commit (souvent abrégé en 7 caractères ; algorithme interne selon la version de Git). Les **branches** sont des **références mobiles** (*refs*) qui pointent vers un commit ; **fusionner** (*merge*) crée un commit qui **réconcilie** deux lignes d’historique. Le **dépôt distant** (souvent nommé **`origin`**) est une copie de référence sur un serveur (ex. GitHub) ; les **conflits de fusion** apparaissent quand deux commits modifient les **mêmes régions** d’un fichier de façon incompatible.

### Glossaire — termes techniques (C1)

| Terme | Explication |
|--------|---------------|
| **Repository (dépôt)** | Dossier de travail + métadonnées dans `.git/` : objets (commits, arbres, blobs), refs, configuration. |
| **Commit** | Enregistrement atomique : auteur, date, message, parent(s), pointeur vers un **arbre** (*tree*) représentant les fichiers à cet instant. |
| **Branch (branche)** | Référence nommée (`main`, `feature/foo`) qui avance au fil des commits ; permet le travail **parallèle** sans écraser `main`. |
| **HEAD** | Référence vers le commit « en cours » (souvent la pointe de la branche active) ; `HEAD~1` = commit parent. |
| **Staging area / Index** | Zone intermédiaire : fichiers **préparés** avant commit (`git add`) ; ce qui est **indexé** forme le prochain snapshot. |
| **Working tree (copie de travail)** | Fichiers visibles dans l’éditeur ; peuvent différer de l’index et du dernier commit. |
| **Remote** | Alias d’URL (`origin`) vers un dépôt distant ; **tracking branch** : branche locale liée à `origin/nom`. |
| **Fetch** | Télécharge commits/refs du distant **sans** modifier votre branche courante. |
| **Pull** | `fetch` + intégration (**merge** ou **rebase** selon config) dans la branche actuelle. |
| **Push** | Envoie vos commits vers le distant ; `-u` (*upstream*) mémorise la branche de suivi. |
| **Merge** | Combine deux historiques ; peut produire un **merge commit** à deux parents si les lignes ont divergé. |
| **Fast-forward** | Avancer la branche sans commit de merge quand l’historique est linéaire. |
| **Pull Request (PR)** | Demande de fusion sur forge (GitHub/GitLab) : diff, discussion, **CI**, approbation avant merge dans `main`. |
| **Conflict** | État où Git ne peut pas fusionner automatiquement : marqueurs `<<<<<<<` / `=======` / `>>>>>>>` dans le fichier. |
| **`.gitignore`** | Liste de motifs (glob) : fichiers **non suivis** intentionnellement exclus du `git add` global. |

### Révision détaillée

- **`git init`** : initialise un dépôt vide — crée le répertoire **`.git/`** (base de données des objets Git) ; aucun distant n’est configuré par défaut.
- **`git clone <url>`** : **clonage** = copie complète du graphe d’historique + **checkout** de la branche par défaut ; enregistre le **remote** `origin` pointant vers `<url>`.
- **`git status`** : compare **working tree** ↔ **index** ↔ **HEAD** ; affiche *untracked* (non suivi), *modified* (modifié non indexé), *staged* (indexé).
- **Staging (`git add`)** : copie une version du fichier dans l’**index** ; `git add -p` propose chaque **hunk** (bloc de diff) pour un commit granulaire.
- **`git commit`** : crée un objet **commit** pointant vers l’arbre indexé ; message en **impératif** décrivant l’**intention** (traçabilité, `git bisect`, revue).
- **`git switch` / `git checkout`** : change la branche active (déplace **HEAD**) ; met à jour le working tree pour correspondre au commit cible.
- **`git merge autre-branche`** : intègre l’historique de `autre-branche` dans la branche courante ; **merge commit** si besoin, sinon **fast-forward**.
- **`git fetch origin`** : met à jour les refs **`origin/*`** (ex. `origin/main`) **sans** fusion — votre `main` local reste inchangé jusqu’à merge/rebase.
- **`git pull`** : raccourci pour synchroniser : typiquement `fetch` + `merge` (ou `rebase` si `pull.rebase=true`).
- **`git push -u origin ma-branche`** : envoie `ma-branche` et configure **`upstream`** pour les `git pull`/`git push` futurs sans arguments.
- **`git stash`** (bonus) : met de côté modifications **non commitées** (working tree + optionnellement index) pour revenir à un état propre avant merge/pull.
- **`.gitignore`** : évite d’indexer **`vendor/`**, **`node_modules/`**, **`.env`**, caches IDE — un secret commité puis poussé reste dans l’**historique** même après correction (révoquer la clé).

### Exemples concrets

**Scénario Fil Rouge :** tu travailles sur `feature/absences`, ton camarade sur `main` a modifié `routes/web.php`. Après `git pull origin main` dans ta branche (ou merge de `main` dans la tienne), Git ouvre un conflit dans `web.php`.

Marqueurs typiques :

```text
<<<<<<< HEAD
Route::get('/absences', [AbsenceController::class, 'index']);
=======
Route::get('/absences', [AttendanceController::class, 'index']);
>>>>>>> main
```

Tu gardes la bonne route (ou tu fusionnes les deux si les contrôleurs coexistent), tu supprimes `<<<<<<<`, `=======`, `>>>>>>>`, puis :

```bash
git add routes/web.php
git commit -m "Merge main into feature/absences and resolve web routes conflict"
```

**Annuler le dernier commit** en gardant le travail dans l’index (pour recommiter autrement) :

```bash
git reset --soft HEAD~1
```

**Voir l’historique** avec graphe :

```bash
git log --oneline --graph --decorate -15
```

**Flux PR (schéma logique) :** branche locale → `push` → ouverture PR sur GitHub → revue + CI verte → squash merge ou merge commit → suppression de la branche distante.

### Pièges fréquents

- Commiter `.env` ou des clés API « par erreur » → **révoquer les clés** même après `git reset` si déjà poussé (l’historique reste sur le serveur).
- `git pull` sans avoir commité ses modifs locales → parfois merge accidentel ; utiliser `git stash` si besoin.
- Messages vides ou « update » : inutilisables pour le `git bisect` ou la revue.

### Quiz C1

1. Que fait `git init` ?
2. Différence entre `git add` et `git commit` ?
3. Commande pour voir l’historique compact des 8 derniers commits ?
4. Pourquoi créer une branche `feature/inscription` ?
5. Différence entre `git fetch` et `git pull` ?
6. Liste des étapes pour résoudre un conflit après un `git merge`.
7. Comment annuler le **dernier commit** tout en gardant les modifications dans l’index ?
8. Rôle d’une **pull request** sur GitHub ?
9. À quoi sert `.gitignore` ?
10. Citez une bonne pratique de message de commit.

### Corrigés quiz C1

1. Crée le dépôt Git (dossier `.git`) dans le répertoire courant.
2. `add` prépare l’index ; `commit` enregistre l’instantané dans l’historique local.
3. Ex. `git log -8 --oneline`.
4. Isoler le travail, protéger `main`, permettre la revue et le merge propre.
5. `fetch` met à jour les refs distantes sans fusionner ; `pull` récupère et intègre (souvent merge).
6. Ouvrir les fichiers en conflit, supprimer les marqueurs et choisir le code final, `git add` les fichiers corrigés, `git commit` (ou `git merge --continue`).
7. `git reset --soft HEAD~1`.
8. Proposer des changements, discussion, revue de code, CI, puis merge dans la branche principale après accord.
9. Ignorer des chemins (builds, secrets, dépendances) pour ne pas les versionner.
10. Message impératif court, contexte (quoi/pourquoi), référence issue si l’équipe le fait.

---

## C2 — Maquettage d’interface

### Synthèse des concepts

Le **maquettage** (*wireframing* / *mockup*) est une activité d’**UX** (*User Experience* : expérience utilisateur) et d’**UI** (*User Interface* : interface graphique) **en amont du code** : on traduit les **user stories** ou exigences métier en **parcours utilisateur** (*user flows*), **écrans** et **états d’interface** (succès, erreur, vide, chargement). Cela sert de **contrat de conception** entre apprenants, formateur et relecteur du Fil Rouge.

### Glossaire — termes techniques (C2)

| Terme | Explication |
|--------|-------------|
| **Wireframe** | Schéma **basse fidélité** : rectangles, traits, placeholders ; priorise **l’information architecture** (où va quoi) sans le design final. |
| **Mockup** | Rendu **haute fidélité** statique : couleurs de **charte graphique**, typo réelle, boutons « finis » ; utile pour alignement visuel et soutenance. |
| **Prototype** | Maquette **interactive** (cliquable) : simule transitions ; peut rester lo-fi (Figma) ou proche du produit. |
| **User flow / parcours** | Séquence d’écrans + décisions (si paiement échoue → écran X) ; inclut **points d’entrée** et **sorties**. |
| **WCAG** | *Web Content Accessibility Guidelines* : recommandations W3C (contraste, clavier, textes alternatifs, etc.). |
| **Contraste (AA/AAA)** | Rapport de luminance texte/fond ; **AA** est souvent le minimum légal « raisonnable » pour du texte courant. |
| **Gestalt** | Lois de perception (proximité, similarité, continuité…) utilisées en UI pour regrouper ce qui va ensemble. |
| **Grille / layout** | Structure invisible d’alignement (colonnes, gouttières) pour cohérence multi-écrans. |
| **Mobile-first** | Stratégie de conception : **contrainte mobile d’abord** puis **progressive enhancement** sur tablette/desktop. |
| **Hiérarchie visuelle** | Taille, poids, couleur, position pour indiquer ce qui est **principal** vs **secondaire** (ex. CTA primaire vs lien « Annuler »). |
| **Design tokens** | Nommage des couleurs, espacements, rayons (ex. `--space-md`) pour cohérence — optionnel au Fil Rouge mais bon signal. |

### Révision détaillée

- **Wireframe** : privilégie **l’itération rapide** ; peu ou pas de **branding** ; focus sur **zones fonctionnelles** (formulaire, liste, navigation).
- **Mockup** : fige l’**apparence** (*look & feel*) ; aide à détecter incohérences avec la charte **avant** intégration HTML/CSS.
- **Principes UI** : **contraste** (lisibilité, WCAG), **alignement** sur grille, **proximité** (étiquette proche du champ = même groupe sémantique), **hiérarchie** (titre H1, puis action principale, puis actions secondaires).
- **États d’écran** : *empty state* (liste vide), *loading* (squelette ou spinner), *error* (message + action corrective) — souvent oubliés si on ne maquette que le « happy path ».
- **Mobile-first** : évite le **rétrofit** coûteux (réduire un desktop surchargé) ; force à prioriser le contenu **above the fold** sur petit viewport.
- **Fil Rouge** : livrer un **parcours critique** argumenté (ex. inscription examen) vaut mieux que des dizaines d’écrans non reliés.

### Exemples concrets

**Parcours type « inscription aux examens » (école) :**

1. **Connexion** — champs email / mot de passe, lien « mot de passe oublié ».
2. **Tableau de bord élève** — cartes : prochains examens, absences, notes récentes.
3. **Liste des sessions d’examen** — filtres par matière, date ; bouton « S’inscrire ».
4. **Formulaire d’inscription** — choix de la salle (si applicable), validation, message de confirmation.

Sur un wireframe papier, chaque écran peut être un rectangle A6 avec des numéros (1→2→3) tracés à la main : c’est déjà une **carte de parcours** valable pour C2.

**Hiérarchie des actions :** bouton primaire plein (ex. vert) « Enregistrer », bouton secondaire contour « Annuler » — l’utilisateur sait quelle action est « attendue » par le système.

### Pièges fréquents

- Maquette trop belle trop tôt : on retarde le feedback fonctionnel.
- Oublier les **états** : erreur, chargement, liste vide (« Aucune inscription »).
- Aucune légende : le correcteur ne sait pas si un bloc est un tableau ou une carte.

### Quiz C2

1. Wireframe vs mockup : en une phrase chacun.
2. Deux principes Gestalt utiles en UI ?
3. Pourquoi hiérarchiser bouton primaire / secondaire ?
4. Que livrer au minimum pour C2 sur le Fil Rouge ?
5. Nommez un risque de maquetter « trop tard » (après tout le code).
6. Comment la maquette aide-t-elle à l’**accessibilité** (même grossièrement) ?

### Corrigés quiz C2

1. Wireframe = squelette fonctionnel ; mockup = rendu visuel plus réaliste.
2. Ex. proximité (regrouper l’associé) ; contraste (faire ressortir l’important).
3. Diriger l’utilisateur, éviter les erreurs, clarifier l’action principale.
4. Écrans clés du parcours métier + légendes / liens entre écrans si besoin.
5. Refactorings coûteux, incohérence UI, oubli de cas limites.
6. En anticipant titres, focus, ordre de tabulation, zones de texte lisibles.

---

## C3 — HTML / CSS

### Synthèse des concepts

Le **HTML** (*HyperText Markup Language*) décrit la **structure** et le **sens** du document via des **balises** (*tags*) et une hiérarchie **DOM** (*Document Object Model* : modèle en arbre du document). Le **CSS** (*Cascading Style Sheets*) applique des **déclarations** (*property: value*) via des **sélecteurs**. Le **modèle de boîte** (*box model*) définit comment **margin**, **border**, **padding** et **contenu** occupent l’espace ; la **cascade** et la **spécificité** résolvent les conflits entre feuilles de style.

### Glossaire — termes techniques (C3)

| Terme | Explication |
|--------|-------------|
| **Sémantique HTML5** | Balises à sens (`<header>`, `<nav>`, `<main>`, `<article>`, `<section>`, `<footer>`) plutôt que `<div>` générique partout — meilleur **SEO** et **accessibilité**. |
| **DOM** | Représentation arborescente du HTML ; chaque **nœud** peut être stylé ou manipulé (souvent en JS hors scope Fil Rouge strict C3). |
| **Viewport** | Zone visible du navigateur ; balise **`<meta name="viewport">`** lie largeur CSS à l’appareil (indispensable **responsive**). |
| **Box model** | Chaque élément est une boîte : **content-box** ou **border-box** (`box-sizing`) change si `width` inclut padding/border. |
| **Margin** | Espace **externe** entre boîtes (peut **collapse** entre blocs adjacents en CSS classique). |
| **Padding** | Espace **interne** entre bordure et contenu. |
| **Flexbox** | Module **CSS Flexible Box Layout** : alignement sur **un axe** (principal + transversal) avec `justify-content`, `align-items`, `gap`. |
| **Grid** | **CSS Grid Layout** : grille **bidimensionnelle** (lignes + colonnes), `fr`, `minmax`, `auto-fill` / `auto-fit`. |
| **Media query** | `@media (condition)` : applique des règles selon **largeur**, **hauteur**, **prefers-reduced-motion**, etc. |
| **Cascade** | Ordre d’application : origine → importance (`!important`) → spécificité → ordre dans le fichier. |
| **Spécificité** | Score implicite des sélecteurs (inline style > `#id` > `.class` > élément) pour départager les règles concurrentes. |
| **ARIA** | *Accessible Rich Internet Applications* : attributs `aria-*` pour complémer la sémantique quand le HTML natif ne suffit pas. |
| **`for` / `id` (label)** | Association explicite : clic sur **`<label for="x">`** cible **`<input id="x">`** — agrandit la zone cliquable et aide les lecteurs d’écran. |

### Révision détaillée

- **Structure** : une seule **`<main>`** par page ; **`<h1>`** unique pour le titre principal ; **`<nav aria-label="…">`** pour différencier plusieurs blocs de navigation.
- **Flexbox** : `display: flex` sur le conteneur ; **axe principal** (`flex-direction: row|column`) ; `justify-content` distribue sur l’axe principal, `align-items` sur l’axe transversal.
- **Grid** : `display: grid` ; `grid-template-columns` avec `repeat(auto-fill, minmax(…))` pour cartes **responsive** sans media query parfois.
- **Media queries** : breakpoints typiques (ex. `max-width: 768px`) pour passer **multi-colonnes → une colonne** ou ajuster typo.
- **Accessibilité** : **focus visible**, ordre de **tabulation** cohérent avec l’ordre visuel, **contraste** texte/fond, textes alternatifs **`alt`** sur images informatives.

### Exemples concrets

**HTML — squelette de page « liste des classes » :**

```html
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Classes — DWWM</title>
  <link rel="stylesheet" href="/css/app.css" />
</head>
<body>
  <header class="site-header">
    <a class="logo" href="/">YouCode</a>
    <nav aria-label="Principal">
      <ul>
        <li><a href="/classes">Classes</a></li>
        <li><a href="/notes">Notes</a></li>
      </ul>
    </nav>
  </header>
  <main>
    <h1>Promotions</h1>
    <article class="card">
      <h2>DWWM-24A</h2>
      <p>24 apprenants — salle Lab A</p>
      <a href="/classes/DWWM-24A">Voir le détail</a>
    </article>
  </main>
  <footer class="site-footer">© 2026</footer>
</body>
</html>
```

**CSS — grille responsive simple :**

```css
.card {
  border: 1px solid #e2e8f0;
  border-radius: 8px;
  padding: 1rem;
  margin-bottom: 1rem;
}

.layout {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
  gap: 1rem;
}

@media (max-width: 768px) {
  .layout {
    grid-template-columns: 1fr;
  }
}
```

**Flexbox — centrer une modale :**

```css
.overlay {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
}
```

### Pièges fréquents

- Oublier `<meta name="viewport">` → site « zoomé » bizarre sur mobile.
- Styliser uniquement avec des `#id` → impossible de réutiliser le même style sur deux cartes.
- `position: absolute` sans parent `relative` → l’élément se positionne par rapport au viewport, souvent de façon surprenante.

### Quiz C3

1. Trois balises sémantiques et leur rôle.
2. `display: block` vs `inline` : exemple d’usage de chaque.
3. Pourquoi lier `<label for="id">` à `<input id="id">` ?
4. Media query : une colonne sous 768px pour `.grid`.
5. Centrer un bloc en Flexbox (horizontal + vertical).
6. Rôle de `position: relative` sur le parent d’un enfant `absolute`.
7. Qu’est-ce que la **spécificité** CSS (idée générale) ?
8. Différence entre marge extérieure et **padding** ?

### Corrigés quiz C3

1. Ex. `<nav>` navigation ; `<main>` contenu principal ; `<article>` unité de contenu réutilisable.
2. Block : cartes empilées ; inline : lien dans une phrase.
3. Accessibilité (clic sur le label), zone de touche plus grande, association explicite.
4. `@media (max-width: 768px) { .grid { grid-template-columns: 1fr; } }` (ou flex équivalent).
5. `display:flex; justify-content:center; align-items:center;` (+ hauteur/min-height si besoin).
6. Définir le référentiel de positionnement pour l’enfant `absolute`.
7. Mécanisme qui décide quelle règle l’emporte quand plusieurs sélecteurs ciblent le même élément (id > classe > élément, etc., avec ordre d’apparition).
8. Marge : espace **entre** éléments ; padding : espace **à l’intérieur** de la boîte du composant.

---

## C4 — JavaScript

### Synthèse des concepts

**JavaScript** (norme **ECMAScript**, souvent **ES6+** pour les versions récentes) est un langage **dynamiquement typé** (*dynamically typed* : les types sont vérifiés à l’exécution, pas déclarés statiquement comme en TypeScript).
Les **valeurs primitives** (*number*, *string*, *boolean*, *bigint*, *symbol*, *undefined*, *null*) se comportent différemment des **objets** (*reference types* : tableaux, `{}`, instances). 

Pour le Fil Rouge C4, l’accent est sur **structures de données** (tableaux d’objets littéraux), **JSON** (*JavaScript Object Notation* : format texte d’échange), syntaxe **ES moderne** (`let`/`const`, **spread** `...`, **template literals** `` ` ``), **comparaisons strictes** (`===`). Le **DOM** (*Document Object Model*) n’est pas exigé : un formulaire peut être modélisé comme **objet plain** en entrée/sortie.

### Glossaire — termes techniques (C4)

| Terme | Explication |
|--------|-------------|
| **`let` / `const`** | **Portée de bloc** (*block scope*) : visibles entre `{ }` ; **TDZ** (*Temporal Dead Zone*) avant la ligne de déclaration. `const` interdit la **réassignation** de la liaison, pas la mutation interne d’un objet. |
| **`var`** | Ancienne portée **fonction** ou globale ; **hoisting** bizarres → à éviter en nouveau code. |
| **Référence (objet)** | Deux variables peuvent pointer vers la **même identité** d’objet ; modifier `obj.prop` se voit partout. |
| **Shallow copy** | **Copie superficielle** : nouveau conteneur, mais sous-objets partagés ; ex. `[...arr]`, `{...obj}`, `arr.slice()`. |
| **Deep clone** | Duplication récursive (hors socle Fil Rouge sauf mention) — `structuredClone` en navigateur moderne. |
| **`===` / `==`** | **Égalité stricte** : valeur + type ; `==` applique la **coercition de types** (*type coercion*) implicite (pièges : `"" == false`). |
| **`??` (nullish coalescing)** | `a ?? b` : `b` seulement si `a` est **`null` ou `undefined`** ; à la différence de l’**OR logique** (`||`), qui retient `b` pour toute valeur **falsy** (`0`, `""`, `false`, etc.). |
| **`map` / `filter` / `reduce`** | **Fonctions d’ordre supérieur** sur `Array` : pur transformation / sous-ensemble / **réduction** vers une valeur accumulée. |
| **`reduce` (accumulateur)** | Callback `(acc, item, index, arr) => …` ; deuxième argument = **valeur initiale** de l’accumulateur (souvent `{}` ou `0`). |
| **`JSON.parse` / `JSON.stringify`** | **Parse** : chaîne → valeur JS ; **stringify** : valeur → chaîne JSON (dates → string, `undefined` omis dans objets, etc.). |
| **Arrow function** | Syntaxe `() => {}` ; **lexical `this`** : hérite du `this` englobant (pas de liaison dynamique propre). |
| **`try` / `catch` / `finally`** | **Exception handling** : `catch` reçoit l’erreur ; `finally` s’exécute **toujours** après. |
| **`import` / `export`** | **Modules ES** (*ESM*) : portée par fichier, **tree-shaking** possible côté bundler. |

### Révision des concepts

- **`let` / `const`** : **bloc** `{ }` ; pas d’accès avant déclaration (**TDZ**) ; `const` fixe la liaison mais un **objet muté** reste le même référent.
- **Références objet** : `const a = {}; const b = a; b.x = 1` → `a.x === 1`.
- **Copie superficielle** : **spread** `[...t]`, `{...o}` ou `t.slice()` ; les objets imbriqués restent partagés jusqu’à copie manuelle profonde.
- **`===`** : pas de coercition ; comparer à **`null`**/`undefined` explicitement si besoin.
- **Immutabilité pratique** : préférer retourner **nouveau tableau/objet** (`map`, spread) plutôt que muter en place pour raisonner plus simplement sur les données formulaire.

### Exemples concrets

**Notes par élève — regroupement et moyenne (école) :**

```javascript
const rows = [
  { studentId: 1, subject: "JS", score: 14 },
  { studentId: 1, subject: "PHP", score: 16 },
  { studentId: 2, subject: "JS", score: 11 },
];

const byStudent = rows.reduce((acc, row) => {
  if (!acc[row.studentId]) acc[row.studentId] = { sum: 0, count: 0 };
  acc[row.studentId].sum += row.score;
  acc[row.studentId].count += 1;
  return acc;
}, {});

const averages = Object.entries(byStudent).map(([id, { sum, count }]) => ({
  studentId: Number(id),
  average: Math.round((sum / count) * 10) / 10,
}));
// [{ studentId: 1, average: 15 }, { studentId: 2, average: 11 }]
```

**Fusion de formulaire (defaults + saisie) sans muter les defaults :**

```javascript
const defaults = { fullName: "", classCode: "DWWM-24A", email: "" };
const submitted = { fullName: "  Sara  ", email: "sara@school.ma" };
const merged = { ...defaults, ...submitted };
const record = { ...merged, fullName: merged.fullName.trim() };
```

**Tri numérique sûr (éviter le piège `sort` lexicographique) :**

```javascript
const scores = [10, 2, 15, 1];
const sorted = [...scores].sort((a, b) => a - b); // copie puis tri
```

**`??` vs `||` :**

```javascript
const maxAbs = 0;
const capA = maxAbs || 30;   // 30 (car 0 est falsy)
const capB = maxAbs ?? 30;   // 0  (car 0 n'est ni null ni undefined)
```

### Méthodes & API (référence rapide)

| API / syntaxe | Terme technique | Explication |
|---------------|-----------------|-------------|
| `Array.prototype.map` | *map* (transformation 1‑pour‑1) | Retourne un **nouveau** tableau de même longueur en appliquant une fonction à chaque élément. |
| `Array.prototype.filter` | *filter* (sélection) | Sous-ensemble des éléments pour lesquels le prédicat retourne une valeur **truthy**. |
| `Array.prototype.flatMap` | *flatMap* | `map` puis **aplatissement** d’un niveau : utile quand chaque élément produit zéro, une ou plusieurs valeurs. |
| `Array.prototype.slice` | *shallow copy* / tranche | Extrait une portion **sans muter** le tableau d’origine ; sans args, copie superficielle. |
| `Array.prototype.reduce` | *fold* / réduction | Réduit le tableau à **une** valeur via accumulateur ; 2ᵉ argument = **valeur initiale** (souvent obligatoire si le tableau peut être vide). |
| `Array.prototype.some` / `every` | *existential* / *universal* quantifier | `some` : au moins un vrai ; `every` : tous vrais — **court-circuitent** (*short-circuit*) dès que le résultat est connu. |
| `Array.prototype.find` | *linear search* | Premier élément matchant ou **`undefined`**. |
| `Object.keys` / `values` / `entries` | *reflection* légère sur objet | Itérer sur clés, valeurs ou paires `[clé, valeur]` (clés propres **énumérables**). |
| `…` (spread) | *object / array spread* | **Copie énumérable** des propriétés ou éléments dans un littéral ; voir glossaire *shallow copy*. |
| `JSON.parse` / `stringify` | *serialization* | Conversion **texte JSON** ↔ valeurs JS (dates → chaînes au `stringify`, etc.). |
| `try` / `catch` / `finally` | *exception handling* | `throw` lève une **exception** ; `catch` la capture ; `finally` toujours exécuté. |
| `import` / `export` | *ESM* (*ECMAScript modules*) | Portée statique par fichier ; permet le **tree-shaking** côté bundler. |

### Pièges fréquents

- `arr.sort()` sans comparateur sur des nombres → `[1,11,2].sort()` donne `[1,11,2]` en **ordre Unicode**.
- Oublier que `filter`/`map` ne modifient pas l’original : bien **réassigner** ou chaîner le résultat.
- `JSON.parse` sur une entrée utilisateur sans `try/catch` → crash si JSON invalide.

### Quiz C4

1. Différence entre **`let`** et **`const`** pour une variable qui référence un objet ?
2. Que fait **`===`** que **`==`** ne garantit pas ?
3. Écrire une expression qui **clone** un tableau `t` en surface.
4. **`filter`** vs **`map`** : en une phrase chacune.
5. Rôle du **deuxième argument** de `reduce` ?
6. Pourquoi **`arr.sort()`** seul peut être piégeux sur un tableau de nombres ?
7. Différence **`||`** et **`??`** pour `const x = a ?? b` vs `a || b` quand `a === 0` ?
8. À quoi sert **`JSON.stringify`** ?
9. **`try…catch…finally`** : que fait `finally` ?
10. Une **fonction fléchée** hérite de quel **`this`** ?
11. Que retourne **`[1,2,3].some(n => n > 2)`** ?
12. Comment fusionner `defaults` et `submitted` en un objet **sans** muter `defaults` ?
13. Pourquoi le Fil Rouge insiste sur le **spread** et les tableaux ?
14. Citez une méthode pour savoir si **au moins un** élément satisfait une condition.

### Corrigés quiz C4

1. `const` interdit de réassigner la variable à une **nouvelle** référence ; le contenu de l’objet peut toujours être modifié sauf immutabilité explicite (`Object.freeze`, rare au socle).
2. `===` exige le **même type** et la même valeur ; `==` applique la coercition.
3. Ex. `[...t]` ou `t.slice()`.
4. `filter` : garder un sous-ensemble selon un prédicat ; `map` : transformer chaque élément en une autre valeur (même longueur en général).
5. **Valeur initiale** de l’accumulateur (ex. `0` pour une somme).
6. `sort` convertit en chaîne par défaut → ordre lexicographique ; utiliser `(a,b) => a-b` pour des nombres, et copier le tableau avant si on veut éviter la mutation.
7. `??` garde `0` ; `||` remplace `0` par `b` car `0` est falsy.
8. Sérialiser une valeur JavaScript (souvent objet) en **chaîne JSON**.
9. `finally` s’exécute **toujours** après `try`/`catch` (utile pour libérer une ressource, log, etc.).
10. Du **contexte lexical** englobant (pas de `this` dynamique propre à la fléchée).
11. `true` (car `3 > 2`).
12. `const merged = { ...defaults, ...submitted };`
13. Copier/fusionner des données sans effets de bord, manipuler des **formulaires** comme objets — attendu explicite dans la grille Fil Rouge C4.
14. **`some`** (ou `find` pour le premier match).

---

## C5 — UML (cas d’utilisation & diagramme de classes)

### Synthèse des concepts

**UML** (*Unified Modeling Language* : langage de modélisation unifié) est une notation **standardisée** (OMG) pour décrire **l’architecture logicielle** sous plusieurs vues. 

Au Fil Rouge, les vues **cas d’utilisation** (*use case diagram*) et **classes** (*class diagram*) structurent le **périmètre fonctionnel** et le **modèle de domaine** (*domain model* : concepts métier et leurs liens). Un diagramme utile est **lisible**, **cohérent** avec le code (noms de classes proches du code PHP/SQL) et **argumenté** à l’oral.

### Glossaire — termes techniques (C5)

| Terme | Explication |
|--------|-------------|
| **Acteur** | Rôle externe (humain, organisation, autre système) qui **interagit** avec le système ; représenté par un **stick figure**. |
| **Cas d’utilisation (use case)** | Unité fonctionnelle **du point de vue utilisateur** : objectif métier (ex. « S’inscrire à un examen »), pas une méthode technique (`SELECT`). |
| **Frontière du système** | Rectangle englobant les cas : sépare **ce qui est dans le SI** de l’extérieur. |
| **`<<stereotype>>`** | Mot-clé UML entre guillemets pour qualifier un élément (`<<include>>`, `<<extend>>`, `<<entity>>`…). |
| **`<<include>>`** | Relation de **factorisation** : le cas de base **incorpore toujours** le comportement du cas inclus (dépendance obligatoire). |
| **`<<extend>>`** | **Extension point** : branche **conditionnelle** ; le cas étendu s’exécute **si** une condition métier est vraie. |
| **Scénario principal / alternatives** | Texte structuré : **main success scenario** + **extensions** (erreurs, variantes) — complément indispensable au seul diagramme. |
| **Classe** | Type avec **attributs** (état) et **opérations** (comportement) ; en UML 3 compartiments (nom, attributs, méthodes). |
| **Association** | Lien structurel entre classes ; peut porter **nom de rôle** et **multiplicité** aux extrémités. |
| **Multiplicité** | Contrainte cardinale : `1`, `0..1` (zéro ou un), `1..*` (un ou plus), `*` (zéro ou plus). |
| **Agrégation** | Relation **part-of** faible (losange **vide** côté « tout ») : la partie peut exister sans le composite. |
| **Composition** | Relation **part-of** forte (losange **plein**) : cycle de vie des parties souvent lié au composite. |
| **Généralisation** | Flèche triangle : **sous-classe** *est-une* **super-classe** ; héritage de structure et comportement. |
| **Réalisation** | Ligne en pointillés + triangle creux : classe **implémente** une **interface** (contrat). |
| **Classe d’association** | Classe portée sur une association **N–N** pour y stocker attributs (ex. date d’inscription sur `Enrollment`). |

### Révision détaillée

- **Diagramme de cas d’utilisation** : **frontière**, **acteurs**, **cas** en ovales ; un cas = **bénéfice utilisateur** mesurable, pas un **CRUD** brut sans intention.
- **`<<include>>`** : ordre d’exécution **toujours** inclus (ex. tout paiement *include* « Authentifier l’utilisateur » si c’est la règle métier).
- **`<<extend>>`** : option activée par **condition** (ex. bourse) ; documenter le **point d’extension** en texte si demandé.
- **Généralisation d’acteurs** : factorise les cas communs (`User` parent de `Student` / `Teacher`) sans multiplier les flèches identiques.
- **Diagramme de classes** : **visibilité** `+` *public*, `-` *private*, `#` *protected*, `~` *package* ; types après `:` pour attributs et retours.
- **Multiplicités** : doivent **coller au schéma SQL** (1–N via FK ; N–N via table de liaison ou classe d’association).
- **Relations** : **association** (ligne simple) ; **agrégation/composition** (losange) ; **généralisation** (héritage) ; **réalisation** (interface).

### Exemples concrets

**Cas d’utilisation (texte structuré) — « S’inscrire à un examen » :**

- **Acteur primaire** : `Étudiant`.
- **Acteur secondaire** : `Service de paiement` (si paiement en ligne).
- **Préconditions** : étudiant authentifié, session d’examen ouverte.
- **Scénario principal** : choisir la session → confirmer → recevoir accusé de réception.
- **Extensions** : places insuffisantes, session fermée.

**Diagramme de classes (description textuelle) :**

- `Student` (1) —— (0..*) `Enrollment` : un étudiant a zéro ou plusieurs inscriptions.
- `Course` (1) —— (0..*) `Enrollment` : un cours regroupe des inscriptions.
- Attributs sur `Enrollment` : `enrolledAt: DateTime`, `status: enum`.

Cela correspond en SQL à une table de **liaison** `enrollments(student_id, course_id, …)`.

### Pièges fréquents

- Confondre **include** et **extend** : `include` = toujours exécuté dans le flux de base ; `extend` = branche optionnelle sous condition.
- Multiplicités incohérentes (ex. tout en `1..1` « pour simplifier » alors que le métier est N-N).

### Quiz C5

1. À quoi sert un diagramme de cas d’utilisation ?
2. Acteur primaire vs secondaire ?
3. Différence **include** et **extend** en use case ?
4. Deux relations possibles dans un diagramme de **classes**.
5. Différence association vs composition (intuition).
6. Comment représenter un many-to-many entre `Student` et `Course` ?
7. Pourquoi modéliser avant de coder ?
8. Que montre une **généralisation** entre acteurs ?

### Corrigés quiz C5

1. Délimiter le système, lister les fonctions du point de vue utilisateur, communiquer avec les parties prenantes.
2. Primaire déclenche le besoin ; secondaire fournit un service sans être à l’origine du scénario principal.
3. `include` : le cas de base inclut toujours un autre cas ; `extend` : cas additionnel sous condition.
4. Ex. association simple, héritage, réalisation d’interface, agrégation/composition.
5. Association : lien ; composition : lien fort souvent avec destruction des parties avec le tout (selon modèle).
6. Classe d’association `Enrollment` (ou équivalent) avec clés vers les deux entités.
7. Réduire les risques, aligner l’équipe, faciliter la maintenance et les revues.
8. Un acteur spécialisé hérite des interactions de l’acteur général (ex. `Admin` spécialise `User`).

---

## C6 — SQL & bases de données

### Synthèse des concepts

**SQL** (*Structured Query Language*) interroge et modifie des **relations** (*relational model* de Codd) matérialisées en **tables** (ensembles de **lignes** / **tuples** et **colonnes** / **attributs**). 

Le **SGBDR** (*Système de Gestion de Base de Données Relationnel*, ex. MySQL, MariaDB, PostgreSQL) applique le **schéma** via le **DDL** (*Data Definition Language* : `CREATE`, `ALTER`, `DROP`), modifie les données via le **DML** (*Data Manipulation Language* : `INSERT`, `UPDATE`, `DELETE`) et lit via le **DQL** (souvent rangé avec DML — surtout `SELECT`).
 
Les **jointures** (*joins*) combinent des tables selon des **prédicats** ; les **fonctions d’agrégation** (`COUNT`, `SUM`, `AVG`, …) avec **`GROUP BY`** produisent des **résumés statistiques**.

### Glossaire — termes techniques (C6)

| Terme | Explication |
|--------|-------------|
| **Table / relation** | Structure bidimensionnelle nommée ; chaque ligne = **tuple** (ou **enregistrement**). |
| **Schéma** | Namespace logique des objets (tables, vues, contraintes) — « le plan » de la base. |
| **PK (Primary Key)** | Contrainte **UNIQUE** + **NOT NULL** identifiant une ligne ; référence cible des **FK**. |
| **FK (Foreign Key)** | Colonne(s) référençant une PK ; garantit l’**intégrité référentielle** ; actions **`ON DELETE` / `ON UPDATE`** (`CASCADE`, `SET NULL`, `RESTRICT`…). |
| **`NULL`** | Absence de valeur inconnue ; logique à **trois valeurs** (*three-valued logic* : vrai / faux / inconnu) : `WHERE x = NULL` est inconnu, donc exclu — utiliser **`IS NULL`**. |
| **Cardinalité** | Nombre d’instances liées : **1–1**, **1–N**, **N–N** (souvent résolu par **table de liaison** / **pivot**). |
| **Normalisation** | Formes normales (1NF, 2NF, 3NF…) pour réduire **redondance** et **anomalies de mise à jour** ; au Fil Rouge, rester **lisible** avant « théorie pure ». |
| **`INNER JOIN`** | Seules les lignes avec **match** des deux côtés du prédicat de jointure. |
| **`LEFT [OUTER] JOIN`** | Toutes les lignes de la table **gauche** + colonnes droite à **`NULL`** si pas de correspondance. |
| **`WHERE` / `HAVING`** | `WHERE` filtre **avant** agrégation ; `HAVING` filtre **après** `GROUP BY` sur expressions agrégées ou groupées. |
| **CTE (`WITH`)** | *Common Table Expression* : sous-requête **nommée** lisible, réutilisable dans le même `SELECT`. |
| **Transaction** | Unité **ACID** : **A**tomicité (`COMMIT`/`ROLLBACK`), **C**ohérence (contraintes), **I**solation (niveaux *read committed*, etc.), **D**urabilité (persistance après commit). |
| **Index (B-Tree, etc.)** | Structure accélérant recherche/jointure ; pénalise écritures et espace disque. |
| **`COALESCE(a,b,…)`** | Première valeur **non NULL** ; utile pour valeurs par défaut en `SELECT`. |

### Révision des concepts

- **Table** : colonnes typées (`INT`, `VARCHAR`, `DECIMAL`, `DATETIME`, `ENUM`…) ; **schéma** = ensemble cohérent de tables + contraintes.
- **PK** : souvent surrogate key **`AUTO_INCREMENT`** ou **UUID** ; doit rester **stable** pour les FK.
- **FK** : vérifie qu’une `student_id` existe dans `students` ; **`ON DELETE CASCADE`** propage suppression ; **`SET NULL`** si la relation est optionnelle.
- **`NULL`** : `AVG(col)` ignore en général les `NULL` pour le numérateur ; `COUNT(*)` compte les lignes, `COUNT(col)` les non-`NULL`.
- **Cardinalités** : **N–N** → table `enrollments` avec **PK composée** ou **surrogate** + **UNIQUE(student_id, course_id)**.
- **Normalisation** : éviter « nom du prof répété dans chaque ligne de note » si le prof change de nom ; extraire entité `teachers`.
- **`WHERE` vs `HAVING`** : `WHERE g.score >= 10` avant groupe ; `HAVING COUNT(*) > 5` après `GROUP BY class_id`.
- **Transaction** : script de migration ou paiement = tout réussit ou tout est annulé (**rollback**).
- **Index** : créer sur colonnes très filtrées/jointes ; surveiller **EXPLAIN** (hors scope débutant mais bon mot-clé oral).

### Exemples concrets

**Schéma minimal école :**

```sql
CREATE TABLE students (
  id INT PRIMARY KEY AUTO_INCREMENT,
  full_name VARCHAR(120) NOT NULL,
  email VARCHAR(120) NOT NULL
);

CREATE TABLE grades (
  id INT PRIMARY KEY AUTO_INCREMENT,
  student_id INT NOT NULL,
  subject_code VARCHAR(16) NOT NULL,
  score DECIMAL(4,2) NOT NULL,
  FOREIGN KEY (student_id) REFERENCES students(id)
);
```

**Moyenne par matière avec `GROUP BY` :**

```sql
SELECT subject_code, AVG(score) AS avg_score, COUNT(*) AS n
FROM grades
GROUP BY subject_code
ORDER BY subject_code;
```

**Élèves sans aucune note (LEFT JOIN + NULL) :**

```sql
SELECT s.id, s.full_name
FROM students s
LEFT JOIN grades g ON g.student_id = s.id
WHERE g.id IS NULL;
```

**Mauvais / bon test sur NULL :**

```sql
-- MAUVAIS (ne matche jamais "NULL" en SQL standard pour "email inconnu")
-- SELECT * FROM students WHERE email = NULL;

-- BON
SELECT * FROM students WHERE email IS NULL;
```

**CTE pour lisibilité — moyenne par classe si les notes portent `class_code` :**

```sql
WITH per_student AS (
  SELECT student_id, AVG(score) AS avg_s
  FROM grades
  GROUP BY student_id
)
SELECT student_id, avg_s
FROM per_student
WHERE avg_s >= 10;
```

### Méthodes & clauses SQL (référence rapide)

| Syntaxe | Terme / notion | Explication |
|----------|----------------|-------------|
| `SELECT … FROM` | *projection* / *restriction* | `SELECT` choisit les **colonnes** (*projection*) ; `FROM` indique la(s) table(s) source. |
| `WHERE` | *prédicat* prédicatif | Filtre les **lignes** avant regroupement ; évalue à vrai/faux/inconnu (avec `NULL`). |
| `IN`, `BETWEEN`, `LIKE` | *prédicats* composés | `IN` : appartenance à un ensemble ; `BETWEEN` : intervalle fermé ; `LIKE` : motif avec `%` et `_`. |
| `INNER JOIN` | *theta-join* équijointure usuelle | Produit seulement les combinaisons où la condition de jointure est vraie (**intersection** des mondes). |
| `LEFT [OUTER] JOIN` | *outer join* | Garde toutes les lignes **gauche** ; côté droit à `NULL` si pas de match (**anti-join** possible avec `WHERE droite.id IS NULL`). |
| `GROUP BY` | *partitionnement* | Regroupe les lignes identiques sur les colonnes listées ; prépare les **agrégats**. |
| `HAVING` | *filtre post-agrégation* | Comme `WHERE` mais **après** `GROUP BY` ; peut utiliser `COUNT(*)`, `AVG`, etc. |
| `COUNT(*)`, `COUNT(col)` | *agrégat* | `*` compte les lignes du groupe ; `COUNT(col)` compte les **non-NULL** dans `col`. |
| `INSERT`, `UPDATE`, `DELETE` | *DML* | Modifient les **données** sans changer le schéma (contrairement au *DDL*). |
| `WITH … AS` | *CTE* (*subquery factoring*) | Nomme une sous-requête pour clarté ; peut être **récursive** (`WITH RECURSIVE` selon SGBD). |

### Pièges fréquents

- `WHERE col = NULL` → utiliser `IS NULL`.
- Oublier que `AVG` ignore en général les `NULL` dans la colonne.
- `DELETE` / `UPDATE` sans `WHERE` en production → catastrophe.

### Quiz C6

1. **`INNER JOIN`** vs **`LEFT JOIN`** : exemple avec élèves et inscriptions.
2. Requête pour **compter** les notes **par** `student_id`.
3. **`WHERE`** vs **`HAVING`** : quand utiliser chacun avec `GROUP BY` ?
4. Rôle d’une **clé primaire** dans une table `students`.
5. **`DELETE FROM t WHERE …`** vs **`TRUNCATE TABLE t`** : risque principal de `TRUNCATE` ?
6. Moyenne des `score` **par** `class_code` ?
7. À quoi sert une **clé étrangère** `enrollments.student_id → students.id` ?
8. **`INSERT`** : différence entre insérer **une** ligne et insérer le résultat d’un **`SELECT`** ?
9. Que fait **`SELECT COUNT(*) FROM grades WHERE score >= 10`** ?
10. **`COALESCE(email, 'inconnu@school.ma')`** : comportement si `email` est `NULL` ?
11. Intérêt d’une **CTE** `WITH` pour un correcteur ?
12. Pourquoi **`WHERE email = NULL`** est une erreur classique ?
13. **`AVG(score)`** : les lignes avec `score` `NULL` sont-elles comptées dans la moyenne (comportement SQL habituel) ?
14. Pourquoi le Fil Rouge demande des requêtes sur **peu de tables** à la fois ?

### Corrigés quiz C6

1. Inner : seulement les élèves **ayant** une ligne d’inscription ; Left : **tous** les élèves, avec colonnes inscription à `NULL` s’il n’y a pas de ligne.
2. `SELECT student_id, COUNT(*) AS nb FROM grades GROUP BY student_id;`
3. `WHERE` filtre les lignes **sources** avant regroupement ; `HAVING` filtre les **groupes** après agrégats (ex. classes avec plus de 10 notes).
4. Unicité d’un étudiant dans la table ; référence stable pour les FK des autres tables.
5. `TRUNCATE` vide souvent **toute** la table sans clause ligne par ligne ; perte de données massive, effets transactionnels différents selon SGBD.
6. `SELECT class_code, AVG(score) FROM grades GROUP BY class_code;`
7. Interdire une inscription vers un `student_id` qui n’existe pas ; garder la cohérence référentielle.
8. `VALUES` (ou liste) pour des constantes ; `INSERT … SELECT` pour copier ou transformer des lignes existantes.
9. Compte le nombre de lignes de `grades` avec note ≥ 10.
10. Retourne la chaîne de secours si `email` est `NULL`, sinon `email`.
11. Lisibilité, réutilisation d’un bloc, parfois récursivité ; facilite les requêtes multi-étapes notables au Fil Rouge.
12. En SQL, `NULL` n’est pas égal à lui-même au sens de `=` ; utiliser `IS NULL`.
13. En général **non** : `AVG` ignore les `NULL` pour le calcul (le dénominateur est le nombre de valeurs non nulles).
14. Évaluer la **compréhension des jointures** et la lecture de requêtes **réalistes**, pas une requête de 15 tables.

---

## C7 — Programmation orientée objet (POO)

### Synthèse des concepts

La **POO** (*Object-Oriented Programming*) modèle le logiciel en **objets** : état (**attributs** / **propriétés**) + comportement (**méthodes**), instanciés depuis des **classes** (*blueprint*). Les piliers classiques sont **encapsulation** (*information hiding*), **héritage** (*inheritance*), **polymorphisme** (*subtype polymorphism*) et **abstraction** (*abstraction barriers*). En PHP Fil Rouge, cela se traduit par des types (`interface`, `abstract class`, `final class`), **visibilités**, **`namespace`** et parfois **`enum`** pour des états nommés.

### Glossaire — termes techniques (C7)

| Terme | Explication |
|--------|-------------|
| **Classe** | Déclaration de type : propriétés + méthodes ; non instanciée tant qu’on n’appelle pas **`new`**. |
| **Objet / instance** | Valeur concrète en mémoire ; identité propre (`===` compare identité pour objets). |
| **Encapsulation** | Masquer l’**implémentation interne** ; exposer une **API** minimale (`public`) pour préserver les **invariants** (règles toujours vraies, ex. note 0–20). |
| **`private` / `protected` / `public`** | Visibilité : **private** = classe seule ; **protected** = classe + sous-classes ; **public** = tout appelant. |
| **Constructeur (`__construct`)** | Hook d’**initialisation** ; en PHP 8+ **constructor property promotion** déclare et assigne les propriétés en paramètres. |
| **Héritage (`extends`)** | Relation **est-un** : la sous-classe **spécialise** la super-classe ; **surcharge** (*override*) des méthodes. |
| **Composition** | Relation **a-un** / **utilise** : l’objet contient une référence vers un service (souvent injecté) plutôt que d’hériter de lui. |
| **Interface (`implements`)** | Contrat : signatures de méthodes **sans** implémentation (PHP 8+ : **méthodes par défaut** limitées) ; une classe peut implémenter **plusieurs** interfaces. |
| **Classe abstraite** | Classe non instanciable directement ; peut contenir code partagé + **`abstract`** méthodes à implémenter. |
| **Polymorphisme** | Appeler une méthode via un **type parent** ou **interface** ; le **dispatch** choisit l’implémentation concrète à l’exécution (**late binding**). |
| **LSP (Liskov)** | *Liskov Substitution Principle* : une sous-classe doit pouvoir **remplacer** le parent sans casser les attentes des clients. |
| **`static`** | Membre lié à la **classe**, pas à une instance ; pas de **`$this`**. |
| **`final` (classe / méthode)** | Interdit **héritage** de la classe ou **override** de la méthode. |
| **`enum` (PHP 8.1+)** | Type énuméré : ensemble **fermé** de constantes nommées ; **backed enum** porte une valeur scalaire (`string`/`int`). |
| **Namespace** | Préfixe de nom pour éviter **collisions** (`App\Domain\Student`) ; correspond souvent à l’**arborescence** PSR-4. |

### Révision des concepts

- **Classe vs objet** : la classe est le **moule** ; l’objet est le **produit** (`$g = new Grade(...)`).
- **Encapsulation** : `private float $score` + accesseurs / comportements `isPassing()` plutôt que `$grade->score = 999`.
- **Constructeur** : valide les paramètres (`InvalidArgumentException`) pour **jamais** créer un objet dans un état illégal.
- **Héritage** : utile pour **spécialiser** un type existant ; danger : hiérarchies profondes, violation **LSP** si la sous-classe vide une méthode parent.
- **Composition** : `ReportGenerator` reçoit un **`GradeRepositoryInterface`** — remplaçable par un **fake** en test.
- **Interface** : plusieurs implémentations (`EmailNotifier`, `SmsNotifier`) pour un même contrat `Notifier`.
- **Classe abstraite** : quand plusieurs sous-classes partagent du **code** (`renderHeader()`) mais pas d’instanciation seule.
- **Polymorphisme** : `function notify(Notifiable $n)` accepte toute implémentation de `Notifiable`.
- **Fil Rouge** : **SRP** (*Single Responsibility*) pratique — une classe, une raison de changer ; limiter **boucles imbriquées** pour la **complexité cyclomatique**.

### Exemples concrets

**Classe simple avec invariant (note 0–20) :**

```php
<?php
declare(strict_types=1);

final class Grade
{
    public function __construct(
        private int $studentId,
        private string $subjectCode,
        private float $score
    ) {
        if ($score < 0 || $score > 20) {
            throw new InvalidArgumentException('Score hors plage 0–20');
        }
    }

    public function isPassing(float $threshold = 10.0): bool
    {
        return $this->score >= $threshold;
    }

    public function getScore(): float
    {
        return $this->score;
    }
}
```

**Interface + deux implémentations (polymorphisme) :**

```php
interface Notifiable
{
    public function channel(): string;
}

final class StudentNotifiable implements Notifiable
{
    public function __construct(private string $email) {}

    public function channel(): string
    {
        return 'email:' . $this->email;
    }
}

final class SlackNotifiable implements Notifiable
{
    public function __construct(private string $webhookUrl) {}

    public function channel(): string
    {
        return 'slack:' . $this->webhookUrl;
    }
}

function notify(Notifiable $target, string $message): void
{
    // envoi fictif : même fonction, types concrets différents
    echo $target->channel() . ' => ' . $message;
}
```

**Tri d’un tableau d’objets par nom :**

```php
usort($students, static function (Student $a, Student $b): int {
    return $a->getLastName() <=> $b->getLastName();
});
```

**Enum PHP 8.1+ pour statut d’inscription :**

```php
enum EnrollmentStatus: string
{
    case Active = 'active';
    case Withdrawn = 'withdrawn';

    public function isBillable(): bool
    {
        return $this === self::Active;
    }
}
```

### Méthodes & éléments de langage PHP (référence rapide)

| Syntaxe | Terme technique | Explication |
|---------|-----------------|-------------|
| `class` | *class declaration* | Définit un type référencé par `new` ; peut implémenter des interfaces et étendre **une** classe. |
| `final class` | *sealed inheritance* | Interdit toute sous-classe : fige la hiérarchie pour **sécurité de conception** ou perfs. |
| `private` / `protected` / `public` | *visibility modifiers* | Contrôlent l’**encapsulation** : qui peut lire/écrire la propriété ou appeler la méthode. |
| `extends` | *inheritance* (héritage simple) | Relation **est-un** ; la sous-classe hérite des membres visibles et peut **override** (`#[Override]` en PHP 8.3+). |
| `implements` | *interface implementation* | Satisfait le **contrat** d’une ou plusieurs interfaces ; la classe fournit le corps des méthodes. |
| `abstract class` / `abstract function` | *partial abstraction* | Classe non instanciable seule ; force les sous-classes à implémenter les méthodes **abstraites**. |
| `static` | *class-level member* | Appelable avec `Class::method()` ; pas d’instance → **pas de `$this`**. |
| `enum` / `enum X: string` | *algebraic sum type* (simplifié) | Ensemble fermé de cas ; **backed enum** stocke une valeur scalaire pour BDD / JSON. |
| `<=>` | *spaceship operator* | Comparateur à trois états : `< 0`, `0`, `> 0` — idéal pour `usort` / `uksort`. |
| `declare(strict_types=1);` | *strict typing* | Les scalaires passés aux fonctions typées doivent **correspondre exactement** au type (plus de coercitions silencieuses `int` depuis `"5"`). |

### Pièges fréquents

- Exposer tous les champs en `public` → impossible de garantir les invariants.
- Chaînes magiques `'active'`, `'pending'` partout → préférer **`enum`** ou constantes.
- Héritage pour « réutiliser un helper » → souvent un **service** injecté en composition est plus clair.

### Quiz C7

1. Différence entre **classe** et **objet** ?
2. Pourquoi mettre les attributs en **`private`** ?
3. **`extends`** vs **`implements`** en PHP ?
4. Quand choisir une **interface** plutôt qu’une **classe abstraite** ?
5. Définir le **polymorphisme** avec `PaymentMethod` et `CashPayment` / `CardPayment`.
6. Rôle du **`__construct`** (ou promotion de propriétés) ?
7. **`static`** : peut-on utiliser `$this` dans une méthode statique ?
8. **`final` sur une classe** : effet ?
9. Comment trier un tableau d’objets **`Student`** par **`getLastName()`** sans boucle `for` explicite si on utilise `usort` ?
10. Qu’est-ce qu’une **violation du principe de substitution de Liskov** (idée simple) ?
11. **Composition** : donner un exemple dans un système scolaire.
12. Pourquoi le Fil Rouge limite les **boucles imbriquées** dans la logique métier ?
13. **`enum` backed** : intérêt pour `EnrollmentStatus` ?
14. Lien **diagramme de classes** (C5) et packages **`namespace`** (C7) ?

### Corrigés quiz C7

1. Classe = définition ; objet = instance concrète créée avec `new`.
2. Contrôler les accès, garantir les invariants, pouvoir changer l’implémentation interne sans casser le client.
3. `extends` = héritage d’**une** classe parente ; `implements` = respect d’**une ou plusieurs** interfaces.
4. Interface quand plusieurs types sans ascendant commun doivent partager un contrat ; classe abstraite quand il y a déjà du code commun à factoriser.
5. Une fonction accepte `PaymentMethod` et appelle `pay()` sans connaître l’implémentation concrète.
6. Mettre l’objet dans un état valide dès la création ; property promotion évite le boilerplate des affectations.
7. Non : pas d’instance, donc pas de `$this`.
8. Empêche d’hériter de cette classe (ou de surcharger la méthode) — fige la conception.
9. `usort($students, fn($a, $b) => $a->getLastName() <=> $b->getLastName());` — le comparateur remplace une boucle de tri manuelle.
10. Une sous-classe qui casse les attentes du parent (ex. méthode qui ne fait plus rien ou lance une erreur là où le parent garantissait un comportement).
11. Ex. `ReportCard` **compose** un `GradeRepository` plutôt que d’hériter de lui — « a-un » service.
12. Limiter la complexité cyclomatique, faciliter les tests et la relecture en soutenance.
13. États exhaustifs + comparaisons sûres + pas de chaînes magiques dans tout le code.
14. Les classes du diagramme se mappent souvent vers des classes PHP dans des **namespaces** qui reflètent les couches (Domain, Infra, etc.).

---

## C8 — Docker, déploiement & sécurité

### Synthèse des concepts

**Docker** est une plateforme de **conteneurisation** : empaqueter une application et ses dépendances dans une **image OCI** (*Open Container Initiative*) exécutable de façon **reproductible**. Un **conteneur** est un processus (ou groupe) isolé par des fonctionnalités Linux (**namespaces** pour vues PID/réseau, **cgroups** pour quotas CPU/RAM) partageant le **noyau** de l’hôte — contrairement à une **VM** (*Virtual Machine*) qui exécute un OS invité complet via un **hyperviseur**. Le **déploiement** combine image, **registry** (Docker Hub, GHCR), **orchestration** (Compose en dev, Kubernetes en prod avancée) et **sécurité** (secrets, **least privilege**, surface d’attaque).

### Glossaire — termes techniques (C8)

| Terme | Explication |
|--------|-------------|
| **Image** | Artefact immuable en **couches** (*layers*) empilées (UFS/overlay) ; construite par **`docker build`** à partir d’un **Dockerfile**. |
| **Conteneur** | Instance **runnable** d’une image : processus + **couche writable** éphémère par défaut. |
| **Dockerfile** | Fichier déclaratif : instructions `FROM`, `RUN`, `COPY`, `ENV`, `EXPOSE`, `CMD` / `ENTRYPOINT`… |
| **`FROM`** | Image de base (ex. `php:8.2-cli`) — point de départ et **cache** des couches suivantes. |
| **`RUN`** | Exécute une commande **pendant le build** (installe paquets, compile). |
| **`COPY` / `ADD`** | Copie fichiers contexte → image (`ADD` = extras comme URLs — souvent évité pour prévisibilité). |
| **`CMD` vs `ENTRYPOINT`** | `ENTRYPOINT` = binaire fixe ; `CMD` = **arguments par défaut** (souvent surchargés au `docker run`). |
| **`EXPOSE`** | **Documentation** du port d’écoute interne ; ne publie pas seul — **`docker run -p hôte:conteneur`** mappe les ports. |
| **Volume** | Stockage **persistant** ou partagé hôte ↔ conteneur (`-v`, section `volumes:` en Compose). |
| **Docker Compose** | Fichier **`docker-compose.yml`** : définit **services**, **réseaux** (`networks:`), **variables** (`environment:`), **dépendances** (`depends_on`). |
| **Laravel Sail** | Enveloppe **Makefile** + Compose pour dev Laravel (PHP, MySQL, Mailpit…) sans écrire tout le YAML à la main. |
| **Registry** | Serveur stockant images (`docker push` / `docker pull`). |
| **Secret** | Donnée sensible (clé API, `APP_KEY`, mot de passe DB) — injectée au **runtime** (`-e`, fichiers secrets orchestrateur), **pas** figée dans l’image publique. |
| **Least privilege** | Faire tourner le processus applicatif sous un **utilisateur non-root** (`USER www-data`) pour limiter l’impact d’une compromission. |
| **CVE** | *Common Vulnerabilities and Exposures* : vulnérabilités cataloguées — mitiger par **`FROM` à jour** et scans d’image. |

### Révision détaillée

- **Conteneur vs VM** : VM = **virtualisation complète** (OS invité) ; conteneur = **isolation de processus** sur le même noyau → moins de RAM, boot rapide.
- **Image** : couches **read-only** réutilisables entre builds ; **conteneur** : couche **copy-on-write** ; données critiques → **volume** ou base managée.
- **Dockerfile** : ordonner du **stable** au **volatile** pour maximiser le **cache** Docker (éviter `COPY . .` tout en haut avant `composer install`).
- **Compose** : un **service** = souvent un conteneur (ex. `app`, `mysql`) ; **réseau bridge** par défaut pour résolution DNS interne (`mysql` comme hostname).
- **Sail** : `vendor/bin/sail up` lance la stack définie par Laravel — mêmes primitives que Compose.
- **Secrets** : `.env` sur l’hôte ou variables CI ; jamais commiter ; en prod, **secrets manager** (Vault, cloud provider).
- **Sécurité** : **non-root**, **minimal base image** (éviter paquets inutiles), **scanner** l’image, **HTTPS** en frontal (reverse proxy), principe du **moindre privilège** DB (utilisateur SQL dédié, pas `root` applicatif).

### Exemples concrets

**Dockerfile minimal (illustratif — à adapter aux versions réelles) :**

```dockerfile
FROM php:8.2-cli
WORKDIR /app
COPY . .
RUN apt-get update && apt-get install -y --no-install-recommends git unzip \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install --no-dev --optimize-autoloader
ENV APP_ENV=production
EXPOSE 8000
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
```

**Lancer un conteneur interactif (notion) :**

```bash
docker build -t mon-app:1.0 .
docker run --rm -p 8000:8000 mon-app:1.0
```

**Sécurité — variables d’environnement au run (extrait) :**

```bash
docker run -e APP_KEY="base64:..." -e DB_PASSWORD="..." mon-app:1.0
```

Ne jamais copier `.env` réel dans l’image publique.

### Pièges fréquents

- Image construite en `root` + application qui tourne en `root` → surface d’attaque large.
- Oublier de mettre à jour l’image de base (`FROM`) → CVE connues.

### Quiz C8

1. En quoi Docker aide-t-il une équipe ?
2. Différence fondamentale conteneur vs VM ?
3. Rôle d’un **Dockerfile** ?
4. Différence **image** et **conteneur** ?
5. Citez trois bonnes pratiques de sécurité liées au déploiement.
6. À quoi sert **Laravel Sail** dans l’écosystème Fil Rouge ?
7. Pourquoi éviter de lancer le conteneur en `root` en production si possible ?
8. Que signifie **EXPOSE** dans un Dockerfile ?

### Corrigés quiz C8

1. Même environnement pour tous, reproductibilité, onboarding, intégration continue.
2. VM virtualise un OS entier ; conteneur réutilise le noyau de l’hôte avec isolation des processus/fichiers réseau.
3. Décrire comment construire une image (couches, dépendances, commande de démarrage).
4. Image = modèle ; conteneur = instance en cours d’exécution à partir d’une image.
5. Secrets hors Git, HTTPS, utilisateur restreint, mises à jour, pare-feu, scans d’images, moindre privilège DB.
6. Fournir un environnement de développement Laravel cohérent basé sur Docker.
7. Réduire l’impact en cas de compromission du conteneur (principe du moindre privilège).
8. Documenter le port d’écoute attendu de l’application (ne publie pas le port seul ; souvent `-p` au `docker run`).

---

## Tableau récapitulatif — compétences & entraînement

| Code | Thème | Révision & quiz | Défis code (repo) |
|------|--------|-----------------|-------------------|
| C1 | Git | Ce document | — |
| C2 | Maquettage | Ce document | — |
| C3 | HTML / CSS | Ce document | — |
| C4 | JavaScript (données, ES) | Ce document | `javascript/` |
| C5 | UML | Ce document | Lié à `php/` (modèle) |
| C6 | SQL | Ce document | `sql/` |
| C7 | POO | Ce document | `php/` |
| C8 | Docker / déploiement / sécu | Ce document | — |

---

## Check-list rapide avant soutenance Fil Rouge

- [ ] **C1** : historique Git propre, branches, au moins une PR ou équivalent expliqué.
- [ ] **C2** : maquettes des parcours critiques disponibles.
- [ ] **C3** : pages structurées, CSS organisé, responsive abordé.
- [ ] **C4** : manipulation tableaux/objets, `let`/`const`, spread, sans dépendre uniquement du DOM pour l’oral.
- [ ] **C5** : use cases + classes + lien avec le code.
- [ ] **C6** : jointures, agrégats, schéma SQL cohérent, requêtes dans le périmètre CR.
- [ ] **C7** : héritage / interface / polymorphisme identifiables, encapsulation.
- [ ] **C8** : savoir expliquer Docker (ou Sail), image vs conteneur, une idée sécurité déploiement.
- [ ] **Restrictions** : aucun package interdit du CR dans le livrable Laravel.

---

*Document du pack PFR_Challenges — à adapter au barème officiel de votre établissement.*
