# Housni - JavaScript Array Challenges

### 1) Group people by gender
#### Task Description
Given an array of people objects `{ name, gender }`, group names by gender and return an object with gender keys.

#### Input Data
```json
[
  { "name": "Ali", "gender": "male" },
  { "name": "Sara", "gender": "female" },
  { "name": "Omar", "gender": "male" },
  { "name": "Leila", "gender": "female" }
]
```

#### Expected Output
```json
{
  "male": ["Ali", "Omar"],
  "female": ["Sara", "Leila"]
}
```

### 2) Check if all elements are unique
#### Task Description
Return `true` if all elements in the array are unique, otherwise return `false`.

#### Input Data
```json
[
  [1, 2, 3, 4],
  [1, 2, 2, 4]
]
```

#### Expected Output
```json
[true, false]
```

### 3) Count by nationality
#### Task Description
Count how many people belong to each nationality code.

#### Input Data
```json
[
  { "name": "Ali", "nationality": "MA" },
  { "name": "Sara", "nationality": "FR" },
  { "name": "Omar", "nationality": "MA" },
  { "name": "John", "nationality": "US" },
  { "name": "Leila", "nationality": "FR" }
]
```

#### Expected Output
```json
{
  "MA": 2,
  "FR": 2,
  "US": 1
}
```

### 4) Group people by age category
#### Task Description
Group people names into two categories:
- `adult` for age >= 18
- `minor` for age < 18

#### Input Data
```json
[
  { "name": "Ali", "age": 22 },
  { "name": "Sara", "age": 17 },
  { "name": "Omar", "age": 30 },
  { "name": "Lina", "age": 15 }
]
```

#### Expected Output
```json
{
  "adult": ["Ali", "Omar"],
  "minor": ["Sara", "Lina"]
}
```

### 5) Check unique names in objects
#### Task Description
Return `true` if all `name` values are unique in the array of objects, otherwise return `false`.

#### Input Data
```json
[
  [
    { "name": "Ali" },
    { "name": "Sara" },
    { "name": "Omar" }
  ],
  [
    { "name": "Ali" },
    { "name": "Sara" },
    { "name": "Ali" }
  ]
]
```

#### Expected Output
```json
[true, false]
```

### 6) Count by city
#### Task Description
Count how many users belong to each city code.

#### Input Data
```json
[
  { "name": "Ali", "city": "CASA" },
  { "name": "Sara", "city": "RABAT" },
  { "name": "Omar", "city": "CASA" },
  { "name": "Leila", "city": "FES" },
  { "name": "Yassine", "city": "RABAT" }
]
```

#### Expected Output
```json
{
  "CASA": 2,
  "RABAT": 2,
  "FES": 1
}
```

### 7) Group by first letter
#### Task Description
Group names by their first letter.

#### Input Data
```json
["Ali", "Amal", "Sara", "Samir", "Omar"]
```

#### Expected Output
```json
{
  "A": ["Ali", "Amal"],
  "S": ["Sara", "Samir"],
  "O": ["Omar"]
}
```
