# JavaScript — Extreme (10 challenges)

> **Fil Rouge / C4** — Niveau **au-delà** du minimum oral ; reste centré **données / algorithmique** sans DOM. Les sujets « moteur », graphes ou machines à états servent au **perfectionnement** ou à un **track avancé**.

> **Données d’entrée :** tout **tableau JSON principal** sous `### Input Data` a une **longueur minimale de 10** (`array.length >= 10`).

Multi-step pipelines, edge cases, performance-minded patterns. School systems.

---

## 1. Multi-campus grade normalization

### Task Description
Scores are on different scales per `campusId`: `MA` uses 0–20, `CASA` uses 0–100. 
Normalize all to **0–20** with `normalized = score * 20 / maxScale`. Then compute **global** z-score per subject: `z = (x - mean) / stdDev` where mean/stdDev use all students **after normalization** for that subject. Return `{ studentId, subject, normalized, z }[]` sorted by `subject`, `studentId`. Use population stdDev (divide by N).

### Input Data
Dix lignes, toutes **JS** sur deux campus : `CASA` 75 → normalisé **15**, `CASA` 80 → **16** (échelle 0–100 → 0–20).

```json
{
  "maxScaleByCampus": { "MA": 20, "CASA": 100 },
  "rows": [
    { "studentId": 1, "subject": "JS", "campusId": "CASA", "score": 75 },
    { "studentId": 2, "subject": "JS", "campusId": "CASA", "score": 75 },
    { "studentId": 3, "subject": "JS", "campusId": "CASA", "score": 75 },
    { "studentId": 4, "subject": "JS", "campusId": "CASA", "score": 75 },
    { "studentId": 5, "subject": "JS", "campusId": "CASA", "score": 75 },
    { "studentId": 6, "subject": "JS", "campusId": "CASA", "score": 80 },
    { "studentId": 7, "subject": "JS", "campusId": "CASA", "score": 80 },
    { "studentId": 8, "subject": "JS", "campusId": "CASA", "score": 80 },
    { "studentId": 9, "subject": "JS", "campusId": "CASA", "score": 80 },
    { "studentId": 10, "subject": "JS", "campusId": "CASA", "score": 80 }
  ]
}
```
Après normalisation : cinq **15**, cinq **16**. Moyenne **15,5**, écart-type population **0,5**. z(15) = **-1**, z(16) = **+1**.

### Expected Output
```json
[
  { "studentId": 1, "subject": "JS", "normalized": 15, "z": -1 },
  { "studentId": 2, "subject": "JS", "normalized": 15, "z": -1 },
  { "studentId": 3, "subject": "JS", "normalized": 15, "z": -1 },
  { "studentId": 4, "subject": "JS", "normalized": 15, "z": -1 },
  { "studentId": 5, "subject": "JS", "normalized": 15, "z": -1 },
  { "studentId": 6, "subject": "JS", "normalized": 16, "z": 1 },
  { "studentId": 7, "subject": "JS", "normalized": 16, "z": 1 },
  { "studentId": 8, "subject": "JS", "normalized": 16, "z": 1 },
  { "studentId": 9, "subject": "JS", "normalized": 16, "z": 1 },
  { "studentId": 10, "subject": "JS", "normalized": 16, "z": 1 }
]
```
(Trier par `studentId` comme ci-dessus.)

### Constraints
- Single-pass grouping forbidden for stdDev — two passes allowed: collect normalized, then stats.

### Bonus Challenge
Winsorize outliers at ±3z before recomputing.

### Hints
- **Hint 1:** Map each row to normalized score first.
- **Hint 2:** Group by subject arrays; compute mean, then variance.
- **Hint 3:** If N=1, stdDev=0 → define z=0 to avoid NaN.

---

## 2. Fair exam seating — spread same class

### Task Description
Students `{ studentId, classCode }` take exam in `rooms[]` capacities. **Constraint:** adjacent seat indices (1..totalCapacity) must not seat two students from the **same** `classCode` when possible. Return assignment `{ seat, studentId, classCode }[]` or `null` if impossible. Use **first-fit** greedy: sort students by rare class frequency ascending, then assign smallest available seat not violating neighbor rule.

### Input Data
```json
{
  "rooms": [{ "roomId": "A", "capacity": 20 }],
  "students": [
    { "studentId": 1, "classCode": "X" },
    { "studentId": 2, "classCode": "X" },
    { "studentId": 3, "classCode": "Y" },
    { "studentId": 4, "classCode": "Y" },
    { "studentId": 5, "classCode": "Z" },
    { "studentId": 6, "classCode": "Z" },
    { "studentId": 7, "classCode": "X" },
    { "studentId": 8, "classCode": "Y" },
    { "studentId": 9, "classCode": "Z" },
    { "studentId": 10, "classCode": "X" }
  ]
}
```
Salle **capacité 20** ; 10 étudiants (X,Y,Z) — trouver une assignation sans deux **même** `classCode` sur sièges **adjacents** (sièges vides autorisés).

### Expected Output
Tout tableau de **10** assignations `{ seat, studentId, classCode }` valide (sièges dans `1..20`), sans voisins directs de même `classCode`.

### Constraints
- Document seat index gaps allowed (empty seats ok).

### Bonus Challenge
Minimize empty seats.

### Hints
- **Hint 1:** Count frequency per classCode; sort students for greedy.
- **Hint 2:** Track `assignment[seat] = classCode`.
- **Hint 3:** For each student try seats 1..capacity; check left/right neighbor classes.

---

## 3. Retake policy engine

### Task Description
Implement pure function `decideRetakes({ studentId, grades: {subject, score, weight}[], policy })` returning `{ subject, action: "none"|"retake"|"expelled" }[]`. Policy: if **weighted average** is below 10 → any subject below 8 yields **expelled** for worst subject row only; else subjects below 10 get **retake**; else **none**. Tie-break: lower subject alphabetical first for expelled marker.

### Input Data
```json
{
  "studentId": 7,
  "grades": [
    { "subject": "Agile", "score": 10, "weight": 1 },
    { "subject": "CSS", "score": 13, "weight": 1 },
    { "subject": "Docker", "score": 8, "weight": 1 },
    { "subject": "Git", "score": 10, "weight": 1 },
    { "subject": "HTML", "score": 14, "weight": 1 },
    { "subject": "JS", "score": 11, "weight": 1 },
    { "subject": "PHP", "score": 12, "weight": 1 },
    { "subject": "Security", "score": 5, "weight": 1 },
    { "subject": "SQL", "score": 7, "weight": 1 },
    { "subject": "UML", "score": 9, "weight": 1 }
  ],
  "policy": { "passAvg": 10, "failScore": 8, "retakeScore": 10 }
}
```
Tous les `weight` valent **1**. Somme des scores = **99** → moyenne **9,9** (strictement sous 10). Règle de correction **fixe** : si moyenne est strictement sous `passAvg`, alors note strictement sous `failScore` (8) → `expelled` ; note dans **[8, retakeScore)** → `retake` ; sinon `none`.

### Expected Output
```json
[
  { "subject": "Agile", "action": "none" },
  { "subject": "CSS", "action": "none" },
  { "subject": "Docker", "action": "retake" },
  { "subject": "Git", "action": "none" },
  { "subject": "HTML", "action": "none" },
  { "subject": "JS", "action": "none" },
  { "subject": "PHP", "action": "none" },
  { "subject": "Security", "action": "expelled" },
  { "subject": "SQL", "action": "expelled" },
  { "subject": "UML", "action": "retake" }
]
```

### Constraints
- No I/O; fully deterministic from inputs.

### Bonus Challenge
Support per-subject min weight.

### Hints
- **Hint 1:** Compute weighted average once.
- **Hint 2:** Branch policy tree explicitly.
- **Hint 3:** Sort output by subject name.

---

## 4. Incremental attendance stream

### Task Description
Process event log in order: `{ type: "checkIn"|"checkOut", studentId, timestampMin }`. School day is **one** session per student: first incomplete pair builds **present minutes** = checkout − checkin. Malformed: checkout before checkin → ignore checkout. Return `{ studentId, presentMinutes }` cumulative for whole log.

### Input Data
Dix événements : cinq élèves avec une paire **checkIn** / **checkOut** valide chacun.

```json
[
  { "type": "checkIn", "studentId": 1, "timestampMin": 480 },
  { "type": "checkOut", "studentId": 1, "timestampMin": 540 },
  { "type": "checkIn", "studentId": 2, "timestampMin": 550 },
  { "type": "checkOut", "studentId": 2, "timestampMin": 610 },
  { "type": "checkIn", "studentId": 3, "timestampMin": 620 },
  { "type": "checkOut", "studentId": 3, "timestampMin": 650 },
  { "type": "checkIn", "studentId": 4, "timestampMin": 700 },
  { "type": "checkOut", "studentId": 4, "timestampMin": 760 },
  { "type": "checkIn", "studentId": 5, "timestampMin": 770 },
  { "type": "checkOut", "studentId": 5, "timestampMin": 800 }
]
```

### Expected Output
```json
[
  { "studentId": 1, "presentMinutes": 60 },
  { "studentId": 2, "presentMinutes": 60 },
  { "studentId": 3, "presentMinutes": 30 },
  { "studentId": 4, "presentMinutes": 60 },
  { "studentId": 5, "presentMinutes": 30 }
]
```
(Trier par `studentId`.)

### Constraints
- O(n) streaming `reduce`; state machine per student.

### Bonus Challenge
Multiple days separated by `type: "dayBoundary"`.

### Hints
- **Hint 1:** Track `openIn` per student.
- **Hint 2:** On checkout, if no openIn, skip.
- **Hint 3:** Add `checkout - openIn` to sum; clear openIn.

---

## 5. Resource allocator (projectors)

### Task Description
`bookings`: `{ classCode, startMin, endMin, projectorsNeeded }`. `inventory`: `projectorsAvailable`. Maximize **number of fully served** bookings in given order by **greedy** allocation (cannot split projectors). If booking cannot be served, skip. Return `{ served: string[] /* classCode */, remainingProjectors }`.

### Input Data
```json
{
  "inventory": 3,
  "bookings": [
    { "classCode": "A", "startMin": 0, "endMin": 60, "projectorsNeeded": 1 },
    { "classCode": "B", "startMin": 70, "endMin": 130, "projectorsNeeded": 1 },
    { "classCode": "C", "startMin": 140, "endMin": 200, "projectorsNeeded": 1 },
    { "classCode": "D", "startMin": 210, "endMin": 270, "projectorsNeeded": 1 },
    { "classCode": "E", "startMin": 280, "endMin": 340, "projectorsNeeded": 1 },
    { "classCode": "F", "startMin": 350, "endMin": 410, "projectorsNeeded": 1 },
    { "classCode": "G", "startMin": 420, "endMin": 480, "projectorsNeeded": 1 },
    { "classCode": "H", "startMin": 490, "endMin": 550, "projectorsNeeded": 1 },
    { "classCode": "I", "startMin": 560, "endMin": 620, "projectorsNeeded": 1 },
    { "classCode": "J", "startMin": 630, "endMin": 690, "projectorsNeeded": 1 }
  ]
}
```
Créneaux **deux à deux disjoints** ; chaque réservation demande **1** projecteur. Avec **3** appareils, l’allocation gloutonne par ordre sert les **10** classes.

### Expected Output
```json
{ "served": ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"], "remainingProjectors": 3 }
```

### Constraints
- Track time intervals of allocated units; **interval graph** for identical resources.

### Bonus Challenge
Optimal max bookings (interval partitioning) — harder graph problem.

### Hints
- **Hint 1:** Model each projector timeline as array of `[endMin]` sorted.
- **Hint 2:** For each booking, assign to `needed` projectors with earliest `end <= start`.
- **Hint 3:** If fewer than `needed` free, reject booking.

---

## 6. Plagiarism cluster — similar submission hashes

### Task Description
Submissions `{ studentId, assignmentId, hash }`. **Similar** if `hash` string hamming distance ≤ 1 (same length). Build **clusters** (connected components). Return `{ clusterId, studentIds: number[] }[]` where `clusterId` is smallest `studentId` in cluster, each `studentIds` sorted.

### Input Data
```json
[
  { "studentId": 1, "assignmentId": "EX1", "hash": "aaa" },
  { "studentId": 2, "assignmentId": "EX1", "hash": "aab" },
  { "studentId": 3, "assignmentId": "EX1", "hash": "bbb" },
  { "studentId": 4, "assignmentId": "EX1", "hash": "bbc" },
  { "studentId": 5, "assignmentId": "EX1", "hash": "ccc" },
  { "studentId": 6, "assignmentId": "EX1", "hash": "ccd" },
  { "studentId": 7, "assignmentId": "EX1", "hash": "ddd" },
  { "studentId": 8, "assignmentId": "EX1", "hash": "dde" },
  { "studentId": 9, "assignmentId": "EX1", "hash": "xyz" },
  { "studentId": 10, "assignmentId": "EX1", "hash": "xyy" }
]
```

### Expected Output
```json
[
  { "clusterId": 1, "studentIds": [1, 2] },
  { "clusterId": 3, "studentIds": [3, 4] },
  { "clusterId": 5, "studentIds": [5, 6] },
  { "clusterId": 7, "studentIds": [7, 8] },
  { "clusterId": 9, "studentIds": [9, 10] }
]
```

### Constraints
- Union-Find or BFS on graph; compare pairs O(n²) for small n.

### Bonus Challenge
Use SimHash for near-duplicates.

### Hints
- **Hint 1:** Build edges if hamming ≤ 1 and same `assignmentId`.
- **Hint 2:** Union-Find parent array keyed by studentId.
- **Hint 3:** Compress paths; collect sets.

---

## 7. Academic calendar shift simulator

### Task Description
`holidays`: ISO dates no school. `lessons`: `{ date, classCode, topic }`. Shift each lesson **forward** to next weekday not in holidays, preserving order, **without** collisions per `classCode` (max one lesson per class per day). If collision, push further. Return new `lessons` array.

### Input Data
```json
{
  "holidays": ["2026-04-06"],
  "lessons": [
    { "date": "2026-04-06", "classCode": "DWWM-24A", "topic": "Git" },
    { "date": "2026-04-07", "classCode": "DWWM-24A", "topic": "JS" },
    { "date": "2026-04-07", "classCode": "DWWM-24B", "topic": "PHP" },
    { "date": "2026-04-08", "classCode": "DWWM-24A", "topic": "SQL" },
    { "date": "2026-04-08", "classCode": "DWWM-24B", "topic": "UML" },
    { "date": "2026-04-09", "classCode": "DWWM-24A", "topic": "Laravel" },
    { "date": "2026-04-09", "classCode": "DWWM-24C", "topic": "Docker" },
    { "date": "2026-04-10", "classCode": "DWWM-24B", "topic": "Agile" },
    { "date": "2026-04-10", "classCode": "DWWM-24C", "topic": "Security" },
    { "date": "2026-04-11", "classCode": "DWWM-24A", "topic": "Tests" }
  ]
}
```
`2026-04-06` est férié : décaler chaque cours touché vers le prochain jour ouvré **sans** collision par `classCode` (cf. règles de l’énoncé).

### Expected Output
Tableau de **10** leçons avec dates finales cohérentes (tri : `date`, puis `classCode`). Le corrigé compare au résultat de l’algorithme décrit (ex. **Git** 24A ne peut pas rester le 2026-04-07 si **JS** 24A y est déjà — repousser Git au premier jour libre pour 24A).

### Constraints
- Implement `nextWeekday(iso)` skipping weekends + holidays.

### Bonus Challenge
Multi-class shared room conflicts.

### Hints
- **Hint 1:** Parse dates as UTC midnight numbers or use Date carefully.
- **Hint 2:** Maintain `occupied[classCode].add(date)`.
- **Hint 3:** While date blocked, increment day.

---

## 8. Bursary proration with refunds

### Task Description
Students paid `tuitionCents`. Withdrawal on `withdrawDate` prorates refund by **completed weeks** / total `programWeeks`, rounded **down** to whole cent. If `withdrawDate` null, refund 0. Also apply **non-refundable fee** `registrationCents` never refunded. `refund = max(0, tuitionCents * completedWeeks / programWeeks - 0) - alreadyRefundedCents` capped at paid minus registration. Return ledger `{ studentId, refundCents }`.

### Input Data
```json
{
  "programWeeks": 24,
  "rows": [
    { "studentId": 1, "tuitionCents": 240000, "registrationCents": 20000, "withdrawDate": null, "alreadyRefundedCents": 0 },
    { "studentId": 2, "tuitionCents": 240000, "registrationCents": 20000, "withdrawDate": "2026-04-24", "programStart": "2026-01-01", "alreadyRefundedCents": 0 },
    { "studentId": 3, "tuitionCents": 120000, "registrationCents": 10000, "withdrawDate": null, "alreadyRefundedCents": 0 },
    { "studentId": 4, "tuitionCents": 180000, "registrationCents": 15000, "withdrawDate": null, "alreadyRefundedCents": 0 },
    { "studentId": 5, "tuitionCents": 200000, "registrationCents": 20000, "withdrawDate": null, "alreadyRefundedCents": 0 },
    { "studentId": 6, "tuitionCents": 90000, "registrationCents": 5000, "withdrawDate": null, "alreadyRefundedCents": 0 },
    { "studentId": 7, "tuitionCents": 150000, "registrationCents": 12000, "withdrawDate": null, "alreadyRefundedCents": 0 },
    { "studentId": 8, "tuitionCents": 300000, "registrationCents": 25000, "withdrawDate": null, "alreadyRefundedCents": 0 },
    { "studentId": 9, "tuitionCents": 100000, "registrationCents": 8000, "withdrawDate": null, "alreadyRefundedCents": 0 },
    { "studentId": 10, "tuitionCents": 220000, "registrationCents": 18000, "withdrawDate": null, "alreadyRefundedCents": 0 }
  ]
}
```
Définir `completedWeeks` (semaines complètes entre `programStart` et `withdrawDate`) dans le code ; sans retrait (`withdrawDate` null), **remboursement 0**.

### Expected Output
Dix lignes : `refundCents` **0** pour les élèves **1, 3–10** ; pour l’élève **2**, valeur entière selon ta règle de semaines (à documenter dans le corrigé, ex. proportion sur 24 semaines puis plafond).

### Constraints
- Integer math only (`Math.floor` on cents); document week boundary.

### Bonus Challenge
Pro-rate by teaching days instead of weeks.

### Hints
- **Hint 1:** Compute completed whole weeks safely in UTC.
- **Hint 2:** `eligible = tuition * completed / programWeeks` floored.
- **Hint 3:** Cap by `tuition - registration - alreadyRefunded`.

---

## 9. SQL-like query mini engine

### Task Description
Implement `select(records, { where, groupBy, having, agg })` supporting: `where` array of `{ field, op, value }` with ops `eq`,`gt`,`lt`; `groupBy` field name; `having` on aggregate; `agg` `{ sum: field|null, count: true }`. Input: mixed attendance+grades joined rows. Return grouped result **as JSON-safe plain objects**.

### Input Data
```json
{
  "records": [
    { "classCode": "A", "studentId": 1, "minutesLate": 10, "score": 12 },
    { "classCode": "A", "studentId": 2, "minutesLate": 0, "score": 14 },
    { "classCode": "A", "studentId": 3, "minutesLate": 5, "score": 15 },
    { "classCode": "A", "studentId": 4, "minutesLate": 2, "score": 16 },
    { "classCode": "A", "studentId": 5, "minutesLate": 8, "score": 11 },
    { "classCode": "B", "studentId": 6, "minutesLate": 3, "score": 13 },
    { "classCode": "B", "studentId": 7, "minutesLate": 0, "score": 12 },
    { "classCode": "B", "studentId": 8, "minutesLate": 15, "score": 14 },
    { "classCode": "B", "studentId": 9, "minutesLate": 1, "score": 10 },
    { "classCode": "B", "studentId": 10, "minutesLate": 4, "score": 9 }
  ],
  "query": {
    "where": [{ "field": "score", "op": "gt", "value": 10 }],
    "groupBy": "classCode",
    "having": { "field": "count", "op": "gt", "value": 1 },
    "agg": { "sum": "minutesLate", "count": true }
  }
}
```

### Expected Output
```json
[
  { "classCode": "A", "sum_minutesLate": 17, "count": 4 },
  { "classCode": "B", "sum_minutesLate": 18, "count": 3 }
]
```

### Constraints
- No `eval`; parse ops via switch.

### Bonus Challenge
Add `avg`.

### Hints
- **Hint 1:** Filter stage, then reduce groupBy key.
- **Hint 2:** Track `{ sum, count }` per group.
- **Hint 3:** Apply having last.

---

## 10. Real-time hall pass validator

### Task Description
State machine: initial `atDesk`. Events `{ studentId, t, type: "request"|"approve"|"deny"|"return" }`. Rules: `request` from desk → `pending`; `approve` moves `outUntil` = t + `maxOutMin`; `deny` → desk; `return` before deadline → desk; if `t > outUntil` while out → `late` terminal. Return final `{ studentId, status, lateMinutes? }`.

### Input Data
```json
{
  "maxOutMin": 15,
  "events": [
    { "studentId": 1, "t": 0, "type": "request" },
    { "studentId": 1, "t": 1, "type": "approve" },
    { "studentId": 1, "t": 30, "type": "return" },
    { "studentId": 2, "t": 5, "type": "request" },
    { "studentId": 2, "t": 6, "type": "deny" },
    { "studentId": 3, "t": 10, "type": "request" },
    { "studentId": 3, "t": 11, "type": "approve" },
    { "studentId": 3, "t": 20, "type": "return" },
    { "studentId": 4, "t": 40, "type": "request" },
    { "studentId": 4, "t": 41, "type": "approve" }
  ]
}
```

### Expected Output
États finaux : **1** retour tardif (`late`, 14 min de retard) ; **2** refusé → `atDesk` ; **3** retour à temps → `atDesk` ; **4** approuvé mais pas encore retour → `out` (ou statut équivalent selon ta spec).

```json
[
  { "studentId": 1, "status": "late", "lateMinutes": 14 },
  { "studentId": 2, "status": "atDesk" },
  { "studentId": 3, "status": "atDesk" },
  { "studentId": 4, "status": "out" }
]
```
(Ajuster les libellés de statut pour coller à ton automate documenté.)

### Constraints
- Process events sorted by `t`; invalid sequences ignored per spec comment.

### Bonus Challenge
Multiple students interleaved.

### Hints
- **Hint 1:** Track `phase`, `deadline`, `outStart`.
- **Hint 2:** On return compare `t` to deadline.
- **Hint 3:** `lateMinutes = max(0, t - deadline)`.
