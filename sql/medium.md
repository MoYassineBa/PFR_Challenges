# SQL — Medium (10 challenges)

> **Fil Rouge / C6** — Au moins une **jointure** ; viser des requêtes sur **2 à 3 tables** ; `GROUP BY` / `HAVING` / agrégats ; jeux de données avec **INSERT** ; les corrigés peuvent inclure **UPDATE** / **DELETE** sur tables de test.
>
> **Recoupement avec votre rapport (2ᵉ année / Fil Rouge)**  
> - **C6 — mise en situation** du compte rendu : **au moins une jointure** ; **fonctions d’agrégation**, **`GROUP BY`**, **`HAVING`** ; possibilité **`CREATE`** (schémas + `INSERT` fournis ici), et les corrigés type peuvent ajouter **`UPDATE`** / **`DELETE`** sur données de test ; **sous-requêtes** acceptées comme alternative aux jointures — la majorité des défis Medium s’inscrivent dans ce cadre (**2–3 tables**).  
> - **« Maximum une jointure sur trois tables »** (formulation du CR) : interprétation pratique = **ne pas exploser** une seule requête d’évaluation au-delà d’environ **trois tables** jointes ; rester sur des schémas **scolaires** lisibles (élèves, cours, notes, présences…).  
> - **Minimum C6** : opérations de base + jointures simples + culture BD — objectif de ce fichier.  
> - **Hors périmètre** : packages Laravel interdits (**N/A** en SQL pur) ; **C8** Docker → `revision-quiz/` ; **C5** UML : les schémas SQL peuvent illustrer le **MCD / MLD** en soutenance mais ne sont pas notés dans ce dépôt.

2–3 tables, INNER/LEFT JOIN, basic GROUP BY / aggregates. MySQL 8 / PostgreSQL compatible unless noted.

---

## 1. Class roster with emails

### Task Description
List all **active** students in class `DWWM-24A` with email. Schema provided below.

### Input Data
```sql
CREATE TABLE students (
  id INT PRIMARY KEY,
  full_name VARCHAR(120) NOT NULL,
  email VARCHAR(120) NOT NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1
);
CREATE TABLE enrollments (
  id INT PRIMARY KEY,
  student_id INT NOT NULL,
  class_code VARCHAR(32) NOT NULL,
  status VARCHAR(16) NOT NULL,
  FOREIGN KEY (student_id) REFERENCES students(id)
);
INSERT INTO students VALUES
 (1,'Sara Benali','sara@school.ma',1),
 (2,'Omar Idrissi','omar@school.ma',0);
INSERT INTO enrollments VALUES
 (10,1,'DWWM-24A','active'),
 (11,2,'DWWM-24A','active');
```

### Expected Output
| full_name   | email          |
|-------------|----------------|
| Sara Benali | sara@school.ma |

### Constraints
- Use `INNER JOIN`; filter `is_active = 1` and enrollment `status='active'`.

### Bonus Challenge
Also show `enrollment_id`.

### Hints
- **Hint 1:** Join on `students.id = enrollments.student_id`.
- **Hint 2:** `WHERE class_code = ? AND enrollments.status = 'active'`.
- **Hint 3:** Exclude inactive students explicitly.

---

## 2. Average grade per subject

### Task Description
Tables `grades(student_id, subject_code, score)` and optional `subjects` not required — use `subject_code`. Compute **average** score per `subject_code` rounded to 2 decimals.

### Input Data
```sql
CREATE TABLE grades (
  id INT PRIMARY KEY,
  student_id INT NOT NULL,
  subject_code VARCHAR(16) NOT NULL,
  score DECIMAL(4,2) NOT NULL
);
INSERT INTO grades VALUES
 (1,1,'JS',12.00),(2,1,'JS',16.00),(3,2,'SQL',10.00);
```

### Expected Output
| subject_code | avg_score |
|--------------|-----------|
| JS           | 14.00     |
| SQL          | 10.00     |

### Constraints
- `GROUP BY subject_code`; use `ROUND(AVG(score),2)`.

### Bonus Challenge
Only subjects with at least 2 grades.

### Hints
- **Hint 1:** `AVG` aggregate.
- **Hint 2:** Alias for readability.
- **Hint 3:** `ORDER BY subject_code`.

---

## 3. Teachers without any class assignment

### Task Description
`teachers(id,name)` and `class_assignments(teacher_id, class_code)`. List teachers with **no** rows in assignments (LEFT JOIN + NULL check).

### Input Data
```sql
CREATE TABLE teachers (id INT PRIMARY KEY, name VARCHAR(120));
CREATE TABLE class_assignments (id INT PRIMARY KEY, teacher_id INT, class_code VARCHAR(32),
  FOREIGN KEY (teacher_id) REFERENCES teachers(id));
INSERT INTO teachers VALUES (1,'Mr. Ali'),(2,'Ms. Hana');
INSERT INTO class_assignments VALUES (9,1,'DWWM-24A');
```

### Expected Output
| id | name    |
|----|---------|
| 2  | Ms. Hana |

### Constraints
- `LEFT JOIN` and `WHERE class_assignments.id IS NULL`.

### Bonus Challenge
Use `NOT EXISTS` variant in comment compare performance.

### Hints
- **Hint 1:** Left join assignments.
- **Hint 2:** Filter where assignment key null.
- **Hint 3:** Mind duplicates if multiple joins — assignments unique per teacher ok here.

---

## 4. Total absences per student this month

### Task Description
`attendance(id, student_id, day, status)` with `status` in (`'P','A'`). Count **absences** (`'A'`) in April 2026.

### Input Data
```sql
CREATE TABLE attendance (
  id INT PRIMARY KEY,
  student_id INT NOT NULL,
  day DATE NOT NULL,
  status CHAR(1) NOT NULL
);
INSERT INTO attendance VALUES
 (1,5,'2026-04-01','P'),(2,5,'2026-04-02','A'),(3,5,'2026-04-03','A');
```

### Expected Output
| student_id | absence_count |
|------------|---------------|
| 5          | 2             |

### Constraints
- `WHERE day BETWEEN '2026-04-01' AND '2026-04-30' AND status='A'`.

### Bonus Challenge
Join `students` to show name.

### Hints
- **Hint 1:** `COUNT(*)`.
- **Hint 2:** `GROUP BY student_id`.
- **Hint 3:** `HAVING` if filter students with > N absences.

---

## 5. Courses with enrollment count

### Task Description
`classes(class_code, title)` and `enrollments(class_code, student_id, status)`. Show each class **title** and count of **active** enrollments.

### Input Data
```sql
CREATE TABLE classes (class_code VARCHAR(32) PRIMARY KEY, title VARCHAR(120));
CREATE TABLE enrollments (id INT PRIMARY KEY, class_code VARCHAR(32), student_id INT, status VARCHAR(16),
  FOREIGN KEY (class_code) REFERENCES classes(class_code));
INSERT INTO classes VALUES ('DWWM-24A','Web Dev'),('DWWM-24B','Web Dev B');
INSERT INTO enrollments VALUES (1,'DWWM-24A',1,'active'),(2,'DWWM-24A',2,'active'),(3,'DWWM-24B',3,'withdrawn');
```

### Expected Output
| title   | class_code | active_enrollments |
|---------|------------|--------------------|
| Web Dev | DWWM-24A   | 2                  |
| Web Dev B | DWWM-24B | 0                  |

### Constraints
- `LEFT JOIN` from `classes` to enrollments so zero counts appear.

### Bonus Challenge
`COUNT(DISTINCT student_id)` to avoid duplicate rows.

### Hints
- **Hint 1:** Conditional count `SUM(status='active')` or `COUNT` with `CASE`.
- **Hint 2:** `LEFT JOIN` preserves classes with zero.
- **Hint 3:** `GROUP BY classes.class_code, title`.

---

## 6. Latest exam score per student

### Task Description
`exams(id, student_id, taken_on, score)`. For each `student_id`, return the row with **latest** `taken_on` (tie-break highest `id`).

### Input Data
```sql
CREATE TABLE exams (
  id INT PRIMARY KEY,
  student_id INT NOT NULL,
  taken_on DATE NOT NULL,
  score DECIMAL(4,2) NOT NULL
);
INSERT INTO exams VALUES
 (1,1,'2026-03-01',10),(2,1,'2026-04-01',14),(3,2,'2026-04-01',11);
```

### Expected Output
| student_id | taken_on   | score |
|------------|------------|-------|
| 1          | 2026-04-01 | 14.00 |
| 2          | 2026-04-01 | 11.00 |

### Constraints
- Use window `ROW_NUMBER()` partitioned by `student_id`.

### Bonus Challenge
Rewrite with correlated subquery.

### Hints
- **Hint 1:** `ROW_NUMBER() OVER (PARTITION BY student_id ORDER BY taken_on DESC, id DESC)`.
- **Hint 2:** Wrap subquery filter `rn=1`.
- **Hint 3:** MySQL 8+ required for window functions.

---

## 7. Students failing at least one subject

### Task Description
`grades(student_id, subject_code, score)` passing is `score >= 10`. Return distinct `student_id` failing **any** subject.

### Input Data
```sql
CREATE TABLE grades (
  id INT PRIMARY KEY,
  student_id INT NOT NULL,
  subject_code VARCHAR(16) NOT NULL,
  score DECIMAL(4,2) NOT NULL
);
INSERT INTO grades VALUES
 (1,7,'JS',9),(2,7,'SQL',12),(3,8,'JS',15);
```

### Expected Output
| student_id |
|------------|
| 7          |

### Constraints
- `SELECT DISTINCT`; simple `WHERE score < 10`.

### Bonus Challenge
List failing subjects concatenated (`GROUP_CONCAT`).

### Hints
- **Hint 1:** Filter grades below threshold.
- **Hint 2:** Distinct students.
- **Hint 3:** No join needed unless adding names.

---

## 8. Classroom capacity headroom

### Task Description
`rooms(room_id, capacity)` and `exam_registrations(room_id, exam_id, student_id)`. Compute `free_seats = capacity - registered` for `exam_id = 101`.

### Input Data
```sql
CREATE TABLE rooms (room_id VARCHAR(8) PRIMARY KEY, capacity INT);
CREATE TABLE exam_registrations (
  id INT PRIMARY KEY,
  room_id VARCHAR(8),
  exam_id INT,
  student_id INT,
  FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);
INSERT INTO rooms VALUES ('A1',30),('B2',24);
INSERT INTO exam_registrations VALUES
 (1,'A1',101,1),(2,'A1',101,2),(3,'B2',101,3);
```

### Expected Output
| room_id | free_seats |
|---------|------------|
| A1      | 28         |
| B2      | 23         |

### Constraints
- `JOIN` + `COUNT(student_id)` grouped by room.

### Bonus Challenge
Filter rooms with `free_seats < 5`.

### Hints
- **Hint 1:** `WHERE exam_id=101` inside join or subquery.
- **Hint 2:** `capacity - COUNT(*)`.
- **Hint 3:** Group by `room_id, capacity`.

---

## 9. Payments vs tuition balance

### Task Description
`invoices(student_id, amount_due)` and `payments(student_id, amount_paid)`. Net balance per student: `due - paid`.

### Input Data
```sql
CREATE TABLE invoices (id INT PRIMARY KEY, student_id INT, amount_due DECIMAL(10,2));
CREATE TABLE payments (id INT PRIMARY KEY, student_id INT, amount_paid DECIMAL(10,2));
INSERT INTO invoices VALUES (1,3,5000),(2,4,3000);
INSERT INTO payments VALUES (1,3,2000),(2,4,3000);
```

### Expected Output
| student_id | balance |
|------------|---------|
| 3          | 3000.00 |
| 4          | 0.00    |

### Constraints
- Aggregate sums per table then join on `student_id` (FULL outer via union trick in MySQL).

### Bonus Challenge
Show only `balance > 0`.

### Hints
- **Hint 1:** Subquery `sum_due`, `sum_paid`.
- **Hint 2:** `COALESCE(paid,0)`.
- **Hint 3:** Union student ids from both sides.

---

## 10. Subject taught by teacher (bridge table)

### Task Description
`teacher_subject(teacher_id, subject_code)` and `subjects(subject_code, name)`. List subject **names** for `teacher_id = 5`.

### Input Data
```sql
CREATE TABLE subjects (subject_code VARCHAR(16) PRIMARY KEY, name VARCHAR(120));
CREATE TABLE teacher_subject (teacher_id INT, subject_code VARCHAR(16),
  PRIMARY KEY (teacher_id, subject_code),
  FOREIGN KEY (subject_code) REFERENCES subjects(subject_code));
INSERT INTO subjects VALUES ('JS','JavaScript'),('SQL','Databases');
INSERT INTO teacher_subject VALUES (5,'JS'),(5,'SQL');
```

### Expected Output
| name        |
|-------------|
| Databases   |
| JavaScript  |

### Constraints
- `ORDER BY name`.

### Bonus Challenge
Count teachers per subject.

### Hints
- **Hint 1:** Join bridge to subjects.
- **Hint 2:** Filter teacher id.
- **Hint 3:** INNER JOIN ensures valid codes.
