# Abid - PHP OOP Challenges

### 1) Polymorphism - Payment method (Card / Cash)
#### Task Description
Create a polymorphic payment system with a common contract `PaymentMethod` and two implementations:
- `CardPayment`
- `CashPayment`

Each class must implement a method `pay(float $amount): string`.

#### Input Data
```json
{
  "payments": [
    { "method": "card", "amount": 120.5 },
    { "method": "cash", "amount": 80 }
  ]
}
```

#### Expected Output
```json
[
  "Card payment accepted: 120.5",
  "Cash payment accepted: 80"
]
```

### 2) Abstract Notification + Polymorphic send()
#### Task Description
Create an abstract class `Notification` with:
- private attributes: `message`, `sender`, `receiver`
- abstract method `send(): string`
- static method `appName(): string`

Then create:
- `EmailNotification extends Notification`
- `SMSNotification extends Notification`

Test:
- static call: `Notification::appName()`
- polymorphic call: `$notification->send()`

#### Input Data
```json
{
  "notifications": [
    { "type": "email", "message": "Welcome", "sender": "admin@shop.com", "receiver": "user@mail.com" },
    { "type": "sms", "message": "Code 4455", "sender": "SHOP", "receiver": "+212600000000" }
  ]
}
```

#### Expected Output
```json
{
  "staticCall": "MyNotificationApp",
  "sent": [
    "Email sent from admin@shop.com to user@mail.com: Welcome",
    "SMS sent from SHOP to +212600000000: Code 4455"
  ]
}
```

### 3) Static calculator division with first result memory
#### Task Description
Build a class `Calculator` with a static method `divide(float $a, float $b): float` that:
- performs division without class instantiation
- stores the first computed result only once
- exposes it using `getFirstResult(): float|null`

#### Input Data
```json
{
  "operations": [
    [6, 2],
    [8, 4],
    [15, 3]
  ]
}
```

#### Expected Output
```json
{
  "results": [3, 2, 5],
  "firstResult": 3
}
```

### 4) Shop products - Physical and Digital
#### Task Description
Create a product model for:
- `PhysicalProduct` (`name`, `unitPrice`, `weight`)
- `DigitalProduct` (`name`, `unitPrice`, `downloadLink`)

Rules:
- each product must implement `displayDetails(): string`
- `unitPrice` must never be negative (throw exception if invalid)

#### Input Data
```json
{
  "products": [
    { "type": "physical", "name": "Keyboard", "unitPrice": 350, "weight": 0.9 },
    { "type": "digital", "name": "Ebook PHP", "unitPrice": 120, "downloadLink": "https://store.dev/ebooks/php" }
  ]
}
```

#### Expected Output
```json
[
  "PhysicalProduct(name=Keyboard, unitPrice=350, weight=0.9kg)",
  "DigitalProduct(name=Ebook PHP, unitPrice=120, downloadLink=https://store.dev/ebooks/php)"
]
```

### 5) Shop validation - Reject negative price
#### Task Description
Using the same shop model, ensure product creation fails when `unitPrice < 0`.

#### Input Data
```json
{
  "product": { "type": "physical", "name": "Mouse", "unitPrice": -50, "weight": 0.2 }
}
```

#### Expected Output
```json
{
  "error": "Invalid unitPrice: value cannot be negative"
}
```

### 6) Bank accounts - Current and Savings
#### Task Description
Create a banking model with:
- `CurrentAccount` (`holder`, `balance`, `authorizedOverdraft`)
- `SavingsAccount` (`holder`, `balance`, `interestRate`)

Rules:
- each account must implement `displayInfo(): string`
- effective balance must never go below allowed constraints
- reject invalid initialization values

#### Input Data
```json
{
  "accounts": [
    { "type": "current", "holder": "Abid Abdeladim", "balance": 1000, "authorizedOverdraft": 300 },
    { "type": "savings", "holder": "Sara Benali", "balance": 2500, "interestRate": 0.03 }
  ]
}
```

#### Expected Output
```json
[
  "CurrentAccount(holder=Abid Abdeladim, balance=1000, authorizedOverdraft=300)",
  "SavingsAccount(holder=Sara Benali, balance=2500, interestRate=0.03)"
]
```

### 7) Polymorphism - Transfer by bank or wallet
#### Task Description
Create a transfer system with a common interface `TransferMethod` and two classes:
- `BankTransfer`
- `WalletTransfer`

Each class implements `transfer(float $amount, string $to): string`.

#### Input Data
```json
{
  "transfers": [
    { "method": "bank", "amount": 500, "to": "MA123BANK0001" },
    { "method": "wallet", "amount": 120, "to": "wallet_user_77" }
  ]
}
```

#### Expected Output
```json
[
  "Bank transfer of 500 to MA123BANK0001 completed",
  "Wallet transfer of 120 to wallet_user_77 completed"
]
```

### 8) Notification factory with polymorphic dispatch
#### Task Description
Using `Notification` subclasses, create a `NotificationFactory` that builds the correct notification object from a `type`.
Then dispatch notifications polymorphically using `send()`.

#### Input Data
```json
{
  "notifications": [
    { "type": "email", "message": "Invoice ready", "sender": "billing@shop.com", "receiver": "client@mail.com" },
    { "type": "sms", "message": "Your OTP is 8899", "sender": "SHOP", "receiver": "+212611111111" }
  ]
}
```

#### Expected Output
```json
[
  "Email sent from billing@shop.com to client@mail.com: Invoice ready",
  "SMS sent from SHOP to +212611111111: Your OTP is 8899"
]
```

### 9) Static calculator with operation history
#### Task Description
Extend static calculator behavior:
- keep first division result unchanged
- keep a static history of all division operations
- expose `getFirstResult()` and `getHistory()`

#### Input Data
```json
{
  "operations": [
    [20, 5],
    [9, 3],
    [14, 2]
  ]
}
```

#### Expected Output
```json
{
  "results": [4, 3, 7],
  "firstResult": 4,
  "history": ["20/5=4", "9/3=3", "14/2=7"]
}
```

### 10) Shop - apply discount polymorphically
#### Task Description
Add a method `finalPrice()` for both product types:
- physical products: 10% discount when `weight > 5`
- digital products: 15% discount when price is above 200

Keep validation rule: price cannot be negative.

#### Input Data
```json
{
  "products": [
    { "type": "physical", "name": "Office Chair", "unitPrice": 1000, "weight": 12 },
    { "type": "digital", "name": "Pro Course", "unitPrice": 300, "downloadLink": "https://store.dev/pro-course" }
  ]
}
```

#### Expected Output
```json
[
  "PhysicalProduct(name=Office Chair, unitPrice=1000, finalPrice=900, weight=12kg)",
  "DigitalProduct(name=Pro Course, unitPrice=300, finalPrice=255, downloadLink=https://store.dev/pro-course)"
]
```

### 11) Bank account monthly update
#### Task Description
Implement monthly update behavior:
- savings account adds interest (`balance += balance * interestRate`)
- current account applies overdraft fee of 20 when `balance < 0`

Each account returns updated info after `applyMonthlyUpdate()`.

#### Input Data
```json
{
  "accounts": [
    { "type": "savings", "holder": "Sara Benali", "balance": 2000, "interestRate": 0.02 },
    { "type": "current", "holder": "Abid Abdeladim", "balance": -50, "authorizedOverdraft": 300 }
  ]
}
```

#### Expected Output
```json
[
  "SavingsAccount(holder=Sara Benali, balance=2040, interestRate=0.02)",
  "CurrentAccount(holder=Abid Abdeladim, balance=-70, authorizedOverdraft=300)"
]
```

### 12) Payment receipt generator (static + polymorphism)
#### Task Description
For each payment method object, process payment and generate a static receipt number (`R-0001`, `R-0002`, ...).
Return both payment message and generated receipt.

#### Input Data
```json
{
  "payments": [
    { "method": "cash", "amount": 50 },
    { "method": "card", "amount": 140 }
  ]
}
```

#### Expected Output
```json
[
  { "message": "Cash payment accepted: 50", "receipt": "R-0001" },
  { "message": "Card payment accepted: 140", "receipt": "R-0002" }
]
```

---

## Harder Complexity Challenges

### 13) Payment gateway with retries and failure strategy
#### Task Description
Design a payment gateway with polymorphic handlers (`CardPayment`, `CashPayment`, `WalletPayment`) and retry logic:
- card/wallet payments can fail
- retry max 2 times
- cash never retries
- return final status per transaction

#### Input Data
```json
{
  "transactions": [
    { "id": "T1", "method": "card", "amount": 100, "attemptResults": [false, true] },
    { "id": "T2", "method": "wallet", "amount": 80, "attemptResults": [false, false, false] },
    { "id": "T3", "method": "cash", "amount": 40, "attemptResults": [true] }
  ]
}
```

#### Expected Output
```json
[
  { "id": "T1", "status": "success", "attempts": 2 },
  { "id": "T2", "status": "failed", "attempts": 3 },
  { "id": "T3", "status": "success", "attempts": 1 }
]
```

### 14) Notification queue with priority and throttling
#### Task Description
Build a notification queue system:
- notification types: email/sms
- each item has `priority` (higher first)
- same receiver cannot receive more than one notification per batch
- remaining notifications stay pending

#### Input Data
```json
{
  "batchSize": 3,
  "queue": [
    { "type": "email", "receiver": "u1@mail.com", "message": "A", "priority": 2 },
    { "type": "sms", "receiver": "+2126001", "message": "B", "priority": 5 },
    { "type": "email", "receiver": "u1@mail.com", "message": "C", "priority": 4 },
    { "type": "sms", "receiver": "+2126002", "message": "D", "priority": 3 }
  ]
}
```

#### Expected Output
```json
{
  "sent": [
    "SMS sent to +2126001: B",
    "Email sent to u1@mail.com: C",
    "SMS sent to +2126002: D"
  ],
  "pending": [
    { "type": "email", "receiver": "u1@mail.com", "message": "A", "priority": 2 }
  ]
}
```

### 15) Static calculator with immutable first result and reset lock
#### Task Description
Enhance the static calculator:
- first division result is immutable once set
- `reset()` is allowed only before first result exists
- division by zero throws an exception and is not stored in history

#### Input Data
```json
{
  "calls": [
    { "op": "divide", "a": 9, "b": 3 },
    { "op": "divide", "a": 8, "b": 0 },
    { "op": "divide", "a": 20, "b": 5 },
    { "op": "reset" }
  ]
}
```

#### Expected Output
```json
{
  "results": [3, "DivisionByZeroError", 4, "ResetDenied"],
  "firstResult": 3,
  "history": ["9/3=3", "20/5=4"]
}
```

### 16) Product catalog with interface segregation and tax strategies
#### Task Description
Model products with:
- `Displayable` interface for fiche display
- `Taxable` interface for tax calculation
- tax strategies:
  - physical: 20% VAT
  - digital: 10% VAT
- reject invalid product data (negative price, empty name, invalid link)

#### Input Data
```json
{
  "products": [
    { "type": "physical", "name": "Laptop", "unitPrice": 10000, "weight": 1.8 },
    { "type": "digital", "name": "PHP Masterclass", "unitPrice": 500, "downloadLink": "https://store.dev/php-masterclass" }
  ]
}
```

#### Expected Output
```json
[
  "PhysicalProduct(name=Laptop, base=10000, tax=2000, total=12000, weight=1.8kg)",
  "DigitalProduct(name=PHP Masterclass, base=500, tax=50, total=550, downloadLink=https://store.dev/php-masterclass)"
]
```

### 17) Banking transactions with rollback on rule violation
#### Task Description
Create account transaction processing with operations:
- deposit
- withdraw
- transfer

Rules:
- for `CurrentAccount`, `balance >= -authorizedOverdraft`
- for `SavingsAccount`, `balance >= 0`
- if a transfer violates a rule, rollback both sides and log failure

#### Input Data
```json
{
  "accounts": {
    "A": { "type": "current", "holder": "Abid", "balance": 200, "authorizedOverdraft": 100 },
    "B": { "type": "savings", "holder": "Sara", "balance": 50, "interestRate": 0.02 }
  },
  "operations": [
    { "type": "transfer", "from": "A", "to": "B", "amount": 250 },
    { "type": "withdraw", "account": "B", "amount": 120 }
  ]
}
```

#### Expected Output
```json
{
  "finalBalances": {
    "A": 200,
    "B": 300
  },
  "logs": [
    "transfer A->B amount=250 success",
    "withdraw B amount=120 success"
  ]
}
```

### 18) Monthly bank engine with polymorphic fee and interest policies
#### Task Description
Build a monthly engine applying polymorphic policies:
- current account: maintenance fee 15
- savings account: add interest
- premium account (extends current): no maintenance fee + cashback 1% on monthly outgoing transfers

Each account returns a monthly summary object.

#### Input Data
```json
{
  "accounts": [
    { "type": "current", "holder": "A", "balance": 1000, "authorizedOverdraft": 200, "outgoingTransfers": 300 },
    { "type": "savings", "holder": "B", "balance": 5000, "interestRate": 0.01, "outgoingTransfers": 0 },
    { "type": "premium", "holder": "C", "balance": 2000, "authorizedOverdraft": 500, "outgoingTransfers": 400 }
  ]
}
```

#### Expected Output
```json
[
  { "holder": "A", "type": "current", "openingBalance": 1000, "closingBalance": 985 },
  { "holder": "B", "type": "savings", "openingBalance": 5000, "closingBalance": 5050 },
  { "holder": "C", "type": "premium", "openingBalance": 2000, "closingBalance": 2004 }
]
```
