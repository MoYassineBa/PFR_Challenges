# SQL — Hard (10 challenges)

> **Fil Rouge / C6** — Jointures + sous-requêtes autorisées. Si une requête dépasse **trois tables** en `JOIN` simultané, prévoir une **version évaluation** en deux étapes ou CTE en chaîne courte.
>
> **Recoupement avec votre rapport**  
> - **C6** : combine **jointures** (`INNER` / `LEFT`), **sous-requêtes**, **fenêtres** (`ROW_NUMBER`, `NTILE`…), **`GROUP BY` + `HAVING`**, parfois **CTE** (`WITH`) — toujours dans un **périmètre raisonnable** pour une soutenance (pas de chaîne de 6–7 tables obligatoire en une seule requête « barème »).  
> - **Fil Rouge strict** : si un énoncé pousse trop loin, le corrigé officiel doit proposer la **variante** « **≤ 3 tables** par requête » ou **deux requêtes** successives + fusion côté app (comme indiqué dans `extreme.md` pour les pipelines).  
> - **C5 (UML)** : les jeux de tables (inscriptions, notes, salles…) sont cohérents avec un **diagramme de classes / MLD** qu’un apprenant peut défendre à l’oral.  
> - **Évaluation orale type** du CR (différence `INNER` / `LEFT`, compter par groupe, clé primaire, `DELETE` vs `TRUNCATE`, moyenne avec `AVG`) : couverte par les thèmes **#1–#7, #9–#10** en priorité.

JOINs + GROUP BY + HAVING + multi-step logic. School analytics.

---

## 1. Class average vs campus benchmark

### Task Description
Tables `students(id, campus_code)`, `grades(student_id, class_code, score)`. Per `class_code`, compute **class_avg** and **campus_avg** (average of student-level means per campus — define: average of all grades in campus). Show classes where `class_avg` **exceeds** `campus_avg` by more than 0.5.

### Input Data
```sql
CREATE TABLE students (id INT PRIMARY KEY, campus_code VARCHAR(8));
CREATE TABLE grades (id INT PRIMARY KEY, student_id INT, class_code VARCHAR(32), score DECIMAL(4,2),
  FOREIGN KEY (student_id) REFERENCES students(id));
INSERT INTO students VALUES (1,'CASA'),(2,'CASA'),(3,'RABAT');
INSERT INTO grades VALUES
 (1,1,'DWWM-24A',16),(2,2,'DWWM-24A',14),(3,3,'DWWM-24B',10);
```

### Expected Output
Depends on chosen campus_avg definition — **document in answer**: e.g. compare `AVG(score)` per class to overall `AVG(score)` for rows whose students are in same campus as majority of class — simplified pack version:

**Simplified spec:** Compare each `class_code` average to **global** `AVG(score)`; list where `class_avg - global_avg > 0.5`.

### Constraints
- Use subquery or CTE for `global_avg`.

### Bonus Challenge
True campus-level benchmark with `students.campus_code` in join.

### Hints
- **Hint 1:** CTE `class_stats AS (SELECT class_code, AVG(score) ca FROM grades GROUP BY ...)`.
- **Hint 2:** Cross join scalar global average.
- **Hint 3:** `WHERE ca - ga > 0.5`.

---

## 2. Attendance rate below 90% — HAVING

### Task Description
`attendance(student_id, class_code, day, status)`. Per `student_id` + `class_code`, compute `present_rate = SUM(status='P')/COUNT(*)`. List combos with rate **strictly below** 0.90 and at least 10 sessions.

### Input Data
```sql
CREATE TABLE attendance (
  id INT PRIMARY KEY,
  student_id INT,
  class_code VARCHAR(32),
  day DATE,
  status CHAR(1)
);
-- insert 10 rows: 8 P, 2 A for student 1 class A; etc.
```

### Expected Output
Rows meeting `HAVING COUNT(*) >= 10 AND present_rate < 0.90`.

### Constraints
- Express present count with `SUM(status='P')` (MySQL boolean) or `SUM(CASE WHEN ...)`.

### Bonus Challenge
Join `students` for `full_name`.

### Hints
- **Hint 1:** `GROUP BY student_id, class_code`.
- **Hint 2:** `HAVING` cannot use alias in MySQL — repeat expression or use outer query.
- **Hint 3:** Outer query filters on computed alias if needed.

---

## 3. Top 3 students per class by average

### Task Description
From `grades(student_id, class_code, score)`, compute each student's average per class, then **rank** top 3 per class (ties same rank allowed — use `DENSE_RANK`).

### Input Data
```sql
CREATE TABLE grades (
  id INT PRIMARY KEY,
  student_id INT,
  class_code VARCHAR(32),
  score DECIMAL(4,2)
);
INSERT INTO grades VALUES
 (1,1,'A',12),(2,1,'A',16),
 (3,2,'A',20),(4,2,'A',10),
 (5,3,'A',15),(6,3,'A',15);
```

### Expected Output
For class `A`, averages: 1→14, 2→15, 3→15. Top 3 ranks — return `class_code, student_id, avg_score, rnk` where `rnk <= 3`.

### Constraints
- Window functions: `DENSE_RANK() OVER (PARTITION BY class_code ORDER BY avg_score DESC)`.

### Bonus Challenge
Include `student_name` from `students`.

### Hints
- **Hint 1:** CTE `student_avg`.
- **Hint 2:** Second CTE with rank.
- **Hint 3:** `WHERE rnk <= 3`.

---

## 4. Teachers teaching multiple campuses

### Task Description
`teachers(id, name, campus_home)`, `class_assignments(teacher_id, class_code)`, `classes(class_code, campus_code)`. Find teachers who teach at least one class **not** on their `campus_home`.

### Input Data
```sql
CREATE TABLE teachers (id INT PRIMARY KEY, name VARCHAR(120), campus_home VARCHAR(8));
CREATE TABLE classes (class_code VARCHAR(32) PRIMARY KEY, campus_code VARCHAR(8));
CREATE TABLE class_assignments (id INT PRIMARY KEY, teacher_id INT, class_code VARCHAR(32),
  FOREIGN KEY (teacher_id) REFERENCES teachers(id),
  FOREIGN KEY (class_code) REFERENCES classes(class_code));
INSERT INTO teachers VALUES (1,'Ali','CASA');
INSERT INTO classes VALUES ('DWWM-24A','CASA'),('DWWM-24B','RABAT');
INSERT INTO class_assignments VALUES (1,1,'DWWM-24A'),(2,1,'DWWM-24B');
```

### Expected Output
| teacher_id | name |
|------------|------|
| 1          | Ali  |

### Constraints
- `JOIN` assignments to classes; `WHERE classes.campus_code <> teachers.campus_home`.

### Bonus Challenge
Distinct campus count per teacher.

### Hints
- **Hint 1:** Need at least one mismatch — `EXISTS` pattern.
- **Hint 2:** `SELECT DISTINCT teacher_id`.
- **Hint 3:** Mind NULL campus fields.

---

## 5. Exam retake candidates

### Task Description
`exam_attempts(student_id, subject_code, attempt_no, score)`. Students with **max** score still `< 10` after **2** attempts are retake candidates (need third). List `student_id, subject_code, best_score, attempts`.

### Input Data
```sql
CREATE TABLE exam_attempts (
  id INT PRIMARY KEY,
  student_id INT,
  subject_code VARCHAR(16),
  attempt_no INT,
  score DECIMAL(4,2)
);
INSERT INTO exam_attempts VALUES
 (1,1,'JS',1,8),(2,1,'JS',2,9),
 (3,2,'JS',1,12);
```

### Expected Output
| student_id | subject_code | best_score | attempts |
|------------|--------------|------------|----------|
| 1          | JS           | 9.00       | 2        |

### Constraints
- `GROUP BY student_id, subject_code` with `HAVING MAX(score) < 10 AND COUNT(*) = 2` per spec (tune if attempts >2 allowed).

### Bonus Challenge
Generalize `min_attempts` parameter via comment.

### Hints
- **Hint 1:** `MAX(score)`, `COUNT(*)`.
- **Hint 2:** `HAVING` both conditions.
- **Hint 3:** Exclude subjects already passed on earlier attempt with higher max — already covered by max score.

---

## 6. Monthly revenue by campus

### Task Description
`payments(id, campus_code, paid_on, amount)` — sum `amount` per `campus_code` per month (`YYYY-MM`), only **2026** rows.

### Input Data
```sql
CREATE TABLE payments (
  id INT PRIMARY KEY,
  campus_code VARCHAR(8),
  paid_on DATE,
  amount DECIMAL(12,2)
);
INSERT INTO payments VALUES
 (1,'CASA','2026-01-15',1000),
 (2,'CASA','2026-02-10',500),
 (3,'RABAT','2026-01-20',800);
```

### Expected Output
| campus_code | month   | total_amount |
|-------------|---------|--------------|
| CASA        | 2026-01 | 1000.00      |
| CASA        | 2026-02 | 500.00       |
| RABAT       | 2026-01 | 800.00       |

### Constraints
- `DATE_FORMAT(paid_on,'%Y-%m')` MySQL or `to_char` Postgres — pick one in solution header.

### Bonus Challenge
Pivot months as columns.

### Hints
- **Hint 1:** `GROUP BY campus_code, month_expression`.
- **Hint 2:** `SUM(amount)`.
- **Hint 3:** Filter `paid_on >= '2026-01-01' AND < '2027-01-01'`.

---

## 7. LEFT JOIN — missing grades in required subjects

### Task Description
`required_subjects(class_code, subject_code)` and `grades(student_id, class_code, subject_code, score)`. List `(student_id, class_code, subject_code)` **missing** grade rows for required pairs (student set = distinct students appearing in that class from any grade — seed via enrollments table if needed).

### Input Data
Add `enrollments(student_id, class_code)` and seed students 1 and 2 in `DWWM-24A`; require `JS` and `SQL`; only `JS` grades exist.

### Expected Output
Rows for missing `SQL` lines per student.

### Constraints
- Use `CROSS JOIN` enrollments × required minus existing grades anti-join pattern.

### Bonus Challenge
Use `EXCEPT` (Postgres) instead.

### Hints
- **Hint 1:** Build expected keys set.
- **Hint 2:** `LEFT JOIN grades ON ... IS NULL`.
- **Hint 3:** Careful with duplicates — `DISTINCT`.

---

## 8. Rolling 7-day attendance trend

### Task Description
`attendance_day(class_code, day, present_cnt, absent_cnt)`. For each `class_code`, compute **7-day rolling sum** of `present_cnt` ending each day (window frame).

### Input Data
```sql
CREATE TABLE attendance_day (
  id INT PRIMARY KEY,
  class_code VARCHAR(32),
  day DATE,
  present_cnt INT,
  absent_cnt INT
);
-- insert consecutive days with values
```

### Expected Output
| class_code | day | rolling_present_7d |
|------------|-----|--------------------|
| ...        | ... | ...                |

### Constraints
- `SUM(present_cnt) OVER (PARTITION BY class_code ORDER BY day ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)`.

### Bonus Challenge
Handle sparse dates with **calendar** gap fill (harder).

### Hints
- **Hint 1:** Window frame row-based assumes consecutive rows.
- **Hint 2:** Order by `day`.
- **Hint 3:** Document assumption.

---

## 9. Scholarship shortlist with tie ordering

### Task Description
`students(id, full_name)`, `grades(student_id, score)`, `disciplinary(student_id, points)` negative points. Score `scholarship = AVG(score) - points`. Top 5 distinct students; ties broken by **lower** `id` first.

### Input Data
```sql
CREATE TABLE students (id INT PRIMARY KEY, full_name VARCHAR(120));
CREATE TABLE grades (id INT PRIMARY KEY, student_id INT, score DECIMAL(4,2));
CREATE TABLE disciplinary (student_id INT PRIMARY KEY, points INT);
INSERT INTO students VALUES (1,'A'),(2,'B');
INSERT INTO grades VALUES (1,1,16),(2,1,14),(3,2,15),(4,2,17);
INSERT INTO disciplinary VALUES (1,0),(2,1);
```

### Expected Output
Ranked list length ≤5 with `ROW_NUMBER() ORDER BY scholarship_score DESC, id ASC`.

### Constraints
- Join disciplinary with `LEFT JOIN` default points 0.

### Bonus Challenge
Exclude students with any `disciplinary_flag='MAJOR'`.

### Hints
- **Hint 1:** CTE for averages.
- **Hint 2:** Compute scholarship in CTE.
- **Hint 3:** Window `ROW_NUMBER` filter `<=5`.

---

## 10. Recursive prerequisite depth (CTE)

### Task Description
`subject_prereq(subject_code, requires_code)` nullable `requires_code`. Compute **depth** (levels from root) for each subject. No cycles in data.

### Input Data
```sql
CREATE TABLE subject_prereq (
  subject_code VARCHAR(32) PRIMARY KEY,
  requires_code VARCHAR(32) NULL
);
INSERT INTO subject_prereq VALUES
 ('PHP-B',NULL),
 ('PHP-O','PHP-B'),
 ('Laravel','PHP-O');
```

### Expected Output
| subject_code | depth |
|--------------|-------|
| PHP-B        | 0     |
| PHP-O        | 1     |
| Laravel      | 2     |

### Constraints
- Recursive CTE `WITH RECURSIVE` (MySQL 8 / Postgres).

### Bonus Challenge
Detect cycles with iteration cap.

### Hints
- **Hint 1:** Anchor roots `requires_code IS NULL` depth 0 — actually depth 0 for no prereq subject itself; adjust: start each node walk upward counting.
- **Hint 2:** Recursive part joins `requires_code` to `subject_code`.
- **Hint 3:** Alternative: recursive from each node to roots counting steps.
