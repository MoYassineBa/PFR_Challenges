# Abid - JavaScript Array Challenges

### 1) Find pairs with target sum
#### Task Description
Given an array of numbers and a target value, return all unique pairs `[a, b]` where `a + b = target`.
#### Input Data
```json
{
  "numbers": [3, 1, 5, 7, 9, 2, 6, 4, 8],
  "target": 10
}
```
#### Expected Output
```json
[[1, 9], [2, 8], [3, 7], [4, 6]]
```

### 2) Number occurrence counter
#### Task Description
Count how many times each number appears in an array.
#### Input Data
```json
[2, 5, 2, 8, 5, 2, 1, 8, 8, 8]
```
#### Expected Output
```json
{ "1": 1, "2": 3, "5": 2, "8": 4 }
```

### 3) Insert zero at position
#### Task Description
Implement `AjouterZero(array, position)` to insert `0` into the array at the given index.
#### Input Data
```json
{
  "array": [5, 9, 2, 7],
  "position": 2
}
```
#### Expected Output
```json
[5, 9, 0, 2, 7]
```

### 4) Remove element at position
#### Task Description
Implement `SupprimerPosition(array, position)` to remove the value at the given index.
#### Input Data
```json
{
  "array": [5, 9, 2, 7],
  "position": 1
}
```
#### Expected Output
```json
[5, 2, 7]
```

### 5) Find triplets with target sum
#### Task Description
Given an array and a target, return all unique triplets `[a, b, c]` where `a + b + c = target`.
#### Input Data
```json
{
  "numbers": [1, 2, 3, 4, 5, 6],
  "target": 10
}
```
#### Expected Output
```json
[[1, 3, 6], [1, 4, 5], [2, 3, 5]]
```

### 6) Occurrence counter with sorted output
#### Task Description
Count occurrences of each number and return an array sorted by number ascending.
#### Input Data
```json
[4, 2, 4, 1, 2, 4, 3, 1]
```
#### Expected Output
```json
[
  { "number": 1, "count": 2 },
  { "number": 2, "count": 2 },
  { "number": 3, "count": 1 },
  { "number": 4, "count": 3 }
]
```

### 7) Count pairs with exact target frequency
#### Task Description
Return how many unique pairs sum to target, and include the pairs sorted ascending.
#### Input Data
```json
{
  "numbers": [1, 1, 2, 2, 3, 3, 4, 4, 5],
  "target": 6
}
```
#### Expected Output
```json
{
  "count": 3,
  "pairs": [[1, 5], [2, 4], [3, 3]]
}
```

### 8) Insert value at multiple positions
#### Task Description
Insert value `0` at all given positions (positions are based on original array indexes).
#### Input Data
```json
{
  "array": [7, 8, 9, 10],
  "positions": [1, 3]
}
```
#### Expected Output
```json
[7, 0, 8, 9, 0, 10]
```

### 9) Top-k frequent numbers
#### Task Description
Return the `k` most frequent numbers sorted by frequency desc, then number asc on ties.
#### Input Data
```json
{
  "numbers": [4, 1, 2, 2, 3, 3, 3, 4, 4, 4, 5],
  "k": 3
}
```
#### Expected Output
```json
[4, 3, 2]
```
