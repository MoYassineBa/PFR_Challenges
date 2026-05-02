# Achraf - JavaScript String Manipulation Challenges

### 1) Basic run-length compression

#### Task Description

Compress consecutive repeated characters into `character + count`.

#### Input Data

```json
"aaabbbccccc"
```

#### Expected Output

```json
"a3b3c5"
```

---

### 2) Longest word in a sentence

#### Task Description

Write a function that returns the longest word in a sentence (ignore punctuation attached to words for length comparison).

#### Input Data

```json
"Le développement web est un domaine fascinant"
```

#### Expected Output

```json
"développement"
```

---

### 3) Word frequency in a text

#### Task Description

Write a function that counts how many times each word appears in a text. Normalize to lowercase and split on whitespace; ignore empty tokens.

#### Input Data

```json
"le web le développement le web"
```

#### Expected Output

```json
{
  "le": 3,
  "web": 2,
  "développement": 1
}
```

---

### 4) Native `split` with custom separator

#### Task Description

Implement a function `splitNative(text, separator)` that behaves like `String.prototype.split` for a **single-character** separator (no regex). Handle edge cases: empty string, separator not found, trailing separator.

#### Input Data

```json
{
  "text": "a,b,c,",
  "separator": ","
}
```

#### Expected Output

```json
["a", "b", "c", ""]
```

---

### 5) Native `split` with separator and max parts

#### Task Description

Extend the native split: given `text`, `separator`, and `limit` (maximum number of segments), return at most `limit` parts (first segments stay intact; the rest can be merged in the last element, like `split` with limit).

#### Input Data

```json
{
  "text": "one:two:three:four",
  "separator": ":",
  "limit": 2
}
```

#### Expected Output

```json
["one", "two:three:four"]
```

---

### 6) Palindrome (word or phrase)

#### Task Description

Detect if a word or phrase is a palindrome after normalizing: lowercase, remove non-alphanumeric characters (accents may be stripped or kept consistently — document your choice). Spaces and punctuation are ignored.

#### Input Data

```json
["radar", "Madam I'm Adam"]
```

#### Expected Output

```json
[true, true]
```

---

### 7) Run-length decompression

#### Task Description

Expand a compressed string where each letter is followed by its repeat count (digits may be multi-digit for longer runs — optional stretch; here single-digit counts only).

#### Input Data

```json
"a3b3c5"
```

#### Expected Output

```json
"aaabbbccccc"
```

---

### 8) Shortest word in a sentence

#### Task Description

Return the shortest word (by character length after stripping punctuation). If several tie, return the first.

#### Input Data

```json
"Le web moderne utilise JavaScript"
```

#### Expected Output

```json
"Le"
```

---

### 9) Character frequency (letters only)

#### Task Description

Count occurrences of each letter in lowercase; ignore spaces and non-letters.

#### Input Data

```json
"Hello, HELLO"
```

#### Expected Output

```json
{
  "h": 2,
  "e": 2,
  "l": 8,
  "o": 2
}
```

---

### 10) Native `join` with custom separator

#### Task Description

Implement `joinNative(parts, separator)` that concatenates array elements with `separator` between them (no built-in `Array.prototype.join`).

#### Input Data

```json
{
  "parts": ["a", "b", "c"],
  "separator": "-"
}
```

#### Expected Output

```json
"a-b-c"
```

---

### 11) Palindrome — negative examples

#### Task Description

Same normalization rules as challenge 6; return boolean per string.

#### Input Data

```json
["hello", "race a car"]
```

#### Expected Output

```json
[false, false]
```

---

### 12) Word frequency with punctuation stripped from words

#### Task Description

Split on whitespace; for each token, remove leading/trailing punctuation before counting (same word-family as challenge 3).

#### Input Data

```json
"Web, web. Web!"
```

#### Expected Output

```json
{
  "web": 3
}
```
