# PHP OOP — Extreme (10 challenges)

> **Option avancée** — Au-delà du **minimum Fil Rouge** (C7 oral + architecture simple). Réserve pédagogique : perfectionnement DDD / ports-adapters ; pas obligatoire pour valider le socle.
>
> **Rapport Fil Rouge** : le CR demande une **architecture OO simple** et une logique **limitée** pour le socle. Les sujets **Extreme** (contextes bornés, agrégats, UoW, CQRS, etc.) vont **au-delà** de ce minimum : les utiliser comme **approfondissement** ou **piste 2ᵉ année avancée**, pas comme barème unique de réussite C7. Aucun lien avec les **packages Laravel interdits** (pas de framework ici).

Real-world style architecture: DDD touches, aggregates, ports/adapters, edge cases.

---

## 1. Bounded context — Registration vs Billing

### Task Description
Two namespaces `Registration\` and `Billing\`. `Registration\Student` (minimal profile). `Billing\Customer` references `studentId` only (int). Map via `StudentBillingMapper` with explicit conversion; **no** duplicate full name fields in Billing. Demonstrate anti-corruption layer method `toCustomer(Registration\Student $s): Billing\Customer`.

### Input Data
Student with id 42; billing customer id same with external `stripeCustomerId`.

### Expected Output
Objects are different classes; mapper produces valid `Customer`.

### Constraints
- No inheritance between Student and Customer; composition + mapping only.

### Bonus Challenge
Event `StudentRegistered` consumed by billing subscriber.

### Hints
- **Hint 1:** Separate folders PSR-4 aligned.
- **Hint 2:** Mapper is single-purpose class.
- **Hint 3:** Document why contexts stay separate.

---

## 2. Enrollment aggregate invariants

### Task Description
`Enrollment` aggregate enforces: cannot transition `WITHDRAWN` → `ACTIVE`; `ACTIVE` requires `startDate <= today` validation on creation only; `withdraw()` sets end + status. Expose explicit methods only (no public setters).

### Input Data
Illegal transition attempts in test cases.

### Expected Output
`DomainException` with clear messages.

### Constraints
- State machine inside aggregate private field.

### Bonus Challenge
Record domain events in private array `pullEvents(): array`.

### Hints
- **Hint 1:** Methods `activate()`, `complete()`, `withdraw()`.
- **Hint 2:** Guard current status before each transition.
- **Hint 3:** Value object `DateRange` for program span.

---

## 3. Pluggable grading engine (Specification pattern)

### Task Description
`GradeSpecificationInterface { public function isSatisfiedBy(StudentTranscript $t): bool; }`. Implement `DeansListSpec` (avg ≥ 16, no absences > 3), `SportsEligibleSpec` (avg ≥ 10, attendance ≥ 0.9). `AwardService` returns list of award codes satisfied.

### Input Data
Transcript object with grades array + attendance stats.

### Expected Output
`["DEAN_LIST", "SPORTS"]` or subset per data.

### Constraints
- Specifications must be combinable with `AndSpec`, `OrSpec` classes.

### Bonus Challenge
`NotSpec`.

### Hints
- **Hint 1:** Each spec single responsibility.
- **Hint 2:** `AndSpec` stores two specs; `isSatisfiedBy` ANDs results.
- **Hint 3:** Transcript provides query methods not raw arrays.

---

## 4. Timetable as graph + validator service

### Task Description
Model `ScheduledLesson` nodes; `DependencyValidator` ensures `Subject` prerequisites satisfied temporally (lesson week of prereq subject must be strictly before dependent subject). Inject `PrerequisiteCatalog` interface.

### Input Data
Catalog: PHP-OOP requires PHP-Basics. Schedule weeks violate vs satisfy.

### Expected Output
`ValidationResult` value object with `ok(): bool` and `errors(): string[]`.

### Constraints
- No static global catalog; injected dependency.

### Bonus Challenge
Detect circular prerequisite data at catalog level.

### Hints
- **Hint 1:** Lessons indexed by subjectCode → week.
- **Hint 2:** Compare integer weeks.
- **Hint 3:** Collect all error strings, still return object.

---

## 5. Multi-tenant school plugin architecture

### Task Description
Interface `CampusPlugin { public function code(): string; public function adjustPassingThreshold(float $base): float; }`. `CampusRegistry` registers plugins; `PolicyResolver` picks plugin by `campusCode` or default. No `switch` on campus in business services — use registry lookup.

### Input Data
Two plugins adjusting thresholds differently.

### Expected Output
Resolved threshold per campus.

### Constraints
- Unknown campus uses `DefaultCampusPlugin`.

### Bonus Challenge
Priority chain if multiple plugins (decorator).

### Hints
- **Hint 1:** `array<string, CampusPlugin>`.
- **Hint 2:** `register(CampusPlugin $p)` stores by `code()`.
- **Hint 3:** Resolver method `threshold(string $campus, float $base): float`.

---

## 6. Unit of Work stub for exam registration

### Task Description
Implement `UnitOfWork` with `persist(object $o)`, `delete(object $o)`, `commit(): void` calling `ExamRegistrationWriter` interface (in-memory double). Track **new** vs **deleted** conflicts (delete wins). Transactional semantics: `commit` clears lists; `rollback` clears without persisting.

### Input Data
Persist then delete same entity before commit.

### Expected Output
Writer receives net zero or delete-only per your documented rules.

### Constraints
- Objects compared by `spl_object_id` or explicit identity interface `EntityId`.

### Bonus Challenge
Detect dirty updates.

### Hints
- **Hint 1:** Two spl stacks `inserts`, `deletes`.
- **Hint 2:** On commit, process deletes first or last — document.
- **Hint 3:** `rollback` resets internal arrays.

---

## 7. CQRS-style split read model

### Task Description
`Command\RecordAttendanceCommand` handled by `AttendanceCommandHandler` mutating write model `AttendanceWriteRepository`. `Query\ClassAttendanceSummaryQuery` + handler reads from `AttendanceReadModel` populated synchronously in same request (pseudo projection). **No** shared mutable array between handlers — pass DTOs.

### Input Data
Commands recorded; query for date range.

### Expected Output
DTO `AttendanceSummaryDto` with counts.

### Constraints
- Separate interfaces for write/read repos in different namespaces.

### Bonus Challenge
Async projection interface (empty implementation).

### Hints
- **Hint 1:** Command handler also updates read model in process.
- **Hint 2:** DTOs are readonly classes.
- **Hint 3:** Document that real CQRS would be async.

---

## 8. Role-based access on Grade mutation

### Task Description
`GradeEditingService` depends on `AuthorizationCheckerInterface` with `assertCan(User $user, string $action, GradeContext $ctx): void`. Roles `TEACHER` may edit only own classes; `ADMIN` any. `User` aggregates `Role[]` and `teacherId?`.

### Input Data
User teacher 5 edits grade in class taught vs not taught.

### Expected Output
`AuthorizationException` when illegal.

### Constraints
- No `if ($user->role === 'ADMIN')` in service — delegate to checker implementation.

### Bonus Challenge
Attribute-based metadata on methods (PHP 8 attributes) optional.

### Hints
- **Hint 1:** `GradeContext` holds `classCode`, `teacherOwnerId`.
- **Hint 2:** Checker loops roles polymorphically or uses `match` on enum `Role`.
- **Hint 3:** Service begins each public method with `assertCan`.

---

## 9. Money value object + ledger postings

### Task Description
`Money` int cents + `Currency` enum `MAD`. Methods `add`, `subtract` same currency only; `allocate(int ...$ratios): Money[]` largest remainder method for splitting scholarship across invoices. `Ledger` records postings with **immutable** `Money` snapshots.

### Input Data
Split 100 cents across ratios `3,3,4`.

### Expected Output
Array of three `Money` summing exactly 100.

### Constraints
- Throw on currency mismatch and negative results.

### Bonus Challenge
Multi-currency conversion port (interface only).

### Hints
- **Hint 1:** Total ratio sum divides amount; remainder distributed by descending fractional parts.
- **Hint 2:** `Money` immutable `withAmount(int $cents): self`.
- **Hint 3:** Unit tests for off-by-one cent.

---

## 10. Serializer adapter for legacy export

### Task Description
`LegacyExportAdapter` implements `StudentExportInterface` but internally calls old procedural function `legacy_student_csv_row(array $row): string`. Wrap to accept `Student` object, map to legacy array keys (`nom`, `prenom`, `classe`) — **French keys** required by downstream Excel macro.

### Input Data
`Student` with split first/last or single full — your design.

### Expected Output
CSV line string matching legacy format exactly.

### Constraints
- Adapter isolates legacy shape; domain never sees French keys.

### Bonus Challenge
Stream many students without loading all in memory (generator).

### Hints
- **Hint 1:** Private `toLegacyArray(Student): array`.
- **Hint 2:** Call legacy function inside adapter only.
- **Hint 3:** Document encoding UTF-8 with BOM optional.
