# JavaScript — Hard (10 challenges)

> **Fil Rouge / C4** — Données, tableaux, **ES6+** (spread, fléchées, `const`/`let`). Pas d’exigence **DOM** ; les « formulaires » restent des structures JSON en entrée-sortie.

> **Données d’entrée :** tout **tableau JSON principal** sous `### Input Data` a une **longueur minimale de 10** (`array.length >= 10`).

Combine grouping, aggregation, and transformations. School domain only.

---

## 1. Class leaderboard with rank ties

### Task Description
Given per-student **final** scores per `classCode`, compute each student's **total** score (sum across subjects), then rank within each class. **Tied totals share the same rank** (1,1,3 style). Output: `{ classCode, studentId, total, rank }[]` sorted by `classCode`, then `rank`, then `studentId`.

### Input Data
```json
[
  { "classCode": "DWWM-24A", "studentId": 1, "subject": "JS", "score": 15 },
  { "classCode": "DWWM-24A", "studentId": 1, "subject": "PHP", "score": 15 },
  { "classCode": "DWWM-24A", "studentId": 2, "subject": "JS", "score": 20 },
  { "classCode": "DWWM-24A", "studentId": 2, "subject": "PHP", "score": 10 },
  { "classCode": "DWWM-24A", "studentId": 3, "subject": "JS", "score": 12 },
  { "classCode": "DWWM-24A", "studentId": 3, "subject": "PHP", "score": 11 },
  { "classCode": "DWWM-24A", "studentId": 4, "subject": "JS", "score": 8 },
  { "classCode": "DWWM-24A", "studentId": 4, "subject": "PHP", "score": 9 },
  { "classCode": "DWWM-24A", "studentId": 5, "subject": "JS", "score": 14 },
  { "classCode": "DWWM-24A", "studentId": 5, "subject": "PHP", "score": 12 }
]
```

### Expected Output
Totaux : 1→30, 2→30, 3→23, 5→26, 4→17. Rangs 1,1,3,4,5 (ex aequo 1–2).

```json
[
  { "classCode": "DWWM-24A", "studentId": 1, "total": 30, "rank": 1 },
  { "classCode": "DWWM-24A", "studentId": 2, "total": 30, "rank": 1 },
  { "classCode": "DWWM-24A", "studentId": 5, "total": 26, "rank": 3 },
  { "classCode": "DWWM-24A", "studentId": 3, "total": 23, "rank": 4 },
  { "classCode": "DWWM-24A", "studentId": 4, "total": 17, "rank": 5 }
]
```

### Constraints
- Must use `reduce` for totals; ranking via sort + dense rank logic.

### Bonus Challenge
Add `percentile` 0–100 within class.

### Hints
- **Hint 1:** Sum scores grouped by `classCode` + `studentId`.
- **Hint 2:** Sort desc by total; assign rank when total changes from previous.
- **Hint 3:** `rank = idx + 1` only if total differs from `sorted[i-1].total`; else same rank as previous.

---

## 2. Attendance streak per student

### Task Description
Rows sorted by `date` ascending: `{ studentId, date, status }` where `status` is `"P"` or `"A"`. For each student, compute **longest consecutive** `"P"` streak length.

### Input Data
```json
[
  { "studentId": 5, "date": "2026-04-01", "status": "P" },
  { "studentId": 5, "date": "2026-04-02", "status": "P" },
  { "studentId": 5, "date": "2026-04-03", "status": "P" },
  { "studentId": 5, "date": "2026-04-04", "status": "A" },
  { "studentId": 5, "date": "2026-04-05", "status": "P" },
  { "studentId": 5, "date": "2026-04-06", "status": "P" },
  { "studentId": 5, "date": "2026-04-07", "status": "P" },
  { "studentId": 5, "date": "2026-04-08", "status": "P" },
  { "studentId": 5, "date": "2026-04-09", "status": "A" },
  { "studentId": 5, "date": "2026-04-10", "status": "P" }
]
```

### Expected Output
Plus longue série de **P** consécutifs : 4 (du 2026-04-05 au 2026-04-08).

```json
[{ "studentId": 5, "longestPresentStreak": 4 }]
```

### Constraints
- Single pass per student preferred (`reduce` with state `{ current, best }`).

### Bonus Challenge
Also return `longestAbsentStreak`.

### Hints
- **Hint 1:** Iterate chronologically per student (group first).
- **Hint 2:** On `"P"`, increment `current`; on `"A"`, reset `current` to 0.
- **Hint 3:** After each step `best = Math.max(best, current)`.

---

## 3. Weighted module average

### Task Description
Subjects have weights `{ subject, weight }`. Grades: `{ studentId, subject, score }`. Compute **weighted average** per student: `sum(score * weight) / sum(weight)` for subjects present. Round to 1 decimal. Students with no grades: omit.

### Input Data
```json
{
  "weights": [
    { "subject": "JS", "weight": 2 },
    { "subject": "SQL", "weight": 1 },
    { "subject": "PHP", "weight": 1 },
    { "subject": "HTML", "weight": 1 },
    { "subject": "CSS", "weight": 1 },
    { "subject": "UML", "weight": 1 },
    { "subject": "Git", "weight": 1 },
    { "subject": "Docker", "weight": 1 },
    { "subject": "Agile", "weight": 1 },
    { "subject": "Security", "weight": 1 }
  ],
  "grades": [
    { "studentId": 9, "subject": "JS", "score": 12 },
    { "studentId": 9, "subject": "SQL", "score": 18 },
    { "studentId": 10, "subject": "JS", "score": 14 },
    { "studentId": 10, "subject": "SQL", "score": 10 },
    { "studentId": 11, "subject": "JS", "score": 8 },
    { "studentId": 11, "subject": "SQL", "score": 16 },
    { "studentId": 12, "subject": "JS", "score": 20 },
    { "studentId": 12, "subject": "SQL", "score": 4 },
    { "studentId": 13, "subject": "JS", "score": 10 },
    { "studentId": 13, "subject": "SQL", "score": 10 }
  ]
}
```

### Expected Output
```json
[
  { "studentId": 9, "weightedAverage": 14 },
  { "studentId": 10, "weightedAverage": 12.7 },
  { "studentId": 11, "weightedAverage": 10.7 },
  { "studentId": 12, "weightedAverage": 14.7 },
  { "studentId": 13, "weightedAverage": 10 }
]
```
(9 : `(12*2+18)/3 = 14` ; 10 : `(14*2+10)/3` ; arrondi **1 décimale**.)

### Constraints
- Build a `Map` of weights; validate unknown subjects (ignore grade row).

### Bonus Challenge
Throw or collect errors if subject in grades missing from weights.

### Hints
- **Hint 1:** Denominator uses only weights of subjects that appear for that student.
- **Hint 2:** Group grades by `studentId` with `reduce`.
- **Hint 3:** For each student loop subjects, skip if no weight.

---

## 4. Exam room capacity report

### Task Description
`rooms`: `{ roomId, capacity }`. `exams`: `{ subject, roomId, registered }`. Return merged list per exam key `subject|roomId` with `freeSeats = capacity - registered`, sorted by lowest `freeSeats` first (most constrained). Exclude rooms not in `rooms` table.

### Input Data
```json
{
  "rooms": [
    { "roomId": "A1", "capacity": 30 },
    { "roomId": "B2", "capacity": 24 },
    { "roomId": "C3", "capacity": 40 },
    { "roomId": "D4", "capacity": 18 },
    { "roomId": "E5", "capacity": 50 },
    { "roomId": "F6", "capacity": 22 },
    { "roomId": "G7", "capacity": 28 },
    { "roomId": "H8", "capacity": 35 },
    { "roomId": "I9", "capacity": 20 },
    { "roomId": "J10", "capacity": 32 }
  ],
  "exams": [
    { "subject": "PHP", "roomId": "A1", "registered": 28 },
    { "subject": "SQL", "roomId": "B2", "registered": 10 },
    { "subject": "JS", "roomId": "A1", "registered": 25 },
    { "subject": "Laravel", "roomId": "C3", "registered": 35 },
    { "subject": "Git", "roomId": "D4", "registered": 12 },
    { "subject": "UML", "roomId": "B2", "registered": 22 },
    { "subject": "Docker", "roomId": "C3", "registered": 38 },
    { "subject": "Agile", "roomId": "A1", "registered": 29 },
    { "subject": "Security", "roomId": "D4", "registered": 5 },
    { "subject": "Testing", "roomId": "B2", "registered": 20 }
  ]
}
```

### Expected Output
Trier par `freeSeats` croissant (ex aequo : `subject` alphabétique).

```json
[
  { "subject": "Agile", "roomId": "A1", "capacity": 30, "registered": 29, "freeSeats": 1 },
  { "subject": "Docker", "roomId": "C3", "capacity": 40, "registered": 38, "freeSeats": 2 },
  { "subject": "PHP", "roomId": "A1", "capacity": 30, "registered": 28, "freeSeats": 2 },
  { "subject": "UML", "roomId": "B2", "capacity": 24, "registered": 22, "freeSeats": 2 },
  { "subject": "Testing", "roomId": "B2", "capacity": 24, "registered": 20, "freeSeats": 4 },
  { "subject": "JS", "roomId": "A1", "capacity": 30, "registered": 25, "freeSeats": 5 },
  { "subject": "Laravel", "roomId": "C3", "capacity": 40, "registered": 35, "freeSeats": 5 },
  { "subject": "Git", "roomId": "D4", "capacity": 18, "registered": 12, "freeSeats": 6 },
  { "subject": "Security", "roomId": "D4", "capacity": 18, "registered": 5, "freeSeats": 13 },
  { "subject": "SQL", "roomId": "B2", "capacity": 24, "registered": 10, "freeSeats": 14 }
]
```
(Tri : `freeSeats` croissant, puis `subject` avec `localeCompare`.)

### Constraints
- Use `map` + `filter` for invalid roomIds.

### Bonus Challenge
Flag `overbooked: true` when `registered > capacity`.

### Hints
- **Hint 1:** Index rooms by `roomId`.
- **Hint 2:** Join exam row with room capacity.
- **Hint 3:** Sort by `freeSeats` ascending.

---

## 5. Parent-teacher night slots

### Task Description
Teachers have `maxSlots`. Requests: `{ teacherId, familyName, priority }` (lower number = higher priority). Assign **at most** `maxSlots` requests per teacher in priority order. Retourner un **tableau** avec **une entrée par enseignant** du jeu `teachers` : `{ teacherId, assigned: { familyName, priority }[] }` (`assigned` vide s’il n’y a pas de demandes).

### Input Data
```json
{
  "teachers": [
    { "teacherId": 1, "maxSlots": 3 },
    { "teacherId": 2, "maxSlots": 2 },
    { "teacherId": 3, "maxSlots": 4 },
    { "teacherId": 4, "maxSlots": 3 },
    { "teacherId": 5, "maxSlots": 2 },
    { "teacherId": 6, "maxSlots": 5 },
    { "teacherId": 7, "maxSlots": 3 },
    { "teacherId": 8, "maxSlots": 2 },
    { "teacherId": 9, "maxSlots": 4 },
    { "teacherId": 10, "maxSlots": 3 }
  ],
  "requests": [
    { "teacherId": 1, "familyName": "Alami", "priority": 2 },
    { "teacherId": 1, "familyName": "Berrada", "priority": 1 },
    { "teacherId": 1, "familyName": "Chakir", "priority": 3 },
    { "teacherId": 1, "familyName": "Diouri", "priority": 4 },
    { "teacherId": 1, "familyName": "El Mansouri", "priority": 5 },
    { "teacherId": 2, "familyName": "Fassi", "priority": 1 },
    { "teacherId": 2, "familyName": "Ghazi", "priority": 2 },
    { "teacherId": 2, "familyName": "Halimi", "priority": 3 },
    { "teacherId": 2, "familyName": "Idrissi", "priority": 4 },
    { "teacherId": 1, "familyName": "Jabri", "priority": 6 }
  ]
}
```

### Expected Output
Une entrée par enseignant (`teacherId` **1** à **10**), `assigned` vide si aucune demande.

```json
[
  {
    "teacherId": 1,
    "assigned": [
      { "familyName": "Berrada", "priority": 1 },
      { "familyName": "Alami", "priority": 2 },
      { "familyName": "Chakir", "priority": 3 }
    ]
  },
  {
    "teacherId": 2,
    "assigned": [
      { "familyName": "Fassi", "priority": 1 },
      { "familyName": "Ghazi", "priority": 2 }
    ]
  },
  { "teacherId": 3, "assigned": [] },
  { "teacherId": 4, "assigned": [] },
  { "teacherId": 5, "assigned": [] },
  { "teacherId": 6, "assigned": [] },
  { "teacherId": 7, "assigned": [] },
  { "teacherId": 8, "assigned": [] },
  { "teacherId": 9, "assigned": [] },
  { "teacherId": 10, "assigned": [] }
]
```

### Constraints
- Sort requests per teacher by `priority` ascending; slice to `maxSlots`.

### Bonus Challenge
Return `waitlist` for overflow per teacher.

### Hints
- **Hint 1:** Group `requests` by `teacherId`.
- **Hint 2:** Inner sort by priority.
- **Hint 3:** Join with `teachers` to read `maxSlots`.

---

## 6. Grade inflation detector

### Task Description
Compare two exam sessions `before` and `after` (same `{ studentId, score }` students in both). Compute **delta** = after − before. Return students with **delta ≥ 5**, sorted by delta descending: `{ studentId, before, after, delta }`.

### Input Data
```json
{
  "before": [
    { "studentId": 1, "score": 10 },
    { "studentId": 2, "score": 14 },
    { "studentId": 3, "score": 12 },
    { "studentId": 4, "score": 8 },
    { "studentId": 5, "score": 15 },
    { "studentId": 6, "score": 11 },
    { "studentId": 7, "score": 9 },
    { "studentId": 8, "score": 13 },
    { "studentId": 9, "score": 10 },
    { "studentId": 10, "score": 12 }
  ],
  "after": [
    { "studentId": 1, "score": 16 },
    { "studentId": 2, "score": 15 },
    { "studentId": 3, "score": 12 },
    { "studentId": 4, "score": 14 },
    { "studentId": 5, "score": 14 },
    { "studentId": 6, "score": 17 },
    { "studentId": 7, "score": 10 },
    { "studentId": 8, "score": 13 },
    { "studentId": 9, "score": 11 },
    { "studentId": 10, "score": 12 }
  ]
}
```

### Expected Output
Delta ≥ 5 : élèves **1** (Δ6), **4** (Δ6), **6** (Δ6), tri par delta décroissant puis `studentId`.

```json
[
  { "studentId": 1, "before": 10, "after": 16, "delta": 6 },
  { "studentId": 4, "before": 8, "after": 14, "delta": 6 },
  { "studentId": 6, "before": 11, "after": 17, "delta": 6 }
]
```

### Constraints
- Index one array by `studentId` with `reduce`; O(n) total.
- Cloner au moins un objet ou tableau avec le **spread** (`{...obj}` ou `[...arr]`) pour éviter les mutations accidentelles.

### Bonus Challenge
Include cohort `medianDelta`.

### Hints
- **Hint 1:** Map `before` scores by id.
- **Hint 2:** Walk `after` and lookup before score; skip missing pairs.
- **Hint 3:** Filter `delta >= 5`, sort by `delta` desc.

---

## 7. Course prerequisites chain depth

### Task Description
`edges`: `{ course, requires }` means `course` needs `requires` first. Build **longest prerequisite depth** per course (a course with no reqs has depth 0). Detect cycles: if cycle, set `depth: null` for courses in cycle (simplified: if DFS revisits stack, null).

### Input Data
Chaîne linéaire **A → B → … → J** (`J` requiert `I`, …, `B` requiert `A`, `A` requiert `null`).

```json
[
  { "course": "A", "requires": null },
  { "course": "B", "requires": "A" },
  { "course": "C", "requires": "B" },
  { "course": "D", "requires": "C" },
  { "course": "E", "requires": "D" },
  { "course": "F", "requires": "E" },
  { "course": "G", "requires": "F" },
  { "course": "H", "requires": "G" },
  { "course": "I", "requires": "H" },
  { "course": "J", "requires": "I" }
]
```

### Expected Output
(Trier par `course` alphabétique.)

```json
[
  { "course": "A", "depth": 0 },
  { "course": "B", "depth": 1 },
  { "course": "C", "depth": 2 },
  { "course": "D", "depth": 3 },
  { "course": "E", "depth": 4 },
  { "course": "F", "depth": 5 },
  { "course": "G", "depth": 6 },
  { "course": "H", "depth": 7 },
  { "course": "I", "depth": 8 },
  { "course": "J", "depth": 9 }
]
```

### Constraints
- Implement memoized DFS from each node.

### Bonus Challenge
Return topological order array if acyclic.

### Hints
- **Hint 1:** Build adjacency backwards: course → requires.
- **Hint 2:** Depth(node) = 1 + max(depth(prereq)) or 0 if no prereq.
- **Hint 3:** Memoize results; on revisiting in recursion stack mark cycle.

---

## 8. Scholarship eligibility score

### Task Description
Rules: `attendanceRate >= 0.92`, `averageGrade >= 14`, **no** disciplinary `flags` in `{ studentId, code }[]` with `code === "MAJOR"`. Input: students with rates and averages; separate flags array. Return eligible `{ studentId, scholarshipScore }` where `scholarshipScore = averageGrade * 10 + attendanceRate * 100`, sorted by score desc.

### Input Data
```json
{
  "students": [
    { "studentId": 1, "attendanceRate": 0.95, "averageGrade": 15 },
    { "studentId": 2, "attendanceRate": 0.9, "averageGrade": 16 },
    { "studentId": 3, "attendanceRate": 0.93, "averageGrade": 14 },
    { "studentId": 4, "attendanceRate": 0.92, "averageGrade": 14 },
    { "studentId": 5, "attendanceRate": 0.88, "averageGrade": 17 },
    { "studentId": 6, "attendanceRate": 0.94, "averageGrade": 13 },
    { "studentId": 7, "attendanceRate": 0.91, "averageGrade": 15 },
    { "studentId": 8, "attendanceRate": 0.96, "averageGrade": 12 },
    { "studentId": 9, "attendanceRate": 0.925, "averageGrade": 16 },
    { "studentId": 10, "attendanceRate": 0.89, "averageGrade": 14 }
  ],
  "flags": [
    { "studentId": 1, "code": "MINOR" },
    { "studentId": 2, "code": "MINOR" },
    { "studentId": 3, "code": "MINOR" },
    { "studentId": 4, "code": "MINOR" },
    { "studentId": 5, "code": "MAJOR" },
    { "studentId": 6, "code": "MINOR" },
    { "studentId": 7, "code": "MINOR" },
    { "studentId": 8, "code": "MAJOR" },
    { "studentId": 9, "code": "MINOR" },
    { "studentId": 10, "code": "MINOR" }
  ]
}
```

### Expected Output
Éligibles : taux ≥ 0.92, moyenne ≥ 14, pas de **MAJOR**. Scores : `averageGrade*10 + attendanceRate*100`.

```json
[
  { "studentId": 9, "scholarshipScore": 252.5 },
  { "studentId": 1, "scholarshipScore": 245 },
  { "studentId": 3, "scholarshipScore": 233 },
  { "studentId": 4, "scholarshipScore": 232 }
]
```
(Éligibles : **1, 3, 4, 9** — pas de `MAJOR`, taux ≥ 0.92, moyenne ≥ 14. Ordre : score décroissant.)

### Constraints
- Use `Set` of `studentId` with major flags for O(1) lookup.

### Bonus Challenge
Minor flags reduce score by 5.

### Hints
- **Hint 1:** Filter majors into Set.
- **Hint 2:** Eligible if not in set and thresholds met.
- **Hint 3:** Compute score formula; sort numeric desc.

---

## 9. Timetable conflict check

### Task Description
Lessons: `{ classCode, weekday, startMin, endMin, roomId }`. Detect **room double-booking**: same `weekday` + `roomId` with overlapping intervals. Return pairs of **indices** in input array that conflict (with `i` strictly less than `j`), as `{ i, j, roomId, weekday }[]`.

### Input Data
```json
[
  { "classCode": "DWWM-24A", "weekday": 1, "startMin": 540, "endMin": 600, "roomId": "Lab1" },
  { "classCode": "DWWM-24B", "weekday": 1, "startMin": 570, "endMin": 630, "roomId": "Lab1" },
  { "classCode": "DWWM-24A", "weekday": 2, "startMin": 480, "endMin": 540, "roomId": "Lab2" },
  { "classCode": "DWWM-24C", "weekday": 2, "startMin": 600, "endMin": 660, "roomId": "Lab2" },
  { "classCode": "DWWM-24B", "weekday": 3, "startMin": 300, "endMin": 360, "roomId": "Lab3" },
  { "classCode": "DWWM-24A", "weekday": 3, "startMin": 330, "endMin": 390, "roomId": "Lab3" },
  { "classCode": "DWWM-24C", "weekday": 4, "startMin": 420, "endMin": 480, "roomId": "Lab1" },
  { "classCode": "DWWM-24A", "weekday": 4, "startMin": 500, "endMin": 560, "roomId": "Lab1" },
  { "classCode": "DWWM-24B", "weekday": 5, "startMin": 360, "endMin": 420, "roomId": "Lab4" },
  { "classCode": "DWWM-24C", "weekday": 5, "startMin": 400, "endMin": 460, "roomId": "Lab4" }
]
```

### Expected Output
Paires `(i,j)` avec chevauchement (même `weekday` + `roomId`) : **(0,1)**, **(4,5)**, **(8,9)**.

```json
[
  { "i": 0, "j": 1, "roomId": "Lab1", "weekday": 1 },
  { "i": 4, "j": 5, "roomId": "Lab3", "weekday": 3 },
  { "i": 8, "j": 9, "roomId": "Lab4", "weekday": 5 }
]
```

### Constraints
- Overlap iff `startA < endB && startB < endA`.

### Bonus Challenge
Also flag teacher conflicts if `teacherId` added.

### Hints
- **Hint 1:** Filter pairs same `weekday` and `roomId`.
- **Hint 2:** Brute-force O(n²) acceptable for bootcamp size.
- **Hint 3:** Push `{i,j,...}` only when `i < j` and overlap test true.

---

## 10. Dashboard KPI rollup

### Task Description
Given `sessions` `{ classCode, date, topic, durationMin }` and `grades` `{ classCode, studentId, score }`, produce one object per `classCode`: `{ classCode, totalTeachingHours: number (1 decimal), avgClassGrade: number (1 decimal), studentCount }`. `studentCount` = distinct students in that class from grades. Teaching hours = `sum(durationMin)/60`.

### Input Data
```json
{
  "sessions": [
    { "classCode": "DWWM-24A", "date": "2026-04-01", "topic": "JS", "durationMin": 60 },
    { "classCode": "DWWM-24A", "date": "2026-04-02", "topic": "PHP", "durationMin": 60 },
    { "classCode": "DWWM-24A", "date": "2026-04-03", "topic": "SQL", "durationMin": 60 },
    { "classCode": "DWWM-24A", "date": "2026-04-04", "topic": "Git", "durationMin": 60 },
    { "classCode": "DWWM-24A", "date": "2026-04-05", "topic": "UML", "durationMin": 60 },
    { "classCode": "DWWM-24A", "date": "2026-04-08", "topic": "Laravel", "durationMin": 90 },
    { "classCode": "DWWM-24A", "date": "2026-04-09", "topic": "API", "durationMin": 90 },
    { "classCode": "DWWM-24A", "date": "2026-04-10", "topic": "Docker", "durationMin": 90 },
    { "classCode": "DWWM-24A", "date": "2026-04-11", "topic": "Agile", "durationMin": 90 },
    { "classCode": "DWWM-24A", "date": "2026-04-12", "topic": "Sécurité", "durationMin": 60 }
  ],
  "grades": [
    { "classCode": "DWWM-24A", "studentId": 1, "score": 12 },
    { "classCode": "DWWM-24A", "studentId": 2, "score": 16 },
    { "classCode": "DWWM-24A", "studentId": 3, "score": 14 },
    { "classCode": "DWWM-24A", "studentId": 4, "score": 11 },
    { "classCode": "DWWM-24A", "studentId": 5, "score": 15 },
    { "classCode": "DWWM-24A", "studentId": 6, "score": 13 },
    { "classCode": "DWWM-24A", "studentId": 7, "score": 10 },
    { "classCode": "DWWM-24A", "studentId": 8, "score": 17 },
    { "classCode": "DWWM-24A", "studentId": 9, "score": 9 },
    { "classCode": "DWWM-24A", "studentId": 10, "score": 18 }
  ]
}
```

### Expected Output
Somme durées : `5×60 + 4×90 + 60` = **720 min** → **12.0 h**. Moyenne des 10 notes : **13.5**. Étudiants distincts : **10**.

```json
[
  {
    "classCode": "DWWM-24A",
    "totalTeachingHours": 12,
    "avgClassGrade": 13.5,
    "studentCount": 10
  }
]
```

### Constraints
- Use `reduce` for sums; `Set` for distinct students.

### Bonus Challenge
Break down `hoursByTopic`.

### Hints
- **Hint 1:** Two passes or two reduces: one for sessions, one for grades.
- **Hint 2:** `Set` per class for student ids.
- **Hint 3:** Round hours and average with `toFixed(1)` then `Number`.
