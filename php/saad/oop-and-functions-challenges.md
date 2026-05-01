# Saad - PHP Challenges (Functions + OOP)

### 1) Return all coaches in Safi
#### Task Description
Create a function that returns all coaches whose city is `Safi`.

#### Input Data
```json
[
  { "id": 1, "name": "Saad", "city": "Safi" },
  { "id": 2, "name": "Abid", "city": "Rabat" },
  { "id": 3, "name": "Housni", "city": "Safi" }
]
```

#### Expected Output
```json
[
  { "id": 1, "name": "Saad", "city": "Safi" },
  { "id": 3, "name": "Housni", "city": "Safi" }
]
```

### 2) Return reservations by username
#### Task Description
Create a function that receives a username and returns all reservations made by that user.

#### Input Data
```json
{
  "username": "ali",
  "reservations": [
    { "id": 100, "username": "ali", "type": "hotel", "price": 300 },
    { "id": 101, "username": "sara", "type": "flight", "price": 1200 },
    { "id": 102, "username": "ali", "type": "car", "price": 150 }
  ]
}
```

#### Expected Output
```json
[
  { "id": 100, "username": "ali", "type": "hotel", "price": 300 },
  { "id": 102, "username": "ali", "type": "car", "price": 150 }
]
```

### 3) Abstract Animal - Carnivore and Herbivore
#### Task Description
Create an abstract class `Animal` with:
- abstract method `eat()`

Create two classes:
- `Carnivore`
- `Herbivore`

Each class implements `eat()` differently.

#### Input Data
```json
{
  "animals": [
    { "type": "carnivore", "name": "Lion" },
    { "type": "herbivore", "name": "Cow" }
  ]
}
```

#### Expected Output
```json
[
  "Lion mange de la viande",
  "Cow mange des plantes"
]
```

### 4) Find all drivers then filter by city
#### Task Description
Use a repository-style method `findAll()` to retrieve all drivers, then filter them by city.

#### Input Data
```json
{
  "city": "Safi",
  "drivers": [
    { "id": 1, "name": "Yassine", "city": "Safi" },
    { "id": 2, "name": "Karim", "city": "Casa" },
    { "id": 3, "name": "Imane", "city": "Safi" }
  ]
}
```

#### Expected Output
```json
[
  { "id": 1, "name": "Yassine", "city": "Safi" },
  { "id": 3, "name": "Imane", "city": "Safi" }
]
```

### 5) Garage simulation - Abstract Vehicule
#### Task Description
Create an abstract class `Vehicule` and two concrete classes:
- `Voiture`
- `Moto`

Each class should calculate/display speed after object instantiation.

#### Input Data
```json
{
  "vehicles": [
    { "type": "voiture", "name": "Dacia", "distanceKm": 120, "timeH": 2 },
    { "type": "moto", "name": "Yamaha", "distanceKm": 90, "timeH": 1.5 }
  ]
}
```

#### Expected Output
```json
[
  "Voiture Dacia vitesse: 60 km/h",
  "Moto Yamaha vitesse: 60 km/h"
]
```

### 6) Create a User class (OOP principles)
#### Task Description
Create a `User` class that respects OOP basics:
- private attributes (`name`, `email`)
- constructor
- getters/setters with basic validation

Return a formatted profile string.

#### Input Data
```json
{
  "name": "Sara Benali",
  "email": "sara@school.ma"
}
```

#### Expected Output
```json
"User(name=Sara Benali, email=sara@school.ma)"
```

### 7) Return all coaches by specialty
#### Task Description
Create a function that receives a specialty and returns all coaches with that specialty.

#### Input Data
```json
{
  "specialty": "javascript",
  "coaches": [
    { "id": 1, "name": "Saad", "specialty": "javascript" },
    { "id": 2, "name": "Abid", "specialty": "php" },
    { "id": 3, "name": "Housni", "specialty": "javascript" }
  ]
}
```

#### Expected Output
```json
[
  { "id": 1, "name": "Saad", "specialty": "javascript" },
  { "id": 3, "name": "Housni", "specialty": "javascript" }
]
```

### 8) Return reservations by status and username
#### Task Description
Create a function that returns reservations filtered by both `username` and `status`.

#### Input Data
```json
{
  "username": "ali",
  "status": "confirmed",
  "reservations": [
    { "id": 100, "username": "ali", "status": "pending", "type": "hotel" },
    { "id": 101, "username": "ali", "status": "confirmed", "type": "flight" },
    { "id": 102, "username": "sara", "status": "confirmed", "type": "car" },
    { "id": 103, "username": "ali", "status": "confirmed", "type": "car" }
  ]
}
```

#### Expected Output
```json
[
  { "id": 101, "username": "ali", "status": "confirmed", "type": "flight" },
  { "id": 103, "username": "ali", "status": "confirmed", "type": "car" }
]
```

### 9) Abstract Animal with sound and eat behavior
#### Task Description
Create an abstract class `Animal` with:
- abstract method `eat()`
- abstract method `makeSound()`

Create:
- `Carnivore`
- `Herbivore`

Each class implements both methods differently.

#### Input Data
```json
{
  "animals": [
    { "type": "carnivore", "name": "Tiger" },
    { "type": "herbivore", "name": "Horse" }
  ]
}
```

#### Expected Output
```json
[
  "Tiger mange de la viande et fait un rugissement",
  "Horse mange des plantes et fait un hennissement"
]
```

### 10) Garage simulation with speed category
#### Task Description
Using abstract `Vehicule`, compute speed and also classify:
- `lent` if speed < 50
- `normal` if 50 <= speed < 100
- `rapide` if speed >= 100

#### Input Data
```json
{
  "vehicles": [
    { "type": "voiture", "name": "Clio", "distanceKm": 80, "timeH": 2 },
    { "type": "moto", "name": "KTM", "distanceKm": 240, "timeH": 2 }
  ]
}
```

#### Expected Output
```json
[
  "Voiture Clio vitesse: 40 km/h (lent)",
  "Moto KTM vitesse: 120 km/h (rapide)"
]
```

### 11) User class with role validation
#### Task Description
Extend the `User` class by adding a `role` property with validation (`admin`, `coach`, `student` only).
Return a profile summary.

#### Input Data
```json
{
  "name": "Yassine Tazi",
  "email": "yassine@school.ma",
  "role": "coach"
}
```

#### Expected Output
```json
"User(name=Yassine Tazi, email=yassine@school.ma, role=coach)"
```

### 12) findAll + multi-city filtering
#### Task Description
Use `findAll()` to get all drivers, then filter using a list of allowed cities.

#### Input Data
```json
{
  "cities": ["Safi", "Marrakech"],
  "drivers": [
    { "id": 1, "name": "Ali", "city": "Safi" },
    { "id": 2, "name": "Nora", "city": "Casa" },
    { "id": 3, "name": "Samir", "city": "Marrakech" }
  ]
}
```

#### Expected Output
```json
[
  { "id": 1, "name": "Ali", "city": "Safi" },
  { "id": 3, "name": "Samir", "city": "Marrakech" }
]
```
