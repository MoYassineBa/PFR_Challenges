# Critères d’évaluation — Projet Fil Rouge (référence)

Document de synthèse à partir du **Compte Rendu de Réunion** (exigences Fil Rouge, accord formateurs 2ᵉ année) et des **questions type** (soutenances croisées A1 2026).

Ce fichier sert de **référence de validation** pour croiser les défis du dossier `javascript/`, `php/`, `sql/` avec les compétences C1–C8.

**Révision & quiz (C1 à C8)** — synthèses + quiz pour toutes les compétences ; les défis code restent dans `javascript/`, `sql/`, `php/` : voir `revision-quiz/quiz-et-revision.md`.

---

## 1. Restrictions techniques (projet Fil Rouge)

Les packages suivants **ne sont pas autorisés** :

| Interdit | Motif (rappel pédagogique) |
|----------|---------------------------|
| **Breeze** | Simplifie trop l’auth / scaffolding |
| **Spatie** (et autres packages d’autorisation) | Idem |
| **Livewire** | Couche réactive « magique » |
| **Laravel Voyager** | Admin généré |
| **Laravel Easy Panel** | Idem |
| **Datatable** (Yajra et bibliothèques similaires) | Tableaux serveur/client prêts à l’emploi |

**Remarque pour ce repo de défis :** les exercices ici sont **sans framework** (JS / PHP OOP pur / SQL). Si vous branchez ces défis dans une app Laravel Fil Rouge, imposez ces interdits sur **l’application livrée**, pas sur les snippets d’évaluation isolés.

---

## 2. Compétences — objectifs et minimum requis

### C1 — Maîtrise de Git
- **Objectif :** commandes de base, workflow, conflits, stratégies de branching.
- **Attendu :** dépôt GitHub avec historique de commits crédible.
- **Questions type :** `git init`, `add` vs `commit`, historique (`log`), branches, résolution de conflit, `fetch` vs `pull`, corriger un commit non poussé, pull requests.

### C2 — Maquettage d’interface
- **Objectif :** capacité à concevoir une UI.
- **Minimum :** maquette montrant les principes de conception (toutes les pages non obligatoires).

### C3 — HTML / CSS
- **Objectif :** structuration et stylisation.
- **Minimum :** bonnes bases HTML/CSS.
- **Remarque officielle :** pas de mise en situation pour gagner du temps d’évaluation.
- **Questions type :** sémantique, organisation CSS, `block` / `inline`, responsive, classe vs `#id`, navigateurs, `position: absolute`, Flexbox, transitions.

### C4 — JavaScript
- **Objectif :** manipulation de données, bases JS.
- **Attendu :** validations de formulaires ou **formes dynamiques**.
- **Minimum :** manipulation simple de **tableaux**, **spread operator**, bases **ECMAScript**.
- **Remarque officielle :** **manipulation du DOM non exigée** à l’évaluation.
- **Questions type :** tableaux, spread, `let`/`const`, `filter`, max d’un tableau, fléchées, `try/catch`, `==` vs `===`, événements (clic).

**Alignement défis (`javascript/medium.md`, `hard.md`, `extreme.md`) :**
- Prioriser en correction orale les défis **tableaux d’objets**, **spread/copies**, **`map` / `filter` / `reduce`**, **données de formulaire** (objets simulés), sans exiger le DOM.
- Les défis « analytics école » restent valides pour **données + ES moderne** ; ajouter si besoin une variante « validation d’un objet inscription » pour coller au mot **formes**.

### C5 — Conception UML
- **Objectif :** conception logicielle.
- **Attendu :** diagramme de **cas d’utilisation**, diagramme de **classes**, argumentation.
- **Minimum :** comprendre ce qui est implémenté et justifier les choix.
- **Questions type :** use case, classes, héritage en UML, intérêt avant code, acteurs primaires/secondaires, relations use case et classes, association vs composition, N-N.

**Alignement défis PHP :** les énoncés OOP peuvent servir de **base narrative** pour un diagramme de classes (Student, Course, Enrollment, etc.).

### C6 — SQL et base de données
- **Objectif :** manipulation de données.
- **Mise en situation officielle :**
  - au moins **une jointure** ;
  - **maximum une jointure sur trois tables** (comprendre : ne pas exiger des requêtes à 5 tables enchaînées ; rester sur **2–3 tables** raisonnables) ;
  - agrégations, **GROUP BY**, **HAVING** ;
  - **CREATE**, **UPDATE**, **DELETE** ;
  - **sous-requêtes** admises comme alternative aux jointures.
- **Minimum :** opérations de base + jointures simples, culture BD.

**Alignement défis (`sql/*.md`) :**
- Vérifier chaque énoncé **extreme** ou très long : si > 3 tables jointes en une requête, proposer une **version Fil Rouge** (CTE en deux temps, ou sous-requête) pour rester dans le cadre.
- Les fichiers `medium` / `hard` sont en général **conformes** (2–3 tables).

### C7 — Programmation orientée objet (POO)
- **Objectif :** héritage, polymorphisme, abstraction, classes, objets.
- **Mise en situation officielle :** logique **simple**, **limitée à une seule boucle** pour les M.S (maîtrise de la logique ? — probablement « mesures / structures » ou « niveau » ; conserver la consigne : **peu de boucles**, privilégier la clarté OOP).
- **Minimum :** architecture OO simple + capacité à l’argumenter.

**Alignement défis (`php/*.md`) :**
- Favoriser les exercices où la logique passe par **polymorphisme / petits objets** plutôt que par de gros `for`.
- Les défis **Extreme** (DDD, UoW, etc.) peuvent dépasser le cadre « une boucle » : les utiliser en **option** ou en **2ᵉ année avancée**, pas comme minimum Fil Rouge strict.

### C8 — Docker, déploiement et sécurité
- **Objectif :** compréhension du déploiement.
- **Attendu :** Docker, **Laravel Sail** cités comme exemples.
- **Minimum :** répondre aux questions de déploiement.
- **Questions type :** intérêt de Docker, conteneur vs VM, Dockerfile, image Docker.

**Alignement défis :** pas de piste SQL/JS/PHP directe ; prévoir **questions orales** ou un mini **quiz** séparé.

---

## 3. Grille rapide — croiser un défi avec C4 / C6 / C7

| Compétence | Ce que le correcteur vérifie sur un livrable « défi » |
|------------|--------------------------------------------------------|
| **C4** | Tableaux, immutabilité/copies (`spread`), `filter`/`map`, pas besoin de DOM pour valider. |
| **C6** | `JOIN` explicite ou sous-requête équivalente ; `GROUP BY`/`HAVING` ; au besoin script séparé `UPDATE`/`DELETE` sur jeu de test. |
| **C7** | Classes, interface/classe abstraite, un enchaînement polymorphe lisible ; boucles limitées. |

---

## 4. Prochaines étapes possibles (quand vous voudrez)

- Les en-têtes **Fil Rouge** sont déjà ajoutés dans `javascript/`, `php/`, `sql/` (voir variantes **C6** dans `sql/extreme.md` pour les requêtes longues).
- Taguer chaque défi individuellement (barème points) si besoin.
- Générer une **fiche correcteur** (réponses attendues) par défi.

Indiquez si vous souhaitez l’une de ces options ; le présent fichier reste la **source de vérité** des critères tant que le compte rendu officiel ne change pas.
