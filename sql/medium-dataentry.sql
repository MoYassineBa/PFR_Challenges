-- SQL Medium challenges: unified schema + seed data + test queries
-- Compatible with MySQL 8+ (also largely PostgreSQL-friendly with minor type tweaks).

-- =========================================================
-- 0) RESET (safe order for FKs)
-- =========================================================
DROP TABLE IF EXISTS teacher_subject;
DROP TABLE IF EXISTS subjects;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS invoices;
DROP TABLE IF EXISTS exam_registrations;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS exams;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS class_assignments;
DROP TABLE IF EXISTS teachers;
DROP TABLE IF EXISTS grades;
DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS classes;
DROP TABLE IF EXISTS students;

-- =========================================================
-- 1) CORE TABLES
-- =========================================================
CREATE TABLE students (
  id INT PRIMARY KEY,
  full_name VARCHAR(120) NOT NULL,
  email VARCHAR(120) NOT NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1
);

CREATE TABLE classes (
  class_code VARCHAR(32) PRIMARY KEY,
  title VARCHAR(120) NOT NULL
);

CREATE TABLE enrollments (
  id INT PRIMARY KEY,
  student_id INT NOT NULL,
  class_code VARCHAR(32) NOT NULL,
  status VARCHAR(16) NOT NULL,
  FOREIGN KEY (student_id) REFERENCES students(id),
  FOREIGN KEY (class_code) REFERENCES classes(class_code)
);

CREATE TABLE grades (
  id INT PRIMARY KEY,
  student_id INT NOT NULL,
  subject_code VARCHAR(16) NOT NULL,
  score DECIMAL(4,2) NOT NULL
);

CREATE TABLE teachers (
  id INT PRIMARY KEY,
  name VARCHAR(120) NOT NULL
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
  day DATE NOT NULL,
  status CHAR(1) NOT NULL
);

CREATE TABLE exams (
  id INT PRIMARY KEY,
  student_id INT NOT NULL,
  taken_on DATE NOT NULL,
  score DECIMAL(4,2) NOT NULL
);

CREATE TABLE rooms (
  room_id VARCHAR(8) PRIMARY KEY,
  capacity INT NOT NULL
);

CREATE TABLE exam_registrations (
  id INT PRIMARY KEY,
  room_id VARCHAR(8) NOT NULL,
  exam_id INT NOT NULL,
  student_id INT NOT NULL,
  FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

CREATE TABLE invoices (
  id INT PRIMARY KEY,
  student_id INT NOT NULL,
  amount_due DECIMAL(10,2) NOT NULL
);

CREATE TABLE payments (
  id INT PRIMARY KEY,
  student_id INT NOT NULL,
  amount_paid DECIMAL(10,2) NOT NULL
);

CREATE TABLE subjects (
  subject_code VARCHAR(16) PRIMARY KEY,
  name VARCHAR(120) NOT NULL
);

CREATE TABLE teacher_subject (
  teacher_id INT NOT NULL,
  subject_code VARCHAR(16) NOT NULL,
  PRIMARY KEY (teacher_id, subject_code),
  FOREIGN KEY (subject_code) REFERENCES subjects(subject_code)
);

-- =========================================================
-- 2) DATA ENTRY (seed)
-- =========================================================
INSERT INTO students (id, full_name, email, is_active) VALUES
  (1,'Sara Benali','sara@school.ma',1),
  (2,'Omar Idrissi','omar@school.ma',0),
  (3,'Nora Amrani','nora@school.ma',1),
  (4,'Youssef Lahlou','youssef@school.ma',1),
  (5,'Imane El Fassi','imane@school.ma',1),
  (6,'Karim Bennis','karim@school.ma',1),
  (7,'Lina Ait','lina@school.ma',1),
  (8,'Rachid Tazi','rachid@school.ma',1);

INSERT INTO classes (class_code, title) VALUES
  ('DWWM-24A','Web Dev'),
  ('DWWM-24B','Web Dev B'),
  ('DWWM-24C','Data Basics');

INSERT INTO enrollments (id, student_id, class_code, status) VALUES
  (10,1,'DWWM-24A','active'),
  (11,2,'DWWM-24A','active'),
  (12,3,'DWWM-24A','active'),
  (13,4,'DWWM-24B','withdrawn'),
  (14,5,'DWWM-24B','active'),
  (15,6,'DWWM-24C','active'),
  (16,7,'DWWM-24A','active'),
  (17,8,'DWWM-24C','active');

INSERT INTO grades (id, student_id, subject_code, score) VALUES
  (1,1,'JS',12.00),
  (2,1,'JS',16.00),
  (3,2,'SQL',10.00),
  (4,3,'SQL',14.00),
  (5,7,'JS',9.00),
  (6,7,'SQL',12.00),
  (7,8,'JS',15.00),
  (8,5,'PHP',13.00),
  (9,6,'PHP',11.00);

INSERT INTO teachers (id, name) VALUES
  (1,'Mr. Ali'),
  (2,'Ms. Hana'),
  (3,'Mr. Samir'),
  (5,'Dr. Nadia');

INSERT INTO class_assignments (id, teacher_id, class_code) VALUES
  (9,1,'DWWM-24A'),
  (10,3,'DWWM-24B');

INSERT INTO attendance (id, student_id, day, status) VALUES
  (1,5,'2026-04-01','P'),
  (2,5,'2026-04-02','A'),
  (3,5,'2026-04-03','A'),
  (4,1,'2026-04-02','A'),
  (5,1,'2026-04-05','P'),
  (6,7,'2026-04-04','A'),
  (7,7,'2026-05-02','A');

INSERT INTO exams (id, student_id, taken_on, score) VALUES
  (1,1,'2026-03-01',10.00),
  (2,1,'2026-04-01',14.00),
  (3,2,'2026-04-01',11.00),
  (4,2,'2026-04-01',12.00), -- tie on date, larger id should win
  (5,3,'2026-03-15',13.50);

INSERT INTO rooms (room_id, capacity) VALUES
  ('A1',30),
  ('B2',24),
  ('C3',18);

INSERT INTO exam_registrations (id, room_id, exam_id, student_id) VALUES
  (1,'A1',101,1),
  (2,'A1',101,2),
  (3,'B2',101,3),
  (4,'B2',102,4),
  (5,'C3',101,5),
  (6,'C3',101,6),
  (7,'C3',101,7);

INSERT INTO invoices (id, student_id, amount_due) VALUES
  (1,3,5000.00),
  (2,4,3000.00),
  (3,5,4500.00);

INSERT INTO payments (id, student_id, amount_paid) VALUES
  (1,3,2000.00),
  (2,4,3000.00),
  (3,5,1000.00),
  (4,6,700.00);

INSERT INTO subjects (subject_code, name) VALUES
  ('JS','JavaScript'),
  ('SQL','Databases'),
  ('PHP','PHP Backend');

INSERT INTO teacher_subject (teacher_id, subject_code) VALUES
  (5,'JS'),
  (5,'SQL'),
  (3,'PHP');

-- =========================================================
-- 3) TEST QUERIES (one per challenge)
-- =========================================================

-- Challenge 1: active students in DWWM-24A
SELECT s.full_name, s.email
FROM students s
INNER JOIN enrollments e ON e.student_id = s.id
WHERE e.class_code = 'DWWM-24A'
  AND e.status = 'active'
  AND s.is_active = 1
ORDER BY s.full_name;

-- Challenge 2: average grade per subject
SELECT g.subject_code, ROUND(AVG(g.score), 2) AS avg_score
FROM grades g
GROUP BY g.subject_code
ORDER BY g.subject_code;

-- Challenge 3: teachers without assignment
SELECT t.id, t.name
FROM teachers t
LEFT JOIN class_assignments ca ON ca.teacher_id = t.id
WHERE ca.id IS NULL
ORDER BY t.id;

-- Challenge 4: absences in April 2026
SELECT a.student_id, COUNT(*) AS absence_count
FROM attendance a
WHERE a.day BETWEEN '2026-04-01' AND '2026-04-30'
  AND a.status = 'A'
GROUP BY a.student_id
ORDER BY a.student_id;

-- Challenge 5: active enrollments per class (including zero)
SELECT c.title, c.class_code,
       SUM(CASE WHEN e.status = 'active' THEN 1 ELSE 0 END) AS active_enrollments
FROM classes c
LEFT JOIN enrollments e ON e.class_code = c.class_code
GROUP BY c.class_code, c.title
ORDER BY c.class_code;

-- Challenge 6: latest exam score per student (tie-break id desc)
SELECT x.student_id, x.taken_on, x.score
FROM (
  SELECT e.*,
         ROW_NUMBER() OVER (
           PARTITION BY e.student_id
           ORDER BY e.taken_on DESC, e.id DESC
         ) AS rn
  FROM exams e
) x
WHERE x.rn = 1
ORDER BY x.student_id;

-- Challenge 7: students failing at least one subject
SELECT DISTINCT g.student_id
FROM grades g
WHERE g.score < 10
ORDER BY g.student_id;

-- Challenge 8: classroom free seats for exam 101
SELECT r.room_id, r.capacity - COUNT(er.student_id) AS free_seats
FROM rooms r
LEFT JOIN exam_registrations er
  ON er.room_id = r.room_id
 AND er.exam_id = 101
GROUP BY r.room_id, r.capacity
ORDER BY r.room_id;

-- Challenge 9: tuition balance (due - paid), MySQL-compatible union pattern
SELECT ids.student_id,
       COALESCE(d.sum_due, 0) - COALESCE(p.sum_paid, 0) AS balance
FROM (
  SELECT student_id FROM invoices
  UNION
  SELECT student_id FROM payments
) ids
LEFT JOIN (
  SELECT student_id, SUM(amount_due) AS sum_due
  FROM invoices
  GROUP BY student_id
) d ON d.student_id = ids.student_id
LEFT JOIN (
  SELECT student_id, SUM(amount_paid) AS sum_paid
  FROM payments
  GROUP BY student_id
) p ON p.student_id = ids.student_id
ORDER BY ids.student_id;

-- Challenge 10: subjects taught by teacher 5
SELECT s.name
FROM teacher_subject ts
INNER JOIN subjects s ON s.subject_code = ts.subject_code
WHERE ts.teacher_id = 5
ORDER BY s.name;
