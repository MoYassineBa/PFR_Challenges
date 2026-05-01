-- SQL Hard challenges: unified schema + seed data + test queries
-- Target dialect: MySQL 8+ (uses window functions and recursive CTE).

-- =========================================================
-- 0) RESET
-- =========================================================
DROP TABLE IF EXISTS subject_prereq;
DROP TABLE IF EXISTS disciplinary;
DROP TABLE IF EXISTS attendance_day;
DROP TABLE IF EXISTS required_subjects;
DROP TABLE IF EXISTS exam_attempts;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS class_assignments;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS classes;
DROP TABLE IF EXISTS teachers;
DROP TABLE IF EXISTS grades;
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS students;

-- =========================================================
-- 1) TABLES
-- =========================================================
CREATE TABLE students (
  id INT PRIMARY KEY,
  full_name VARCHAR(120) NOT NULL,
  campus_code VARCHAR(8) NOT NULL
);

CREATE TABLE classes (
  class_code VARCHAR(32) PRIMARY KEY,
  campus_code VARCHAR(8) NOT NULL
);

CREATE TABLE enrollments (
  id INT PRIMARY KEY,
  student_id INT NOT NULL,
  class_code VARCHAR(32) NOT NULL,
  FOREIGN KEY (student_id) REFERENCES students(id),
  FOREIGN KEY (class_code) REFERENCES classes(class_code)
);

-- Shared grades table for challenges 1, 3, 7, 9.
CREATE TABLE grades (
  id INT PRIMARY KEY,
  student_id INT NOT NULL,
  class_code VARCHAR(32) NULL,
  subject_code VARCHAR(16) NULL,
  score DECIMAL(5,2) NOT NULL,
  FOREIGN KEY (student_id) REFERENCES students(id)
);

CREATE TABLE teachers (
  id INT PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  campus_home VARCHAR(8) NOT NULL
);

CREATE TABLE class_assignments (
  id INT PRIMARY KEY,
  teacher_id INT NOT NULL,
  class_code VARCHAR(32) NOT NULL,
  FOREIGN KEY (teacher_id) REFERENCES teachers(id),
  FOREIGN KEY (class_code) REFERENCES classes(class_code)
);

CREATE TABLE attendance (
  id INT PRIMARY KEY,
  student_id INT NOT NULL,
  class_code VARCHAR(32) NOT NULL,
  day DATE NOT NULL,
  status CHAR(1) NOT NULL,
  FOREIGN KEY (student_id) REFERENCES students(id),
  FOREIGN KEY (class_code) REFERENCES classes(class_code)
);

CREATE TABLE exam_attempts (
  id INT PRIMARY KEY,
  student_id INT NOT NULL,
  subject_code VARCHAR(16) NOT NULL,
  attempt_no INT NOT NULL,
  score DECIMAL(5,2) NOT NULL,
  FOREIGN KEY (student_id) REFERENCES students(id)
);

CREATE TABLE payments (
  id INT PRIMARY KEY,
  campus_code VARCHAR(8) NOT NULL,
  paid_on DATE NOT NULL,
  amount DECIMAL(12,2) NOT NULL
);

CREATE TABLE required_subjects (
  class_code VARCHAR(32) NOT NULL,
  subject_code VARCHAR(16) NOT NULL,
  PRIMARY KEY (class_code, subject_code),
  FOREIGN KEY (class_code) REFERENCES classes(class_code)
);

CREATE TABLE attendance_day (
  id INT PRIMARY KEY,
  class_code VARCHAR(32) NOT NULL,
  day DATE NOT NULL,
  present_cnt INT NOT NULL,
  absent_cnt INT NOT NULL,
  FOREIGN KEY (class_code) REFERENCES classes(class_code)
);

CREATE TABLE disciplinary (
  student_id INT PRIMARY KEY,
  points INT NOT NULL DEFAULT 0,
  FOREIGN KEY (student_id) REFERENCES students(id)
);

CREATE TABLE subject_prereq (
  subject_code VARCHAR(32) PRIMARY KEY,
  requires_code VARCHAR(32) NULL
);

-- =========================================================
-- 2) DATA ENTRY (SEED)
-- =========================================================
INSERT INTO students (id, full_name, campus_code) VALUES
  (1, 'Sara Benali', 'CASA'),
  (2, 'Omar Idrissi', 'CASA'),
  (3, 'Nora Amrani', 'RABAT'),
  (4, 'Youssef Lahlou', 'RABAT'),
  (5, 'Imane El Fassi', 'CASA'),
  (6, 'Karim Bennis', 'CASA'),
  (7, 'Lina Ait', 'RABAT'),
  (8, 'Rachid Tazi', 'CASA');

INSERT INTO classes (class_code, campus_code) VALUES
  ('DWWM-24A', 'CASA'),
  ('DWWM-24B', 'RABAT'),
  ('DWWM-24C', 'CASA');

INSERT INTO enrollments (id, student_id, class_code) VALUES
  (1,1,'DWWM-24A'),
  (2,2,'DWWM-24A'),
  (3,3,'DWWM-24B'),
  (4,4,'DWWM-24B'),
  (5,5,'DWWM-24A'),
  (6,6,'DWWM-24C'),
  (7,7,'DWWM-24C'),
  (8,8,'DWWM-24A');

INSERT INTO grades (id, student_id, class_code, subject_code, score) VALUES
  -- Class benchmark / top3 / scholarship compatible rows
  (1,1,'DWWM-24A','JS',16.00),
  (2,1,'DWWM-24A','SQL',14.00),
  (3,2,'DWWM-24A','JS',15.00),
  (4,2,'DWWM-24A','SQL',13.00),
  (5,3,'DWWM-24B','JS',10.00),
  (6,3,'DWWM-24B','SQL',11.00),
  (7,4,'DWWM-24B','JS',12.00),
  (8,4,'DWWM-24B','SQL',9.00),
  (9,5,'DWWM-24A','JS',18.00),
  (10,5,'DWWM-24A','SQL',17.00),
  (11,6,'DWWM-24C','JS',11.00),
  (12,6,'DWWM-24C','SQL',12.00),
  (13,7,'DWWM-24C','JS',14.00),
  (14,7,'DWWM-24C','SQL',13.00),
  (15,8,'DWWM-24A','JS',9.00);

INSERT INTO teachers (id, name, campus_home) VALUES
  (1,'Ali','CASA'),
  (2,'Hana','RABAT'),
  (3,'Samir','CASA');

INSERT INTO class_assignments (id, teacher_id, class_code) VALUES
  (1,1,'DWWM-24A'),
  (2,1,'DWWM-24B'), -- mismatch (CASA teacher teaching in RABAT)
  (3,2,'DWWM-24B'),
  (4,3,'DWWM-24C');

-- Challenge 2 attendance set: at least 10 sessions for some pairs
INSERT INTO attendance (id, student_id, class_code, day, status) VALUES
  (1,1,'DWWM-24A','2026-03-01','P'),
  (2,1,'DWWM-24A','2026-03-02','P'),
  (3,1,'DWWM-24A','2026-03-03','P'),
  (4,1,'DWWM-24A','2026-03-04','P'),
  (5,1,'DWWM-24A','2026-03-05','P'),
  (6,1,'DWWM-24A','2026-03-06','P'),
  (7,1,'DWWM-24A','2026-03-07','P'),
  (8,1,'DWWM-24A','2026-03-08','P'),
  (9,1,'DWWM-24A','2026-03-09','A'),
  (10,1,'DWWM-24A','2026-03-10','A'), -- 8/10 = 0.80 (below 0.90)
  (11,2,'DWWM-24A','2026-03-01','P'),
  (12,2,'DWWM-24A','2026-03-02','P'),
  (13,2,'DWWM-24A','2026-03-03','P'),
  (14,2,'DWWM-24A','2026-03-04','P'),
  (15,2,'DWWM-24A','2026-03-05','P'),
  (16,2,'DWWM-24A','2026-03-06','P'),
  (17,2,'DWWM-24A','2026-03-07','P'),
  (18,2,'DWWM-24A','2026-03-08','P'),
  (19,2,'DWWM-24A','2026-03-09','P'),
  (20,2,'DWWM-24A','2026-03-10','P'); -- 10/10 = 1.00

INSERT INTO exam_attempts (id, student_id, subject_code, attempt_no, score) VALUES
  (1,1,'JS',1,8.00),
  (2,1,'JS',2,9.00),   -- candidate
  (3,2,'JS',1,12.00),  -- passed
  (4,3,'SQL',1,7.00),
  (5,3,'SQL',2,10.00), -- passed at 2nd attempt
  (6,4,'PHP',1,6.00),
  (7,4,'PHP',2,8.50);  -- candidate

INSERT INTO payments (id, campus_code, paid_on, amount) VALUES
  (1,'CASA','2026-01-15',1000.00),
  (2,'CASA','2026-02-10',500.00),
  (3,'RABAT','2026-01-20',800.00),
  (4,'CASA','2026-02-25',250.00),
  (5,'RABAT','2026-03-05',900.00),
  (6,'CASA','2025-12-30',100.00); -- excluded by 2026 filter

INSERT INTO required_subjects (class_code, subject_code) VALUES
  ('DWWM-24A','JS'),
  ('DWWM-24A','SQL'),
  ('DWWM-24B','JS'),
  ('DWWM-24B','SQL');

INSERT INTO attendance_day (id, class_code, day, present_cnt, absent_cnt) VALUES
  (1,'DWWM-24A','2026-04-01',20,3),
  (2,'DWWM-24A','2026-04-02',21,2),
  (3,'DWWM-24A','2026-04-03',19,4),
  (4,'DWWM-24A','2026-04-04',22,1),
  (5,'DWWM-24A','2026-04-05',20,3),
  (6,'DWWM-24A','2026-04-06',18,5),
  (7,'DWWM-24A','2026-04-07',23,0),
  (8,'DWWM-24A','2026-04-08',21,2),
  (9,'DWWM-24B','2026-04-01',17,6),
  (10,'DWWM-24B','2026-04-02',18,5),
  (11,'DWWM-24B','2026-04-03',16,7),
  (12,'DWWM-24B','2026-04-04',19,4),
  (13,'DWWM-24B','2026-04-05',20,3),
  (14,'DWWM-24B','2026-04-06',18,5),
  (15,'DWWM-24B','2026-04-07',21,2),
  (16,'DWWM-24B','2026-04-08',22,1);

INSERT INTO disciplinary (student_id, points) VALUES
  (1,0),
  (2,1),
  (3,0),
  (4,2),
  (5,0),
  (6,1),
  (7,0),
  (8,3);

INSERT INTO subject_prereq (subject_code, requires_code) VALUES
  ('PHP-B',NULL),
  ('PHP-O','PHP-B'),
  ('Laravel','PHP-O'),
  ('SQL-B',NULL),
  ('SQL-A','SQL-B');

-- =========================================================
-- 3) TEST QUERIES (ONE PER HARD CHALLENGE)
-- =========================================================

-- 1) class average vs global benchmark (simplified spec)
WITH class_stats AS (
  SELECT g.class_code, AVG(g.score) AS class_avg
  FROM grades g
  GROUP BY g.class_code
),
global_stat AS (
  SELECT AVG(score) AS global_avg
  FROM grades
)
SELECT cs.class_code, ROUND(cs.class_avg,2) AS class_avg, ROUND(gs.global_avg,2) AS global_avg
FROM class_stats cs
CROSS JOIN global_stat gs
WHERE cs.class_avg - gs.global_avg > 0.5
ORDER BY cs.class_code;

-- 2) attendance rate below 90%, at least 10 sessions
SELECT a.student_id, a.class_code,
       ROUND(SUM(CASE WHEN a.status = 'P' THEN 1 ELSE 0 END) / COUNT(*), 2) AS present_rate,
       COUNT(*) AS sessions
FROM attendance a
GROUP BY a.student_id, a.class_code
HAVING COUNT(*) >= 10
   AND SUM(CASE WHEN a.status = 'P' THEN 1 ELSE 0 END) / COUNT(*) < 0.90
ORDER BY a.student_id, a.class_code;

-- 3) top 3 students per class by average
WITH student_avg AS (
  SELECT g.class_code, g.student_id, AVG(g.score) AS avg_score
  FROM grades g
  GROUP BY g.class_code, g.student_id
),
ranked AS (
  SELECT sa.class_code, sa.student_id, ROUND(sa.avg_score,2) AS avg_score,
         DENSE_RANK() OVER (
           PARTITION BY sa.class_code
           ORDER BY sa.avg_score DESC
         ) AS rnk
  FROM student_avg sa
)
SELECT class_code, student_id, avg_score, rnk
FROM ranked
WHERE rnk <= 3
ORDER BY class_code, rnk, student_id;

-- 4) teachers teaching at least one non-home campus class
SELECT DISTINCT t.id AS teacher_id, t.name
FROM teachers t
INNER JOIN class_assignments ca ON ca.teacher_id = t.id
INNER JOIN classes c ON c.class_code = ca.class_code
WHERE c.campus_code <> t.campus_home
ORDER BY t.id;

-- 5) exam retake candidates (best score < 10 after exactly 2 attempts)
SELECT ea.student_id, ea.subject_code,
       MAX(ea.score) AS best_score,
       COUNT(*) AS attempts
FROM exam_attempts ea
GROUP BY ea.student_id, ea.subject_code
HAVING MAX(ea.score) < 10
   AND COUNT(*) = 2
ORDER BY ea.student_id, ea.subject_code;

-- 6) monthly revenue by campus in 2026
SELECT p.campus_code,
       DATE_FORMAT(p.paid_on, '%Y-%m') AS month_key,
       SUM(p.amount) AS total_amount
FROM payments p
WHERE p.paid_on >= '2026-01-01'
  AND p.paid_on < '2027-01-01'
GROUP BY p.campus_code, DATE_FORMAT(p.paid_on, '%Y-%m')
ORDER BY p.campus_code, month_key;

-- 7) missing grades in required subjects (anti-join pattern)
WITH expected_pairs AS (
  SELECT DISTINCT e.student_id, e.class_code, rs.subject_code
  FROM enrollments e
  INNER JOIN required_subjects rs ON rs.class_code = e.class_code
),
existing_pairs AS (
  SELECT DISTINCT g.student_id, g.class_code, g.subject_code
  FROM grades g
  WHERE g.class_code IS NOT NULL
    AND g.subject_code IS NOT NULL
)
SELECT ep.student_id, ep.class_code, ep.subject_code
FROM expected_pairs ep
LEFT JOIN existing_pairs xp
  ON xp.student_id = ep.student_id
 AND xp.class_code = ep.class_code
 AND xp.subject_code = ep.subject_code
WHERE xp.student_id IS NULL
ORDER BY ep.class_code, ep.student_id, ep.subject_code;

-- 8) rolling 7-day present count per class
SELECT ad.class_code, ad.day,
       SUM(ad.present_cnt) OVER (
         PARTITION BY ad.class_code
         ORDER BY ad.day
         ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
       ) AS rolling_present_7d
FROM attendance_day ad
ORDER BY ad.class_code, ad.day;

-- 9) scholarship shortlist top 5 with tie ordering rule
WITH avg_scores AS (
  SELECT g.student_id, AVG(g.score) AS avg_score
  FROM grades g
  GROUP BY g.student_id
),
scored AS (
  SELECT s.id, s.full_name,
         ROUND(a.avg_score - COALESCE(d.points, 0), 2) AS scholarship_score
  FROM students s
  INNER JOIN avg_scores a ON a.student_id = s.id
  LEFT JOIN disciplinary d ON d.student_id = s.id
),
ranked AS (
  SELECT sc.*,
         ROW_NUMBER() OVER (
           ORDER BY sc.scholarship_score DESC, sc.id ASC
         ) AS rn
  FROM scored sc
)
SELECT id AS student_id, full_name, scholarship_score, rn
FROM ranked
WHERE rn <= 5
ORDER BY rn;

-- 10) recursive prerequisite depth from roots
WITH RECURSIVE prereq_tree AS (
  SELECT sp.subject_code, sp.requires_code, 0 AS depth
  FROM subject_prereq sp
  WHERE sp.requires_code IS NULL

  UNION ALL

  SELECT child.subject_code, child.requires_code, pt.depth + 1
  FROM subject_prereq child
  INNER JOIN prereq_tree pt ON child.requires_code = pt.subject_code
)
SELECT subject_code, depth
FROM prereq_tree
ORDER BY depth, subject_code;
