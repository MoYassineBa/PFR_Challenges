# PHP OOP — Medium (10 challenges)

> **Fil Rouge / C7** — Classes, encapsulation, types. Logique **simple** : **une boucle** (`foreach`, etc.) au plus pour parcourir une petite collection quand c’est nécessaire ; sinon méthodes dédiées et objets.
>
> **Recoupement avec votre rapport (2ᵉ année / Fil Rouge)**  
> - **C7 attendu** : création et manipulation de **classes et d’objets**, **encapsulation** (visibilité, pas de setters abusifs, value objects), bases de **typage** — couvert par ces 10 sujets (élève, cours, note, salle, enum statut, etc.).  
> - **Restrictions techniques** (Breeze, Spatie, Livewire, Voyager, Easy Panel, Datatables Yajra…) : elles concernent un **projet Laravel** ; ces défis sont en **PHP OOP seul**, donc **pas de conflit**. Si les élèves intègrent le code dans un Fil Rouge Laravel, rappeler l’interdiction des packages listés au CR.  
> - **C5 (UML)** : non évalué dans les fichiers `.md`, mais chaque défi sert de **base de diagramme de classes** (associations élève–classe, etc.) pour la soutenance.  
> - **Ce que le Medium ne couvre pas volontairement** : **héritage / interfaces** en profondeur → voir `hard.md`.

Single main OOP concept each: classes, visibility, simple relationships. School domain.

---

## 1. Student value object

### Task Description
Create an immutable `Student` class with private `int $id`, `string $fullName`, `string $email`. Constructor + getters only. `withEmail(string $newEmail): self` returns **new** instance (no setters).

### Input Data
```php
$student = new Student(10, "Leila Mansouri", "leila@school.ma");
$updated = $student->withEmail("leila.perso@email.com");
```

### Expected Output
`$student->getEmail()` unchanged; `$updated->getEmail()` is the new email; same `id` and `fullName`.

### Constraints
- `readonly` properties or private + no mutation methods except `with*`.

### Bonus Challenge
Validate email with `filter_var`.

### Hints
- **Hint 1:** Clone pattern: `return new self($this->id, $this->fullName, $newEmail);`
- **Hint 2:** Mark class `final` if not meant for extension.
- **Hint 3:** No public properties.

---

## 2. Course entity with capacity

### Task Description
Class `Course` with `code`, `title`, `maxStudents`. Method `canEnroll(int $currentCount): bool` returns true if `currentCount < maxStudents`.

### Input Data
```php
$php = new Course("PHP-301", "Backend PHP", 2);
$php->canEnroll(2); // false
```

### Expected Output
`false` for full class; `true` below cap.

### Constraints
- Integer types only for counts.

### Bonus Challenge
Method `remainingSeats(int $currentCount): int`.

### Hints
- **Hint 1:** Compare `currentCount` strictly less than max.
- **Hint 2:** Use constructor property promotion (PHP 8+).
- **Hint 3:** Throw `InvalidArgumentException` if negative count.

---

## 3. Grade as typed object

### Task Description
Class `Grade` storing `studentId`, `subjectCode`, `float $score` on 0–20. Method `isPassing(float $threshold = 10.0): bool`.

### Input Data
```php
$g = new Grade(5, "SQL", 9.5);
```

### Expected Output
`$g->isPassing()` → `false`; `isPassing(9.0)` → `true`.

### Constraints
- Store score as float; round display separately if needed.

### Bonus Challenge
`letter(): string` mapping school scale.

### Hints
- **Hint 1:** Threshold comparison inclusive on `>=`.
- **Hint 2:** Validate score range in constructor.
- **Hint 3:** Use `private readonly` fields.

---

## 4. Teacher — list assigned classes

### Task Description
`Teacher` has `id`, `name`, and array of `ClassRoom` objects. Method `getClassCodes(): array` returns list of strings from classrooms.

### Input Data
```php
$c1 = new ClassRoom("DWWM-24A", "Lab A");
$c2 = new ClassRoom("DWWM-24B", "Lab B");
$t = new Teacher(3, "Youssef", [$c1, $c2]);
```

### Expected Output
`["DWWM-24A", "DWWM-24B"]` from `getClassCodes()`.

### Constraints
- `ClassRoom` exposes `getCode(): string`.

### Bonus Challenge
`teaches(string $classCode): bool`.

### Hints
- **Hint 1:** `array_map(fn(ClassRoom $c) => $c->getCode(), $this->classrooms)`.
- **Hint 2:** Type-hint property as `array<int, ClassRoom>`.
- **Hint 3:** Defensive copy in constructor if mutability is concern.

---

## 5. Enrollment status enum-style

### Task Description
Use backed enum `EnrollmentStatus: string` with cases `ACTIVE`, `COMPLETED`, `WITHDRAWN`. Method `isBillable(): bool` true only for `ACTIVE`.

### Input Data
```php
EnrollmentStatus::ACTIVE->isBillable(); // true
```

### Expected Output
`WITHDRAWN` and `COMPLETED` return `false`.

### Constraints
- PHP 8.1+ enum; no magic strings outside enum.

### Bonus Challenge
`fromDatabase(?string): self` mapping null to `COMPLETED`.

### Hints
- **Hint 1:** `enum EnrollmentStatus: string { ... }`.
- **Hint 2:** Add instance method using `match($this)`.
- **Hint 3:** `case ACTIVE = 'active';` lower-case storage.

---

## 6. Attendance record factory

### Task Description
Static factory `AttendanceRecord::forPresent(int $studentId, DateTimeImmutable $day): self` and `::forAbsent(..., string $reason): self`. Both set internal `status` differently.

### Input Data
```php
$d = new DateTimeImmutable("2026-04-24");
$a = AttendanceRecord::forAbsent(7, $d, "sick");
```

### Expected Output
`$a->getStatus()` === `"absent"`; present factory gives `"present"`.

### Constraints
- Private constructor; only static factories construct.

### Bonus Challenge
`equals(self $other): bool` value equality.

### Hints
- **Hint 1:** Private `__construct` taking all fields.
- **Hint 2:** Factories delegate with fixed `status`.
- **Hint 3:** Normalize date to date-only (strip time).

---

## 7. Subject prerequisite single link

### Task Description
`Subject` has `code`, `name`, optional `?Subject $prerequisite`. Method `getPrerequisiteChain(): Subject[]` returns `[prereq, prereq of prereq, ...]` until null (order root-first or leaf-first — **document**: root-first).

### Input Data
```php
$basics = new Subject("PHP-B", "PHP Basics", null);
$oop = new Subject("PHP-O", "PHP OOP", $basics);
```

### Expected Output
`$oop->getPrerequisiteChain()` → `[$basics]`.

### Constraints
- Detect trivial self-reference in constructor (throw).

### Bonus Challenge
Detect longer cycles.

### Hints
- **Hint 1:** While current prereq not null, push and walk.
- **Hint 2:** Guard infinite loop with `visited` set for bonus.
- **Hint 3:** Type `?Subject` property.

---

## 8. Exam session composite id

### Task Description
Class `ExamSession` with `subjectCode`, `DateTimeImmutable $startsAt`, `string $roomId`. Method `getCompositeKey(): string` returns `"subject|Y-m-d H:i|room"` UTC-safe.

### Input Data
```php
$e = new ExamSession("SQL", new DateTimeImmutable("2026-06-01 09:00:00"), "A1");
```

### Expected Output
Key matches concatenation spec exactly.

### Constraints
- Immutable `ExamSession`.

### Bonus Challenge
`overlaps(ExamSession $other): bool` same room, time intersection.

### Hints
- **Hint 1:** `format('Y-m-d H:i')` on same timezone.
- **Hint 2:** Use `|` delimiter consistently.
- **Hint 3:** `__toString` optional alias to key.

---

## 9. School config singleton (discouraged pattern — teach why)

### Task Description
Implement `SchoolSettings` **without** global singleton: use a simple `AppConfig` object injected. Show `getGradePassingThreshold(): float` from injected values. **Comment** why singleton hurts testing.

### Input Data
```php
$config = new AppConfig(passingThreshold: 10.0);
$settings = new SchoolSettings($config);
```

### Expected Output
`$settings->getGradePassingThreshold()` returns `10.0`.

### Constraints
- No `static` state for threshold storage.

### Bonus Challenge
Interface `ConfigProvider` implemented by `AppConfig`.

### Hints
- **Hint 1:** Constructor injection only.
- **Hint 2:** Interface with `passingThreshold(): float`.
- **Hint 3:** Document testability in class docblock.

---

## 10. Simple invoice line

### Task Description
`InvoiceLine` with `description`, `amountCents`, `vatRate` (0–1). Method `totalWithVatCents(): int` using integer rounding half-up.

### Input Data
```php
$line = new InvoiceLine("Tuition April", 10000, 0.20);
```

### Expected Output
`12000` cents total (exact in this case).

### Constraints
- Amounts in cents as `int`.

### Bonus Challenge
Multiple lines class `Invoice` with `grandTotal`.

### Hints
- **Hint 1:** `vat = (int) round($this->amountCents * $this->vatRate)`.
- **Hint 2:** Sum base + vat.
- **Hint 3:** Validate non-negative amounts.
