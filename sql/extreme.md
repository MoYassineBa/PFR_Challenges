# SQL — Extreme (10 challenges)

> **Fil Rouge / C6** — Les sujets « production » peuvent impliquer **plusieurs tables** : pour la **notation officielle**, livrer une variante avec **au plus trois tables** jointes par requête **ou** **deux requêtes** séquentielles documentées (même résultat métier).
>
> **Recoupement avec votre rapport**  
> - Le CR fixe un **socle C6** (jointures, agrégats, `CREATE` / `UPDATE` / `DELETE`, sous-requêtes, **peu de tables** à la fois). Les défis **Extreme** simulent plutôt la **production** (SCD type 2, pivot, qualité de données, transactions…) et peuvent **dépasser** ce socle si on les impose tels quels en une seule requête.  
> - **Usage pédagogique recommandé** : traiter **Extreme** comme **approfondissement** ou « piste senior » ; pour la **notation Fil Rouge alignée CR**, toujours fournir la **déclinaison** (découpage en requêtes courtes, **≤ 3 tables** en `JOIN`, ou script + commentaire transactionnel sans magie).  
> - **Aucun lien** avec les interdictions de **packages Laravel** (contexte SQL pur / script). **C8** reste dans `revision-quiz/`.

Multi-table pipelines, optimization, edge cases, reporting close to production.

---

## 1. SCD Type-2 class assignment history

### Task Description
Table `teacher_class_history(teacher_id, class_code, valid_from, valid_to NULL open)`. For `as_of_date = '2026-04-24'`, list active assignments. Then query **who taught DWWM-24A on 2026-01-15** historically.

### Input Data
```sql
CREATE TABLE teacher_class_history (
  id INT PRIMARY KEY,
  teacher_id INT NOT NULL,
  class_code VARCHAR(32) NOT NULL,
  valid_from DATE NOT NULL,
  valid_to DATE NULL
);
INSERT INTO teacher_class_history VALUES
 (1,10,'DWWM-24A','2026-01-01','2026-03-01'),
 (2,11,'DWWM-24A','2026-03-02',NULL);
```

### Expected Output
For `2026-01-15` → `teacher_id=10`; for `2026-04-24` → `teacher_id=11`.

### Constraints
- Predicate `(valid_to IS NULL OR as_of <= valid_to) AND as_of >= valid_from`.

### Bonus Challenge
Detect overlapping intervals for same class (data quality query).

### Hints
- **Hint 1:** Parameterize `as_of` in application; here literal.
- **Hint 2:** Mind inclusive/exclusive end — document choice.
- **Hint 3:** Index suggestion `(class_code, valid_from, valid_to)`.

---

## 2. Fair curve — rank-based grade adjustment

### Task Description
`grades(id, class_code, student_id, raw_score)`. Apply **percentile curve**: mapped_score = `10 + 10 * (percent_rank)` capped 20, where `percent_rank` is `RANK()/(COUNT()+1)` within `class_code`. Update or SELECT result set.

### Input Data
```sql
CREATE TABLE grades (
  id INT PRIMARY KEY,
  class_code VARCHAR(32),
  student_id INT,
  raw_score DECIMAL(4,2)
);
INSERT INTO grades VALUES
 (1,'A',1,8),(2,'A',2,10),(3,'A',3,12);
```

### Expected Output
Each row gains `mapped_score` per formula (document rounding).

### Constraints
- Pure SQL window functions; no procedural loops.

### Bonus Challenge
Preserve original + audit table insert.

### Hints
- **Hint 1:** `RANK() OVER (PARTITION BY class_code ORDER BY raw_score)`.
- **Hint 2:** `COUNT(*) OVER (PARTITION BY class_code)` for denominator.
- **Hint 3:** Clamp with `LEAST(20, ...)`.

---

## 3. At-risk dashboard (CTE pipeline)

### Task Description
Chain CTEs: (1) last 30d absence rate per student per class from `attendance`; (2) current weighted avg from `grades` + `subject_weights`; (3) flag `at_risk` if absence_rate > 0.15 OR weighted_avg < 10; output joined to `students` email.

### Input Data
Provide minimal 3-table synthetic dataset (10–20 rows) in challenge file for learners to paste.

### Variante Fil Rouge (évaluation C6)
Pour respecter le plafond habituel **« une requête = au plus trois tables en JOIN »** : **(A)** une requête sur `attendance` + `enrollments` + `classes` (exemple) pour les taux d’absence ; **(B)** une seconde sur `grades` + `students` (+ poids en `CASE` ou colonne déjà jointe) pour la moyenne pondérée. Fusion des résultats côté application **ou** CTE matérialisant au préalable une sous-requête à deux tables seulement.

### Expected Output
| student_id | class_code | absence_rate | weighted_avg | at_risk | email |
|------------|------------|--------------|--------------|---------|-------|

### Constraints
- Single SQL statement with ≥3 named CTEs.

### Bonus Challenge
Materialize expensive CTE comment for MySQL 8.0.31+.

### Hints
- **Hint 1:** Date filter `day >= CURRENT_DATE - INTERVAL 30 DAY` (dialect-specific).
- **Hint 2:** Weighted avg = `SUM(score*weight)/NULLIF(SUM(weight),0)`.
- **Hint 3:** Final `SELECT` combines CTEs with `LEFT JOIN`.

---

## 4. Gap fill calendar for attendance heatmap

### Task Description
Given `school_days(day)` all teaching days in April 2026 and `attendance` sparse rows, produce **every** `(student_id, day)` for students enrolled in class `A` with `status` default `'unknown'` where missing.

### Input Data
```sql
CREATE TABLE school_days (day DATE PRIMARY KEY);
CREATE TABLE enrollments (student_id INT, class_code VARCHAR(32), PRIMARY KEY(student_id, class_code));
CREATE TABLE attendance (student_id INT, day DATE, status CHAR(1), PRIMARY KEY(student_id, day));
-- seed partial attendance
```

### Expected Output
Full grid rows for April for class A students.

### Constraints
- Use recursive CTE or numbers table to generate days cross join students anti-join.

### Bonus Challenge
Mark weekends absent from `school_days` only (no weekend rows).

### Hints
- **Hint 1:** `CROSS JOIN` students in class with all school_days.
- **Hint 2:** `LEFT JOIN attendance` coalesce status.
- **Hint 3:** Watch cartesian explosion — filter class.

---

## 5. Pivot — subjects as columns

### Task Description
Normalize input `grades(student_id, subject_code, score)` into wide table **one row per student** with columns `js_score`, `sql_score`, `php_score` (NULL if missing). Fixed subject list.

### Input Data
```sql
CREATE TABLE grades (
  id INT PRIMARY KEY,
  student_id INT,
  subject_code VARCHAR(16),
  score DECIMAL(4,2)
);
INSERT INTO grades VALUES (1,1,'JS',12),(2,1,'SQL',14),(3,2,'JS',9);
```

### Expected Output
| student_id | js_score | sql_score | php_score |
|------------|----------|-----------|-----------|
| 1          | 12       | 14        | NULL      |
| 2          | 9        | NULL      | NULL      |

### Constraints
- `MAX(CASE WHEN subject_code='JS' THEN score END)` pattern.

### Bonus Challenge
Dynamic SQL for unknown subjects (procedure).

### Hints
- **Hint 1:** `GROUP BY student_id`.
- **Hint 2:** Several conditional aggregates.
- **Hint 3:** Cast types consistently.

---

## 6. Concurrent enrollment overlap detector

### Task Description
`enrollments(student_id, class_code, start_date, end_date NULL open)`. Find all **pairs** of enrollments for same student where date ranges overlap and `class_code` different.

### Input Data
```sql
CREATE TABLE enrollments (
  id INT PRIMARY KEY,
  student_id INT,
  class_code VARCHAR(32),
  start_date DATE,
  end_date DATE NULL
);
INSERT INTO enrollments VALUES
 (1,1,'A','2026-01-01','2026-06-30'),
 (2,1,'B','2026-03-01','2026-04-01');
```

### Expected Output
| student_id | class_a | class_b |
|------------|---------|---------|
| 1          | A       | B       |

### Constraints
- Self-join `e1.student_id = e2.student_id AND e1.id < e2.id` + interval overlap predicate.

### Bonus Challenge
Flag triple overlaps count.

### Hints
- **Hint 1:** `COALESCE(end_date,'9999-12-31')`.
- **Hint 2:** Overlap `e1.start <= e2.end AND e2.start <= e1.end`.
- **Hint 3:** Filter different class_code.

---

## 7. Top decile teachers by student pass rate

### Task Description
`assignments(teacher_id, class_code)`, `grades(class_code, student_id, score)` pass ≥10. Compute each teacher's **overall** pass rate across all their classes (students distinct per class). Select teachers in **top 10%** by pass rate (use `NTILE(10)`).

### Input Data
Synthetic multi-teacher dataset with clear winner.

### Expected Output
Subset of teachers with `ntile_bucket = 10`.

### Constraints
- Must use `NTILE` or percentile_cont.

### Bonus Challenge
Minimum 30 grades per teacher else exclude (`HAVING COUNT(*) >= 30`).

### Hints
- **Hint 1:** Join assignments to grades on `class_code`.
- **Hint 2:** `AVG(score >= 10)` boolean average MySQL or `SUM/COUNT`.
- **Hint 3:** Window `NTILE(10) OVER (ORDER BY pass_rate)` then filter.

---

## 8. Deadlock-safe bulk registration (transaction design)

### Task Description
**Not runnable in markdown alone** — write SQL script: `START TRANSACTION`; two sessions inserting enrollments with **opposite lock order** fixed by always locking `students` then `classes` via `SELECT ... FOR UPDATE` ordering by smaller id; demonstrate avoidance narrative + queries.

### Input Data
Tables `students`, `classes`, `enrollments` with FKs.

### Expected Output
Written exercise: script + explanation of lock ordering.

### Constraints
- Include `InnoDB` assumptions.

### Bonus Challenge
`SKIP LOCKED` queue pattern for waitlists.

### Hints
- **Hint 1:** Always `SELECT id FROM students WHERE id IN (...) ORDER BY id FOR UPDATE`.
- **Hint 2:** Then insert enrollments.
- **Hint 3:** `COMMIT`/`ROLLBACK` examples.

---

## 9. Data quality — orphan grades report

### Task Description
Write a **single** diagnostic query returning three counts: grades whose `student_id` missing in `students`; grades whose `class_code` missing in `classes`; grades whose `(student_id, class_code)` pair not in `enrollments`.

### Input Data
```sql
CREATE TABLE students (id INT PRIMARY KEY);
CREATE TABLE classes (class_code VARCHAR(32) PRIMARY KEY);
CREATE TABLE enrollments (student_id INT, class_code VARCHAR(32), PRIMARY KEY(student_id, class_code));
CREATE TABLE grades (id INT PRIMARY KEY, student_id INT, class_code VARCHAR(32), score INT);
-- mixed orphan inserts
```

### Expected Output
One row: `orphan_student | orphan_class | orphan_enrollment` counts.

### Constraints
- Use `LEFT JOIN` + conditional aggregation with `SUM(join_failed)`.

### Bonus Challenge
`UNION ALL` listing sample bad ids per category limited 5 each.

### Hints
- **Hint 1:** Three `LEFT JOIN` flags as 0/1.
- **Hint 2:** Single pass with `SUM(CASE WHEN students.id IS NULL THEN 1 END)`.
- **Hint 3:** Cross-check totals.

---

## 10. Incremental materialized summary (Postgres) / Event table (MySQL)

### Task Description
Design `grade_events(event_time, student_id, class_code, delta_score)` append-only audit. Query **current** score per `(student_id, class_code, subject)` starting from snapshot table `grades_snapshot` + replay events after snapshot timestamp — **simulate** with two `UNION ALL` parts in one query.

### Input Data
Snapshot + events deltas for a few keys.

### Expected Output
Reconciled final scores matching brute-force totals.

### Constraints
- Teach learners to `GROUP BY` combined source with `source_type` discriminator.

### Bonus Challenge
True `MATERIALIZED VIEW` refresh schedule doc.

### Hints
- **Hint 1:** `SELECT ... FROM snapshot UNION ALL SELECT ... FROM events`.
- **Hint 2:** Outer aggregate `SUM(score_component)`.
- **Hint 3:** Handle deletes as negative events extension.
