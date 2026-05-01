# Saad - JavaScript Array Challenges

### 1) Display all book names from a library object
#### Task Description
Given a JSON object representing a library, display the title of each book.

#### Input Data
```json
{
  "libraryName": "Central Library",
  "books": [
    { "title": "The Great Gatsby", "year": 1925, "pages": 218 },
    { "title": "1984", "year": 1949, "pages": 328 },
    { "title": "Le Petit Prince", "year": 1943, "pages": 96 }
  ]
}
```

#### Expected Output
```json
["The Great Gatsby", "1984", "Le Petit Prince"]
```

### 2) Filter books by year and pages
#### Task Description
Display books where publication year is greater than 1900 and number of pages is greater than 150.

#### Input Data
```json
{
  "books": [
    { "title": "The Great Gatsby", "year": 1925, "pages": 218 },
    { "title": "Le Petit Prince", "year": 1943, "pages": 96 },
    { "title": "Pride and Prejudice", "year": 1813, "pages": 279 },
    { "title": "1984", "year": 1949, "pages": 328 }
  ]
}
```

#### Expected Output
```json
["The Great Gatsby", "1984"]
```

### 3) Rotate array to the right
#### Task Description
Create a function `rotateArray(arr, k)` that shifts array elements to the right by `k` positions.

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

### 4) Count occurrences in an array
#### Task Description
Count how many times each value appears and return an object of frequencies.

#### Input Data
```json
[1, 2, 3, 2, 4, 1, 2, 3, 4]
```

#### Expected Output
```json
{
  "1": 2,
  "2": 3,
  "3": 2,
  "4": 2
}
```

### 5) Find max occurrence in string array
#### Task Description
Return the value with the highest occurrence and its count.

#### Input Data
```json
["js", "php", "js", "python", "java", "php", "js"]
```

#### Expected Output
```json
{
  "value": "js",
  "count": 3
}
```

### 6) Return duplicated values only
#### Task Description
From a string array, return values that appear more than once (without duplicates in result).

#### Input Data
```json
["cat", "dog", "cat", "bird", "dog", "cat"]
```

#### Expected Output
```json
["cat", "dog"]
```

### 7) Display book titles published after a given year
#### Task Description
From a library object, return titles of books with `year > minYear`.

#### Input Data
```json
{
  "minYear": 1950,
  "books": [
    { "title": "The Hobbit", "year": 1937, "pages": 310 },
    { "title": "Clean Code", "year": 2008, "pages": 464 },
    { "title": "The Pragmatic Programmer", "year": 1999, "pages": 352 }
  ]
}
```

#### Expected Output
```json
["Clean Code", "The Pragmatic Programmer"]
```

### 8) Rotate array to the left
#### Task Description
Create a function `rotateLeft(arr, k)` that shifts array elements to the left by `k` positions.

#### Input Data
```json
{
  "arr": [1, 2, 3, 4, 5],
  "k": 2
}
```

#### Expected Output
```json
[3, 4, 5, 1, 2]
```

### 9) Find all values with maximum occurrence
#### Task Description
Return all values that share the highest frequency in the array.

#### Input Data
```json
["js", "php", "js", "php", "python", "java"]
```

#### Expected Output
```json
{
  "maxCount": 2,
  "values": ["js", "php"]
}
```

### 10) Return duplicated numbers only
#### Task Description
From a numeric array, return duplicated values (unique in output, sorted ascending).

#### Input Data
```json
[1, 3, 2, 3, 5, 1, 1, 4, 2]
```

#### Expected Output
```json
[1, 2, 3]
```

### 11) Count books by publication decade
#### Task Description
Count how many books were published in each decade.

#### Input Data
```json
{
  "books": [
    { "title": "Book A", "year": 1991 },
    { "title": "Book B", "year": 1998 },
    { "title": "Book C", "year": 2002 },
    { "title": "Book D", "year": 2007 },
    { "title": "Book E", "year": 2015 }
  ]
}
```

#### Expected Output
```json
{
  "1990s": 2,
  "2000s": 2,
  "2010s": 1
}
```
