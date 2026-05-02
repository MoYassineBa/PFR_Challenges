# Achraf - JavaScript Array Challenges

### 1) Find pairs whose sum equals a target

#### Task Description

Given an array of numbers and a target sum, return all unique pairs `[a, b]` such that `a + b` equals the target (each pair appears once, with `a < b`).

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

---

### 2) Integer that repeats the most

#### Task Description

Write a function that returns the integer that appears **most often** in an array of integers. If several values tie for the maximum count, return any one of them (or all ties — specify in your implementation).

#### Input Data

```json
[1, 2, 3, 2, 4, 1, 2, 3, 4]
```

#### Expected Output

```json
2
```

*(Notes MES : logique partiellement correcte — renforcer le comptage et le max.)*

---

### 3) Find triplets whose sum equals a target

#### Task Description

Given an array of numbers and a target, return all **unique** triplets `[a, b, c]` with `a <= b <= c` such that `a + b + c` equals the target.

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

---

### 4) All integers tied for maximum frequency

#### Task Description

Return **every** integer that reaches the highest occurrence count (same family as challenge 2, but return an array sorted ascending).

#### Input Data

```json
[1, 2, 2, 3, 3, 4]
```

#### Expected Output

```json
[2, 3]
```

---

### 5) Check if all numbers in the array are unique

#### Task Description

Return `true` if every element appears exactly once, otherwise `false`.

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

---

### 6) Rotate array to the right by k positions

#### Task Description

Implement `rotateRight(arr, k)` — shift elements k steps to the right (same idea as nested-loop discussion for pairs: indices and boundaries).

#### Input Data

```json
{
  "arr": [1, 2, 3, 4, 5],
  "k": 2
}
```

#### Expected Output

```json
[4, 5, 1, 2, 3]
```
