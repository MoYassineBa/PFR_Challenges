# PHP OOP — Hard (10 challenges)

> **Fil Rouge / C7** — Héritage, interfaces, polymorphisme, composition. Les énoncés restent **argumentables en soutenance** (diagramme de classes). Préférer **peu de boucles** : déléguer à des collaborateurs typés.
>
> **Recoupement avec votre rapport**  
> - **C7 « mise en situation »** : **héritage** (#1 Personne → Étudiant/Formateur), **abstraction** (classe abstraite, méthodes abstraites), **interfaces + polymorphisme** (#2 Gradable, #4 Notifier, #7 règles de frais, #9 politique de présence, #10 template method), **composition / agrégation** (#3 salle–élèves, #6 créneaux, #8 carnet de notes).  
> - **« Une seule boucle » / logique simple** : consigne dans les en-têtes ; les corrigés type doivent éviter les **imbriquées** et les gros `for` sur la logique métier (préférer petits services / collections typées).  
> - **Questions orales type** du CR (interface vs classe abstraite, encapsulation, polymorphisme) : adossées aux défis **#1–#4, #7–#9** en priorité.

Inheritance, interfaces, composition, polymorphism. School management modeling.

---

## 1. Person hierarchy — Student / Teacher

### Task Description
Abstract `Person` with `id`, `fullName`, abstract `roleLabel(): string`. `Student` returns `"Student"`; `Teacher` returns `"Teacher"`. Shared `displayName(): string` returns `"[ROLE] fullName"`.

### Input Data
```php
$s = new Student(1, "Imane El Fassi");
$t = new Teacher(2, "Karim Bennis");
```

### Expected Output
`$s->displayName()` → `"[Student] Imane El Fassi"`; teacher analog.

### Constraints
- `Person` cannot be instantiated directly.

### Bonus Challenge
Interface `Notifiable` with `email(): string` implemented differently.

### Hints
- **Hint 1:** `abstract class Person`.
- **Hint 2:** Call `$this->roleLabel()` inside concrete template method.
- **Hint 3:** `final` on leaf classes if desired.

---

## 2. Gradable interface + polymorphic reports

### Task Description
Interface `Gradable { public function maxScore(): float; public function weight(): float; }`. Classes `WrittenExam` and `Project` implement it. `ReportCard::weightedTotal(Gradable ...$items): float` sums `score/max * weight` (scores passed separately OR embed — choose one design and document).

### Input Data
Provide `WrittenExam` max 20 weight 2; `Project` max 100 weight 1; scores 16 and 80.

### Expected Output
`(16/20)*2 + (80/100)*1 = 2.4 + 0.8 = 3.2` if normalized to weight sum — **define** formula in README of your solution: e.g. divide by total weight for GPA-like 0–20.

### Constraints
- Type hint `Gradable` in aggregator; no `instanceof` chains.

### Bonus Challenge
Strategy `NormalizationStrategy` interface.

### Hints
- **Hint 1:** Pass `(Gradable $item, float $score)` pairs via small DTO.
- **Hint 2:** Loop with interface types only.
- **Hint 3:** Extract `scoreRatio` private method.

---

## 3. Classroom composition + roster

### Task Description
`ClassRoom` **aggregates** `Student[]` (references, not ownership of life cycle). Methods `addStudent(Student $s)`, `removeStudent(int $id)`, `count(): int`, `getRoster(): Student[]` copy.

### Input Data
External `$alice` reused in two classrooms attempt — **prevent** duplicate same object in same class only.

### Expected Output
Second `addStudent($alice)` to same room throws or returns false per your choice — document.

### Constraints
- Identity equality `===` for duplicate detection.

### Bonus Challenge
`transferTo(ClassRoom $other, int $studentId)`.

### Hints
- **Hint 1:** Private array `list<Student>`.
- **Hint 2:** `spl_object_id` optional; `in_array` strict true.
- **Hint 3:** Return clone of array from `getRoster`.

---

## 4. Notification pipeline (interface + decorator)

### Task Description
Interface `Notifier { public function send(Student $to, string $message): void; }`. `EmailNotifier` writes to array sink. `LoggingNotifier` **decorates** another `Notifier` and records each call. Compose `new LoggingNotifier(new EmailNotifier($sink))`.

### Input Data
Send `"Parent meeting"` to a student.

### Expected Output
Sink contains message; log contains metadata count 1.

### Constraints
- Decorator holds inner `Notifier` via constructor promotion.

### Bonus Challenge
`RateLimitedNotifier`.

### Hints
- **Hint 1:** Decorator `send` calls inner then logs.
- **Hint 2:** Sink is `array<string>` by reference.
- **Hint 3:** Typed property `private Notifier $inner`.

---

## 5. Repository interface + in-memory implementation

### Task Description
`StudentRepositoryInterface` with `find(int $id): ?Student`, `all(): array`. `InMemoryStudentRepository` backed by array; `save(Student $s): void` upserts by id.

### Input Data
Save two students; `find` unknown → null.

### Expected Output
Contract tests pass (PHPUnit): save, find, all count.

### Constraints
- Domain `Student` in separate namespace from infra.

### Bonus Challenge
`PdoStudentRepository` skeleton without DB.

### Hints
- **Hint 1:** Internal `array<int, Student>`.
- **Hint 2:** `upsert` via `$this->students[$s->getId()] = $s`.
- **Hint 3:** Return copies if immutability required.

---

## 6. Schedule slot + conflict service

### Task Description
Value object `TimeRange` (`starts`, `ends` `DateTimeImmutable`). `LessonSlot` has `TimeRange`, `ClassRoom $room`, `Teacher $teacher`. `ConflictChecker::hasRoomConflict(LessonSlot ...$slots): bool` if any two share room and overlap time.

### Input Data
Two slots same room overlapping vs not.

### Expected Output
Boolean per spec.

### Constraints
- Overlap logic inside `TimeRange::overlaps(self $o): bool`.

### Bonus Challenge
Return **first** conflicting pair.

### Hints
- **Hint 1:** Compare `<=` endpoints exclusive/inclusive — pick one standard.
- **Hint 2:** O(n²) double loop acceptable.
- **Hint 3:** `TimeRange` validates `starts < ends`.

---

## 7. Policy-based fee calculator

### Task Description
Interface `TuitionRule { public function apply(Enrollment $e): int /* cents */; }`. `StandardTuitionRule`, `ScholarshipRule` (decorates inner rule with percentage discount). `FeeService` stacks rules.

### Input Data
Base 300_000 cents; scholarship 20% on inner.

### Expected Output
`240_000` cents after one scholarship wrapping base.

### Constraints
- Each rule is immutable; compose, not subclass pyramid.

### Bonus Challenge
`EarlyBirdRule` subtracts fixed amount capped.

### Hints
- **Hint 1:** `ScholarshipRule` stores `TuitionRule $inner`.
- **Hint 2:** `return (int) floor($inner->apply($e) * (1 - $pct))`.
- **Hint 3:** `Enrollment` exposes `classCode`, `startDate`.

---

## 8. Gradebook aggregate root

### Task Description
`Gradebook` entity for one `classCode` holds private list of `GradeEntry`. Methods `recordGrade(GradeEntry $g)`, `averageForStudent(int $studentId): ?float`, `classAverage(): float`. No public array exposure.

### Input Data
Multiple entries per student; student with none → `averageForStudent` null.

### Expected Output
Correct averages with floating rules documented (2 decimals).

### Constraints
- `GradeEntry` is readonly with `studentId`, `subject`, `score`.

### Bonus Challenge
Domain event `GradeRecorded` dispatched on record.

### Hints
- **Hint 1:** Filter entries by studentId then average.
- **Hint 2:** Guard divide by zero.
- **Hint 3:** `array_values` after filter for clean indices.

---

## 9. Attendance policy strategy

### Task Description
Interface `AttendancePolicy { public function statusFor(int $minutesLate): AttendanceStatus; }`. Enum `AttendanceStatus: PRESENT | LATE | ABSENT`. Implement `StrictPolicy` (late if >0) and `LenientPolicy` (late if >15 else present).

### Input Data
`minutesLate = 10`.

### Expected Output
Strict → `LATE`; Lenient → `PRESENT`.

### Constraints
- Inject policy into `AttendanceService` constructor.

### Bonus Challenge
`CompositePolicy` with campus overrides.

### Hints
- **Hint 1:** `match (true)` on minute thresholds.
- **Hint 2:** Enum cases uppercase for code style.
- **Hint 3:** Service method `mark(int $studentId, int $minutesLate): AttendanceRecord`.

---

## 10. Course module template method

### Task Description
Abstract `CourseModule` with final method `runWeek(int $week): array` calling abstract hooks `theoryTopics(int $week): string[]`, `labExercises(int $week): string[]`, concrete `reviewSession(): string`. Subclass `SqlModule` provides SQL-specific topics.

### Input Data
`$m = new SqlModule(); $m->runWeek(3);`

### Expected Output
Structured array merging theory, lab, and fixed review string per template.

### Constraints
- `final` on `runWeek`; children cannot override sequence.

### Bonus Challenge
Hook `assessmentForWeek` optional default empty.

### Hints
- **Hint 1:** Template method returns `['theory' => ..., 'lab' => ..., 'review' => ...]`.
- **Hint 2:** Protected abstract methods.
- **Hint 3:** Document week indexing 1-based.
