# Abid - JavaScript String Challenges

### 1) Welcome message formatter
#### Task Description
Create a function `bienvenu(fullName)` that receives a full name separated by one space and returns `Bonjour X.Lastname`.
#### Input Data
```json
"Abid abdeladim"
```
#### Expected Output
```json
"Bonjour A.Abdeladim"
```

### 2) Basic string compression
#### Task Description
Implement basic compression by replacing consecutive repeated characters with `character + count`.
#### Input Data
```json
"aaabbbccccc"
```
#### Expected Output
```json
"a3b3c5"
```

### 3) Anagram checker
#### Task Description
Return `true` if two strings are anagrams (ignore case and spaces), otherwise `false`.
#### Input Data
```json
[
  { "a": "listen", "b": "silent" },
  { "a": "Dormitory", "b": "Dirty room" },
  { "a": "hello", "b": "world" }
]
```
#### Expected Output
```json
[true, true, false]
```

### 4) Basic string decompression
#### Task Description
Reverse run-length compression where each character is followed by its count.
#### Input Data
```json
["a3b3c5", "x1y2z4"]
```
#### Expected Output
```json
["aaabbbccccc", "xyyzzzz"]
```

### 5) Welcome message from multiple names
#### Task Description
For each full name, return `Bonjour X.Lastname` using the first letter of first name and formatted lastname.
#### Input Data
```json
["Abid abdeladim", "Sara benali", "Omar idrissi"]
```
#### Expected Output
```json
["Bonjour A.Abdeladim", "Bonjour S.Benali", "Bonjour O.Idrissi"]
```

### 6) Near-anagram checker
#### Task Description
Return `true` when two words become anagrams after removing exactly one character from one side.
#### Input Data
```json
[
  { "a": "listen", "b": "silentx" },
  { "a": "stone", "b": "tones" },
  { "a": "hello", "b": "world" }
]
```
#### Expected Output
```json
[true, true, false]
```

### 7) Advanced compression with mixed blocks
#### Task Description
Compress consecutive repeated characters, but keep single characters without `1`.
#### Input Data
```json
["aaabbcdddd", "xyz", "ppqqqrr"]
```
#### Expected Output
```json
["a3b2cd4", "xyz", "p2q3r2"]
```

### 8) Welcome formatter with middle names
#### Task Description
Format names with optional middle names as `Bonjour F.Lastname`, using first token for initial and last token as lastname.
#### Input Data
```json
["Abid Mohamed Abdeladim", "Sara Benali", "Omar El Idrissi"]
```
#### Expected Output
```json
["Bonjour A.Abdeladim", "Bonjour S.Benali", "Bonjour O.Idrissi"]
```

### 9) Strict anagram groups
#### Task Description
Group words into anagram buckets and return only groups containing at least 2 words.
#### Input Data
```json
["listen", "silent", "enlist", "stone", "tones", "hello", "below", "elbow"]
```
#### Expected Output
```json
[
  ["below", "elbow"],
  ["listen", "silent", "enlist"],
  ["stone", "tones"]
]
```
