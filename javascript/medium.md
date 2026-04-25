# JavaScript — Medium (10 challenges)

> **Fil Rouge / C4** — Manipulation de **données** (tableaux, objets), **ES moderne** (`const` / `let`, spread si demandé). La correction **ne suppose pas le DOM** (formulaires = objets / tableaux en entrée-sortie).

> **Données d’entrée :** tout **tableau d’exemples** (racine ou sous `attempts`, `primary`, `overflow`, `sessions`, etc.) comporte **au moins 10 éléments**. Exceptions acceptées : petits objets de config (`dayOrder`, seules clés d’un seul formulaire) si l’énoncé impose un format fixe — dans ce pack, les tableaux de **données métier** sont tous ≥ 10.

School analytics with arrays of objects. Difficulty: single main concept each.

---

## 1. Average grade per student

### Task Description
Given an array of grade records, compute each student's **average numeric grade** (0–20 scale). Return an array of objects: `{ studentId, fullName, average }` sorted by `studentId` ascending.

### Input Data
```json
[
  { "studentId": 3, "fullName": "Kenza Amrani", "score": 10 },
  { "studentId": 3, "fullName": "Kenza Amrani", "score": 10 },
  { "studentId": 4, "fullName": "Yassine Iqbal", "score": 9 },
  { "studentId": 4, "fullName": "Yassine Iqbal", "score": 11 },
  { "studentId": 5, "fullName": "Nora Bennani", "score": 12 },
  { "studentId": 5, "fullName": "Nora Bennani", "score": 8 },
  { "studentId": 7, "fullName": "Omar Idrissi", "score": 11 },
  { "studentId": 7, "fullName": "Omar Idrissi", "score": 13 },
  { "studentId": 12, "fullName": "Sara Benali", "score": 14 },
  { "studentId": 12, "fullName": "Sara Benali", "score": 16 }
]
```

### Expected Output
```json
[
  { "studentId": 3, "fullName": "Kenza Amrani", "average": 10 },
  { "studentId": 4, "fullName": "Yassine Iqbal", "average": 10 },
  { "studentId": 5, "fullName": "Nora Bennani", "average": 10 },
  { "studentId": 7, "fullName": "Omar Idrissi", "average": 12 },
  { "studentId": 12, "fullName": "Sara Benali", "average": 15 }
]
```
(Round averages to the nearest integer.)

### Constraints
- Use `reduce` at least once to build a map or accumulator.
- Optionally clone the input array with the **spread operator** before any step if you mutate intermediate arrays.

### Bonus Challenge
Also return `gradeCount` per student.

### Hints
- **Hint 1:** Group rows by `studentId` before averaging.
- **Hint 2:** `reduce` into an object keyed by `studentId` storing `{ sum, count, fullName }`.
- **Hint 3:** `Object.values(map).map(...)` then sort with `(a,b) => a.studentId - b.studentId`.

---

## 2. Students below passing threshold

### Task Description
Passing is **10/20** or higher. From a list of students with their **latest** exam score per subject (one row per student per subject), return full names of students who have **any** subject below 10, alphabetically by name.

### Input Data
```json
[
  { "fullName": "Amine Tazi", "subject": "Math", "score": 9 },
  { "fullName": "Amine Tazi", "subject": "SQL", "score": 14 },
  { "fullName": "Hiba Alaoui", "subject": "Math", "score": 12 },
  { "fullName": "Hiba Alaoui", "subject": "SQL", "score": 15 },
  { "fullName": "Ilias Cherkaoui", "subject": "Math", "score": 8 },
  { "fullName": "Ilias Cherkaoui", "subject": "SQL", "score": 14 },
  { "fullName": "Nora Bennani", "subject": "Math", "score": 13 },
  { "fullName": "Nora Bennani", "subject": "PHP", "score": 14 },
  { "fullName": "Sami Tazi", "subject": "Math", "score": 11 },
  { "fullName": "Sami Tazi", "subject": "SQL", "score": 10 }
]
```

### Expected Output
```json
["Amine Tazi", "Ilias Cherkaoui"]
```

### Constraints
- Use `filter` + `map`; avoid nested `for` loops (use array methods only).

### Bonus Challenge
Return `{ name, failingSubjects: string[] }` instead of plain names.

### Hints
- **Hint 1:** Find who has at least one `score < 10`.
- **Hint 2:** `filter` students where `some` row matches low score — but rows are per subject; group by name or use `some` on filtered slice.
- **Hint 3:** Build a Set: `names` where `records.some(r => r.fullName === name && r.score < 10)` after collecting unique names with `[...new Set(records.map(r => r.fullName))]`.

---

## 3. Total absences by class

### Task Description
Attendance rows include `classCode` and `minutesAbsent`. Return total minutes absent **per class**, descending by total.

### Input Data
```json
[
  { "classCode": "DWWM-24A", "minutesAbsent": 30 },
  { "classCode": "DWWM-24A", "minutesAbsent": 15 },
  { "classCode": "DWWM-24A", "minutesAbsent": 20 },
  { "classCode": "DWWM-24A", "minutesAbsent": 5 },
  { "classCode": "DWWM-24A", "minutesAbsent": 10 },
  { "classCode": "DWWM-24B", "minutesAbsent": 45 },
  { "classCode": "DWWM-24B", "minutesAbsent": 12 },
  { "classCode": "DWWM-24B", "minutesAbsent": 8 },
  { "classCode": "DWWM-24B", "minutesAbsent": 5 },
  { "classCode": "DWWM-24B", "minutesAbsent": 5 }
]
```

### Expected Output
```json
[
  { "classCode": "DWWM-24A", "totalMinutesAbsent": 80 },
  { "classCode": "DWWM-24B", "totalMinutesAbsent": 75 }
]
```
If totals tie, sort by `classCode` ascending.

### Constraints
- Use `reduce` to aggregate; sort with `localeCompare` for tie-break.

### Bonus Challenge
Add `sessionCount` (number of attendance rows).

### Hints
- **Hint 1:** Sum `minutesAbsent` grouped by `classCode`.
- **Hint 2:** Reduce to `{ [classCode]: sum }` then `Object.entries` → map → sort.
- **Hint 3:** Sort: `(a,b) => b.totalMinutesAbsent - a.totalMinutesAbsent || a.classCode.localeCompare(b.classCode)`.

---

## 4. Normalize schedule slots

### Task Description
Teachers submit slots like `"09:00-10:30"`. Parse into `{ start, end }` (24h strings) and attach `durationMinutes`. Input is an array of `{ teacherId, slot }`.

### Input Data
```json
[
  { "teacherId": 1, "slot": "08:00-09:00" },
  { "teacherId": 2, "slot": "09:00-10:30" },
  { "teacherId": 3, "slot": "09:00-10:30" },
  { "teacherId": 4, "slot": "10:45-12:15" },
  { "teacherId": 5, "slot": "14:00-15:00" },
  { "teacherId": 6, "slot": "15:15-17:00" },
  { "teacherId": 7, "slot": "08:30-10:00" },
  { "teacherId": 8, "slot": "13:00-14:00" },
  { "teacherId": 9, "slot": "16:00-17:30" },
  { "teacherId": 10, "slot": "11:00-11:45" }
]
```

### Expected Output
```json
[
  { "teacherId": 1, "start": "08:00", "end": "09:00", "durationMinutes": 60 },
  { "teacherId": 2, "start": "09:00", "end": "10:30", "durationMinutes": 90 },
  { "teacherId": 3, "start": "09:00", "end": "10:30", "durationMinutes": 90 },
  { "teacherId": 4, "start": "10:45", "end": "12:15", "durationMinutes": 90 },
  { "teacherId": 5, "start": "14:00", "end": "15:00", "durationMinutes": 60 },
  { "teacherId": 6, "start": "15:15", "end": "17:00", "durationMinutes": 105 },
  { "teacherId": 7, "start": "08:30", "end": "10:00", "durationMinutes": 90 },
  { "teacherId": 8, "start": "13:00", "end": "14:00", "durationMinutes": 60 },
  { "teacherId": 9, "start": "16:00", "end": "17:30", "durationMinutes": 90 },
  { "teacherId": 10, "start": "11:00", "end": "11:45", "durationMinutes": 45 }
]
```

### Constraints
- Use `map` only; pure functions for time math.

### Bonus Challenge
Reject invalid formats (return `null` for bad rows and filter them out).

### Hints
- **Hint 1:** `split('-')` then trim each part.
- **Hint 2:** Convert `"HH:MM"` to minutes: `h*60+m`.
- **Hint 3:** `duration = endMins - startMins` (assume end > start).

---

## 5. Active enrollments only

### Task Description
Filter enrollments where `status === "active"` and `endDate` is null or after today. Today is fixed: `"2026-04-24"`. Return same object shape sorted by `studentId`.

### Input Data
```json
[
  { "studentId": 1, "classCode": "DWWM-24A", "status": "active", "endDate": null },
  { "studentId": 2, "classCode": "DWWM-24A", "status": "withdrawn", "endDate": "2026-03-01" },
  { "studentId": 3, "classCode": "DWWM-24B", "status": "active", "endDate": "2026-05-01" },
  { "studentId": 4, "classCode": "DWWM-24B", "status": "withdrawn", "endDate": "2026-04-01" },
  { "studentId": 5, "classCode": "DWWM-24C", "status": "active", "endDate": null },
  { "studentId": 6, "classCode": "DWWM-24C", "status": "active", "endDate": "2026-06-30" },
  { "studentId": 7, "classCode": "DWWM-24A", "status": "completed", "endDate": "2026-02-01" },
  { "studentId": 8, "classCode": "DWWM-24A", "status": "active", "endDate": "2026-04-25" },
  { "studentId": 9, "classCode": "DWWM-24B", "status": "active", "endDate": null },
  { "studentId": 10, "classCode": "DWWM-24B", "status": "suspended", "endDate": null }
]
```

### Expected Output
```json
[
  { "studentId": 1, "classCode": "DWWM-24A", "status": "active", "endDate": null },
  { "studentId": 3, "classCode": "DWWM-24B", "status": "active", "endDate": "2026-05-01" },
  { "studentId": 5, "classCode": "DWWM-24C", "status": "active", "endDate": null },
  { "studentId": 6, "classCode": "DWWM-24C", "status": "active", "endDate": "2026-06-30" },
  { "studentId": 8, "classCode": "DWWM-24A", "status": "active", "endDate": "2026-04-25" },
  { "studentId": 9, "classCode": "DWWM-24B", "status": "active", "endDate": null }
]
```

### Constraints
- Use `filter` + `sort`; compare dates as ISO strings.

### Bonus Challenge
Parameterize `asOf` date as function argument.

### Hints
- **Hint 1:** Active means status and future-or-null end.
- **Hint 2:** `!endDate || endDate > asOf`.
- **Hint 3:** String compare works for `YYYY-MM-DD`.

---

## 6. Subject list per classroom

### Task Description
From course assignments `{ classCode, subjectCode, subjectName }`, return unique `{ classCode, subjects: string[] }` where `subjects` are **unique** `subjectName` values sorted A–Z.

### Input Data
```json
[
  { "classCode": "DWWM-24A", "subjectCode": "JS", "subjectName": "JavaScript" },
  { "classCode": "DWWM-24A", "subjectCode": "PHP", "subjectName": "PHP" },
  { "classCode": "DWWM-24A", "subjectCode": "JS-LAB", "subjectName": "JavaScript" },
  { "classCode": "DWWM-24A", "subjectCode": "SQL", "subjectName": "SQL" },
  { "classCode": "DWWM-24A", "subjectCode": "GIT", "subjectName": "Git" },
  { "classCode": "DWWM-24B", "subjectCode": "JS", "subjectName": "JavaScript" },
  { "classCode": "DWWM-24B", "subjectCode": "UX", "subjectName": "UX" },
  { "classCode": "DWWM-24B", "subjectCode": "PHP", "subjectName": "PHP" },
  { "classCode": "DWWM-24B", "subjectCode": "SQL", "subjectName": "SQL" },
  { "classCode": "DWWM-24B", "subjectCode": "AGILE", "subjectName": "Agile" }
]
```

### Expected Output
```json
[
  { "classCode": "DWWM-24A", "subjects": ["Git", "JavaScript", "PHP", "SQL"] },
  { "classCode": "DWWM-24B", "subjects": ["Agile", "JavaScript", "PHP", "SQL", "UX"] }
]
```

### Constraints
- Use `reduce` to group; dedupe with `Set`.

### Bonus Challenge
Include `subjectCodes: string[]` aligned with names (unique by code).

### Hints
- **Hint 1:** Group by `classCode`, collect subject names in a Set per class.
- **Hint 2:** `reduce((acc, row) => { ... acc[row.classCode].add(row.subjectName); return acc }, {})`.
- **Hint 3:** Map to output and `Array.from(set).sort()`.

---

## 7. Inscription scolaire — fusion et validation (sans DOM)

### Task Description
Tu reçois un **tableau `attempts` de longueur 10**. Chaque élément est une paire `{ "defaults": {...}, "submitted": {...} }` (même règles que ci-dessous). Pour **chaque** paire, produire `{ record, errors }` avec le **spread** `{ ...defaults, ...submitted }`, puis `record` = copie avec `fullName` trimmé (voir ci-dessous). Valider :

- `fullName` : non vide après `trim` sur la valeur fusionnée
- `email` : exactement **un** `@`, avec au moins un caractère avant et après
- `classCode` : dans `["DWWM-24A", "DWWM-24B"]`

Retourner **`{ "results": [ ... 10 objets ... ] }`** dans le même ordre que `attempts`.

### Input Data
```json
{
  "attempts": [
    {
      "defaults": { "fullName": "", "email": "inconnu@school.ma", "classCode": "DWWM-24A", "phone": "" },
      "submitted": { "fullName": "  Karim Alaoui  ", "email": "karim" }
    },
    {
      "defaults": { "fullName": "", "email": "", "classCode": "DWWM-24A", "phone": "" },
      "submitted": { "fullName": "Sara Benali", "email": "sara@school.ma" }
    },
    {
      "defaults": { "fullName": "X", "email": "x@y.ma", "classCode": "DWWM-24A", "phone": "" },
      "submitted": { "fullName": "   ", "email": "ok@school.ma" }
    },
    {
      "defaults": { "fullName": "", "email": "a@b.ma", "classCode": "DWWM-24A", "phone": "" },
      "submitted": { "fullName": "Omar", "email": "bad@@mail.ma", "classCode": "DWWM-24B" }
    },
    {
      "defaults": { "fullName": "", "email": "", "classCode": "DWWM-24A", "phone": "" },
      "submitted": { "fullName": "Lina", "email": "lina@school.ma", "classCode": "DWWM-99Z" }
    },
    {
      "defaults": { "fullName": "", "email": "", "classCode": "DWWM-24B", "phone": "" },
      "submitted": { "fullName": "Hiba", "email": "hiba@school.ma" }
    },
    {
      "defaults": { "fullName": "", "email": "", "classCode": "DWWM-24A", "phone": "" },
      "submitted": { "fullName": "Yassine", "email": "yassine@school.ma", "classCode": "DWWM-24A" }
    },
    {
      "defaults": { "fullName": "", "email": "old@school.ma", "classCode": "DWWM-24A", "phone": "" },
      "submitted": { "fullName": "Nora", "email": "nora@school.ma" }
    },
    {
      "defaults": { "fullName": "", "email": "", "classCode": "DWWM-24B", "phone": "" },
      "submitted": { "fullName": "Samir", "email": "@nodomain", "classCode": "DWWM-24B" }
    },
    {
      "defaults": { "fullName": "", "email": "", "classCode": "DWWM-24A", "phone": "" },
      "submitted": { "fullName": "Imane", "email": "imane@school.ma", "classCode": "DWWM-24A" }
    }
  ]
}
```

### Expected Output
Même règle de construction : `merged = { ...defaults, ...submitted }`, puis `record = { ...merged, fullName: merged.fullName.trim() }`, puis validation sur `record`.

- Index **0** : `errors` contient `"email invalide"`.
- Index **1** : valide (`errors: []`).
- Index **2** : `fullName` vide après trim → ex. `"fullName invalide"`.
- Index **3** : `"email invalide"` (deux `@`).
- Index **4** : `"classCode invalide"` (ou libellé équivalent).
- Index **5**, **6**, **7**, **9** : valides (`errors: []`).
- Index **8** : `"email invalide"` (domaine vide après `@`).

Le JSON exact des 10 `record` / `errors` est laissé au corrigé automatique ou à la fiche formateur (trop long ici) ; l’énoncé impose l’**ordre** et les **cas d’erreur** ci-dessus.

### Constraints
- Utiliser **obligatoirement** le spread pour chaque fusion `defaults` / `submitted`.
- Traiter les 10 entrées avec **`.map`** sur `attempts` (pas de `for` / `while`).

### Bonus Challenge
Ajouter `phone` : optionnel, mais s’il est non vide il doit matcher `^\d{10}$`.

### Hints
- **Hint 1:** `const merged = { ...defaults, ...submitted };` puis `const record = { ...merged, fullName: merged.fullName.trim() };`
- **Hint 2:** Pousser dans `errors` dans l’ordre : `fullName`, `email`, `classCode`.
- **Hint 3:** Pour l’email, compter les `@` (exactement 1) ou utiliser `split` et vérifier parties non vides.

---

## 8. Fee balance due

### Task Description
Each student has `{ studentId, chargesCents, paymentsCents }`. Return `{ studentId, balanceDueCents }` where balance = charges − payments; only include rows with **balance > 0**, sorted by balance descending.

### Input Data
```json
[
  { "studentId": 1, "chargesCents": 500000, "paymentsCents": 500000 },
  { "studentId": 2, "chargesCents": 300000, "paymentsCents": 100000 },
  { "studentId": 3, "chargesCents": 400000, "paymentsCents": 400000 },
  { "studentId": 4, "chargesCents": 250000, "paymentsCents": 240000 },
  { "studentId": 5, "chargesCents": 100000, "paymentsCents": 100000 },
  { "studentId": 6, "chargesCents": 180000, "paymentsCents": 50000 },
  { "studentId": 7, "chargesCents": 90000, "paymentsCents": 85000 },
  { "studentId": 8, "chargesCents": 120000, "paymentsCents": 120000 },
  { "studentId": 9, "chargesCents": 60000, "paymentsCents": 20000 },
  { "studentId": 10, "chargesCents": 150000, "paymentsCents": 149000 }
]
```

### Expected Output
```json
[
  { "studentId": 2, "balanceDueCents": 200000 },
  { "studentId": 4, "balanceDueCents": 10000 },
  { "studentId": 6, "balanceDueCents": 130000 },
  { "studentId": 7, "balanceDueCents": 5000 },
  { "studentId": 9, "balanceDueCents": 40000 },
  { "studentId": 10, "balanceDueCents": 1000 }
]
```
(Trier par `balanceDueCents` décroissant.)

### Constraints
- Use `map` then `filter`.

### Bonus Challenge
Format as euros string `"2000.00 EUR"` (still sort by cents internally).

### Hints
- **Hint 1:** Compute difference per row.
- **Hint 2:** Filter `balanceDueCents > 0`.
- **Hint 3:** Sort `(a,b) => b.balanceDueCents - a.balanceDueCents`.

---

## 9. Weekly attendance rate

### Task Description
Rows: `{ classCode, weekId, presentCount, absentCount }`. Add `attendanceRate` = `presentCount / (presentCount + absentCount)` rounded to **2 decimals**. Return all rows sorted by `classCode`, then `weekId`.

### Input Data
```json
[
  { "classCode": "DWWM-24A", "weekId": 1, "presentCount": 20, "absentCount": 0 },
  { "classCode": "DWWM-24A", "weekId": 2, "presentCount": 19, "absentCount": 1 },
  { "classCode": "DWWM-24A", "weekId": 3, "presentCount": 18, "absentCount": 2 },
  { "classCode": "DWWM-24B", "weekId": 1, "presentCount": 22, "absentCount": 0 },
  { "classCode": "DWWM-24B", "weekId": 2, "presentCount": 18, "absentCount": 2 },
  { "classCode": "DWWM-24B", "weekId": 3, "presentCount": 17, "absentCount": 3 },
  { "classCode": "DWWM-24C", "weekId": 1, "presentCount": 0, "absentCount": 0 },
  { "classCode": "DWWM-24C", "weekId": 2, "presentCount": 15, "absentCount": 5 },
  { "classCode": "DWWM-24C", "weekId": 3, "presentCount": 12, "absentCount": 8 },
  { "classCode": "DWWM-24A", "weekId": 4, "presentCount": 21, "absentCount": 1 }
]
```

### Expected Output
```json
[
  { "classCode": "DWWM-24A", "weekId": 1, "presentCount": 20, "absentCount": 0, "attendanceRate": 1 },
  { "classCode": "DWWM-24A", "weekId": 2, "presentCount": 19, "absentCount": 1, "attendanceRate": 0.95 },
  { "classCode": "DWWM-24A", "weekId": 3, "presentCount": 18, "absentCount": 2, "attendanceRate": 0.9 },
  { "classCode": "DWWM-24A", "weekId": 4, "presentCount": 21, "absentCount": 1, "attendanceRate": 0.95 },
  { "classCode": "DWWM-24B", "weekId": 1, "presentCount": 22, "absentCount": 0, "attendanceRate": 1 },
  { "classCode": "DWWM-24B", "weekId": 2, "presentCount": 18, "absentCount": 2, "attendanceRate": 0.9 },
  { "classCode": "DWWM-24B", "weekId": 3, "presentCount": 17, "absentCount": 3, "attendanceRate": 0.85 },
  { "classCode": "DWWM-24C", "weekId": 1, "presentCount": 0, "absentCount": 0, "attendanceRate": null },
  { "classCode": "DWWM-24C", "weekId": 2, "presentCount": 15, "absentCount": 5, "attendanceRate": 0.75 },
  { "classCode": "DWWM-24C", "weekId": 3, "presentCount": 12, "absentCount": 8, "attendanceRate": 0.6 }
]
```

### Constraints
- Guard division by zero: if both zero, use `attendanceRate: null`.

### Bonus Challenge
Flag `weekId` where rate is below 0.85 with `alert: true`.

### Hints
- **Hint 1:** Denominator = sum of present and absent.
- **Hint 2:** `Number((p/d).toFixed(2))` but handle `d===0`.
- **Hint 3:** Multi-key sort: compare `classCode` then numeric `weekId`.

---

## 10. Merge teacher office hours

### Task Description
Un objet JSON avec `dayOrder`, un tableau **`primary`** (10 lignes) et un tableau **`overflow`** (10 lignes) : `{ teacherId, day, start, end }`. Fusionner ; si même `teacherId` + `day`, garder la ligne de **`primary`**. Trier par `teacherId`, puis `day` selon `dayOrder`.

### Input Data
```json
{
  "dayOrder": { "Mon": 1, "Tue": 2, "Wed": 3, "Thu": 4, "Fri": 5 },
  "primary": [
    { "teacherId": 1, "day": "Wed", "start": "10:00", "end": "12:00" },
    { "teacherId": 2, "day": "Mon", "start": "09:00", "end": "11:00" },
    { "teacherId": 3, "day": "Tue", "start": "14:00", "end": "16:00" },
    { "teacherId": 4, "day": "Thu", "start": "08:30", "end": "10:00" },
    { "teacherId": 5, "day": "Fri", "start": "13:00", "end": "15:00" },
    { "teacherId": 6, "day": "Mon", "start": "15:00", "end": "17:00" },
    { "teacherId": 7, "day": "Tue", "start": "09:00", "end": "10:30" },
    { "teacherId": 8, "day": "Wed", "start": "08:00", "end": "09:00" },
    { "teacherId": 9, "day": "Thu", "start": "11:00", "end": "12:30" },
    { "teacherId": 10, "day": "Fri", "start": "10:00", "end": "11:00" }
  ],
  "overflow": [
    { "teacherId": 1, "day": "Wed", "start": "14:00", "end": "16:00" },
    { "teacherId": 2, "day": "Mon", "start": "12:00", "end": "13:00" },
    { "teacherId": 11, "day": "Mon", "start": "08:00", "end": "09:00" },
    { "teacherId": 12, "day": "Tue", "start": "11:00", "end": "12:00" },
    { "teacherId": 13, "day": "Wed", "start": "13:00", "end": "14:00" },
    { "teacherId": 14, "day": "Thu", "start": "14:00", "end": "15:00" },
    { "teacherId": 15, "day": "Fri", "start": "08:00", "end": "09:30" },
    { "teacherId": 16, "day": "Mon", "start": "10:00", "end": "11:00" },
    { "teacherId": 17, "day": "Tue", "start": "16:00", "end": "17:00" },
    { "teacherId": 18, "day": "Wed", "start": "16:00", "end": "17:30" }
  ]
}
```

### Expected Output
Liste fusionnée : pour chaque couple `(teacherId, day)`, la ligne de **`primary` l’emporte** sur `overflow`. Trier par `teacherId` puis par `day` selon `dayOrder`. Résultat attendu (10 + 8 entrées uniques = 18 lignes après dédup des conflits sur 1|Wed et 2|Mon) :

```json
[
  { "teacherId": 1, "day": "Wed", "start": "10:00", "end": "12:00" },
  { "teacherId": 2, "day": "Mon", "start": "09:00", "end": "11:00" },
  { "teacherId": 3, "day": "Tue", "start": "14:00", "end": "16:00" },
  { "teacherId": 4, "day": "Thu", "start": "08:30", "end": "10:00" },
  { "teacherId": 5, "day": "Fri", "start": "13:00", "end": "15:00" },
  { "teacherId": 6, "day": "Mon", "start": "15:00", "end": "17:00" },
  { "teacherId": 7, "day": "Tue", "start": "09:00", "end": "10:30" },
  { "teacherId": 8, "day": "Wed", "start": "08:00", "end": "09:00" },
  { "teacherId": 9, "day": "Thu", "start": "11:00", "end": "12:30" },
  { "teacherId": 10, "day": "Fri", "start": "10:00", "end": "11:00" },
  { "teacherId": 11, "day": "Mon", "start": "08:00", "end": "09:00" },
  { "teacherId": 12, "day": "Tue", "start": "11:00", "end": "12:00" },
  { "teacherId": 13, "day": "Wed", "start": "13:00", "end": "14:00" },
  { "teacherId": 14, "day": "Thu", "start": "14:00", "end": "15:00" },
  { "teacherId": 15, "day": "Fri", "start": "08:00", "end": "09:30" },
  { "teacherId": 16, "day": "Mon", "start": "10:00", "end": "11:00" },
  { "teacherId": 17, "day": "Tue", "start": "16:00", "end": "17:00" },
  { "teacherId": 18, "day": "Wed", "start": "16:00", "end": "17:30" }
]
```

### Constraints
- Build a key `"teacherId|day"`; `primary` overwrites when deduping.
- Utiliser le **spread** pour copier un objet slot avant modification si tu normalises les champs (bonne pratique Fil Rouge / immutabilité).

### Bonus Challenge
Detect overlapping intervals for same teacher same day (validation).

### Hints
- **Hint 1:** Concat with primary taking precedence using a Map.
- **Hint 2:** Insert overflow first, then primary so primary wins — or use object merge order.
- **Hint 3:** Sort with `dayOrder[a.day] - dayOrder[b.day]`.
