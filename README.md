# Nova Programming Language Guide

**Version 1.0.2.** - Now with updated If-Else Statements!

Welcome to Nova! A simple, minimalistic scripting language designed for clarity and ease of use for everyone! :>.

No bots needed! Better flee NOW :<

## Table of Contents

- [Getting Started](#getting-started)
- [Comments](#comments)
- [Variables](#variables)
- [Output](#output)
- [Input](#input)
- [Data Types](#data-types)
- [Arithmetic Operations](#arithmetic-operations)
- [String Operations](#string-operations)
- [Arrays](#arrays)
- [Comparisons](#comparisons)
- [Control Flow](#control-flow)
- [Functions](#functions)
- [File Operations](#file-operations)
- [Complete Examples](#complete-examples)

---

## Getting Started

### Running Nova Scripts

```bash
lua interpreter.lua script.nova
```

Or use the `nova` command wrapper:
```bash
./nova script.nova
```

### Interactive Mode (REPL)

```bash
lua interpreter.lua
```

---

## Comments

Nova supports three comment styles:

```nova
# This is a comment
-- This is also a comment
// This works too!
```

---

## Variables

### Declaring Variables

Use the `let` keyword with a colon (`:`) to assign values:

```nova
let x: 5
let name: "Alice"
let price: 99.99
let active: true
```

### Variable Names

- Must start with a letter or underscore
- Can contain letters, numbers, and underscores
- Examples: `x`, `user_name`, `total_cost`, `item1`

---

## Output

### Basic Output

Print variables:
```nova
let name: "Bob"
out name
```

Print literal text:
```nova
out: Hello, World!
out: Welcome to Nova
```

Print empty lines:
```nova
out: 
```

### Examples

```nova
let score: 95
out: Your score is:
out score
out: Great job!
```

---

## Input

### Reading User Input

Use `input` to read a line from the user:

```nova
out: What is your name?
input username
out: Hello,
out username
```

```nova
out: Enter a number:
input number
out: You entered:
out number
```

---

## Data Types

### Numbers

Integers and decimals:
```nova
let age: 25
let pi: 3.14159
let temperature: -5
```

### Strings

Text enclosed in quotes:
```nova
let greeting: "Hello"
let message: 'Welcome'
let empty: ""
```

### Booleans

True or false values:
```nova
let is_active: true
let is_locked: false
```

### Arrays

Lists of values:
```nova
array numbers: [1, 2, 3, 4, 5]
array names: ["Alice", "Bob", "Carol"]
array mixed: [1, "two", 3.0, true]
```

---

## Arithmetic Operations

### Basic Math

```nova
let x: 10
let y: 5

let sum: add x y              # 15
let difference: sub x y        # 5
let product: mul x y           # 50
let quotient: div x y          # 2
```

### Using with Numbers Directly

```nova
let total: add 25 75           # 100
let half: div 100 2            # 50
```

### Chaining Operations

```nova
let a: 10
let b: 5
let c: 2

let temp: add a b              # 15
let result: mul temp c         # 30
```

### Example: Calculator

```nova
let price: 50
let quantity: 3
let tax_rate: 1.08

let subtotal: mul price quantity    # 150
let total: mul subtotal tax_rate    # 162
out: Total with tax:
out total
```

---

## String Operations

### Length

Get the length of a string:
```nova
let text: "Hello"
let length: len text
out length                     # 5
```

### Uppercase

Convert to uppercase:
```nova
let text: "hello world"
let upper: upper text
out upper                      # HELLO WORLD
```

### Lowercase

Convert to lowercase:
```nova
let text: "HELLO WORLD"
let lower: lower text
out lower                      # hello world
```

### Reverse

Reverse a string:
```nova
let text: "Nova"
let reversed: reverse text
out reversed                   # avoN
```

### Example: Text Processing

```nova
let username: "JohnDoe"
let formatted: lower username
out: Username (lowercase):
out formatted

let message: "welcome to nova"
let title: upper message
out title
```

---

## Arrays

### Creating Arrays

```nova
array fruits: ["apple", "banana", "cherry"]
array numbers: [5, 2, 8, 1, 9]
array empty: []
```

### Displaying Arrays

```nova
array colors: ["red", "green", "blue"]
out colors                     # [red, green, blue]
```

### Sorting Arrays

Sort in ascending order:
```nova
array numbers: [5, 2, 8, 1, 9]
out: Original:
out numbers

sort numbers
out: Sorted:
out numbers                    # [1, 2, 5, 8, 9]
```

### Inserting Elements

Insert a value at a specific position (1-indexed):
```nova
array nums: [1, 2, 4, 5]
insert nums 3 3                # Insert 3 at position 3
out nums                       # [1, 2, 3, 4, 5]
```

### Removing Elements

Remove element at a specific index:
```nova
array nums: [1, 2, 3, 4, 5]
cut nums 1                     # Remove first element
out nums                       # [2, 3, 4, 5]
```

### Example: Managing a List

```nova
array tasks: ["email", "meeting", "report"]
out: Initial tasks:
out tasks

insert tasks 2 "lunch"
out: Added lunch:
out tasks

sort tasks
out: Sorted:
out tasks

cut tasks 1
out: Removed first:
out tasks
```

---

## Comparisons

### Greater Than

Compare two variables:
```nova
let a: 10
let b: 5
greater a b                    # Output: 10 is greater than 5
```

### Less Than

```nova
let x: 3
let y: 7
less x y                       # Output: 3 is less than 7
```

### Greater or Equal

Returns the greater or equal value:
```nova
let score1: 95
let score2: 87
greateroreqt score1 score2     # Output: 95
```

### Less or Equal

Returns the lesser or equal value:
```nova
let price1: 25
let price2: 30
lessoreqt price1 price2        # Output: 25
```

---

## Control Flow

### If Statements

Execute code conditionally using if statements with curly braces:

**Basic if:**
```nova
let x: 5

if x == 5 {
    out: X equals five!
}
```

**If-else:**
```nova
let age: 25

if age >= 18 {
    out: Adult
} else {
    out: Minor
}
```

**Nested if-else:**
```nova
let score: 87

if score >= 90 {
    out: Grade: A
} else {
    if score >= 80 {
        out: Grade: B
    } else {
        if score >= 70 {
            out: Grade: C
        } else {
            out: Grade: F
        }
    }
}
```

### Comparison Operators

All standard comparison operators are supported:

| Operator | Meaning | Example |
|----------|---------|---------|
| `==` | Equal to | `x == 5` |
| `!=` | Not equal to | `x != 0` |
| `>` | Greater than | `x > 10` |
| `<` | Less than | `x < 100` |
| `>=` | Greater or equal | `x >= 18` |
| `<=` | Less or equal | `x <= 50` |

**Examples:**
```nova
# Equality
if name == "Alice" {
    out: Hello Alice!
}

# Not equal
if status != "inactive" {
    out: Account is active
}

# Greater than
if temperature > 90 {
    out: It's hot!
}

# Less than
if count < 10 {
    out: Low count
}

# Greater or equal
if score >= 60 {
    out: Pass
}

# Less or equal
if speed <= 55 {
    out: Within limit
}
```

### Practical If-Else Examples

**Temperature Check:**
```nova
let temp: 72

if temp > 80 {
    out: Hot weather
} else {
    if temp > 60 {
        out: Nice weather
    } else {
        out: Cold weather
    }
}
```

**Password Validator:**
```nova
let password: "secret123"
let min_length: 8
let pass_len: len password

if pass_len >= min_length {
    out: Password accepted
} else {
    out: Password too short
}
```

**Number Comparison:**
```nova
let a: 10
let b: 20

if a > b {
    out: A is larger
} else {
    if a < b {
        out: B is larger
    } else {
        out: Equal
    }
}
```

### Loops

Repeat an action a fixed number of times:

```nova
# Note: Loop syntax uses old-style functions
loop(5, function()
    out: Hello!
end)
```

---

## Functions

### Defining Functions

**Note:** Function definition uses old syntax:

```nova
func("greet", function(name)
    out: Hello
    out(name)
end)
```

### Calling Functions

```nova
call("greet", "Alice")
```

---

## File Operations

### Running Another Script

Execute another Nova file:

```nova
# Assumes script.nova exists
runfile("script")              # .nova extension is optional
```

---

## Complete Examples

### Example 1: Hello World

```nova
# My first Nova program
let name: "World"
out: Hello,
out name
out: Welcome to Nova!
```

### Example 2: Simple Calculator

```nova
# Simple Calculator

let num1: 42
let num2: 8

out: Calculator
out: ==========
out: 

out: Number 1:
out num1
out: Number 2:
out num2
out: 

let sum: add num1 num2
out: Addition:
out sum

let diff: sub num1 num2
out: Subtraction:
out diff

let prod: mul num1 num2
out: Multiplication:
out prod

let quot: div num1 num2
out: Division:
out quot
```

### Example 3: Text Formatter

```nova
# Text Formatter

let text: "Nova Programming Language"

out: Original:
out text

let upper_text: upper text
out: Uppercase:
out upper_text

let lower_text: lower text
out: Lowercase:
out lower_text

let rev_text: reverse text
out: Reversed:
out rev_text

let length: len text
out: Character count:
out length
```

### Example 4: Grade Tracker

```nova
# Grade Tracker

let student: "Alice"
let test1: 95
let test2: 88
let test3: 92

out: Student Grade Report
out: ====================
out: 

out: Student:
out student

out: Test Scores:
out test1
out test2
out test3

let sum12: add test1 test2
let total: add sum12 test3
let average: div total 3

out: Average:
out average
```

### Example 5: Shopping Cart

```nova
# Shopping Cart

let item_name: "Laptop"
let item_price: 999
let quantity: 2

out: Shopping Cart
out: =============
out: 

out: Item:
out item_name
out: Price per unit: $
out item_price
out: Quantity:
out quantity

let subtotal: mul item_price quantity
out: Subtotal: $
out subtotal

let tax: 80
let total: add subtotal tax
out: Tax: $
out tax
out: Total: $
out total
```

### Example 6: Array Operations

```nova
# Array Demo

array numbers: [64, 34, 25, 12, 22, 11, 90]

out: Original array:
out numbers

sort numbers
out: Sorted array:
out numbers

insert numbers 1 5
out: After inserting 5 at position 1:
out numbers

cut numbers 4
out: After removing element at index 4:
out numbers
```

### Example 7: Interactive Program

```nova
# Interactive Greeter

out: What is your name?
input username

out: Hello,
out username
out: Nice to meet you!

out: 
out: How old are you?
input age

out: You are
out age
out: years old.
```

### Example 8: Data Processing

```nova
# Temperature Converter

let fahrenheit: 72
out: Temperature in Fahrenheit:
out fahrenheit

# F to C: (F - 32) * 5/9
let temp1: sub fahrenheit 32
let temp2: mul temp1 5
let celsius: div temp2 9

out: Temperature in Celsius:
out celsius
```

### Example 9: Grade Calculator with If-Else

```nova
# Grade Calculator

let student: "Alice"
let score: 87

out: ========================================
out:      GRADE CALCULATOR
out: ========================================
out: 

out: Student:
out student
out: Score:
out score
out: 

# Determine letter grade
if score >= 90 {
    out: Grade: A
    out: Excellent work!
} else {
    if score >= 80 {
        out: Grade: B
        out: Good job!
    } else {
        if score >= 70 {
            out: Grade: C
            out: Satisfactory
        } else {
            if score >= 60 {
                out: Grade: D
                out: Needs improvement
            } else {
                out: Grade: F
                out: Please see instructor
            }
        }
    }
}

out: 

# Pass/Fail status
if score >= 60 {
    out: Status: PASS
} else {
    out: Status: FAIL
}

out: 
out: ========================================
```

---

## Tips and Best Practices

### 1. Use Descriptive Variable Names

```nova
# Good
let user_age: 25
let total_price: 99.99

# Less clear
let x: 25
let y: 99.99
```

### 2. Add Comments

```nova
# Calculate total with tax
let subtotal: 100
let tax: mul subtotal 0.08
let total: add subtotal tax
```

### 3. Use Empty Output for Spacing

```nova
out: Section 1
out: 
out: Section 2
```

### 4. Break Complex Calculations

```nova
# Instead of nesting everything
let step1: add a b
let step2: mul step1 c
let result: div step2 d
```

### 5. Keep Arrays Organized

```nova
array high_scores: [100, 95, 92, 88]
array players: ["Alice", "Bob", "Carol", "Dave"]
```

---

## Language Reference Quick Guide

| Operation | Syntax | Example |
|-----------|--------|---------|
| Variable | `let name: value` | `let x: 10` |
| Output | `out: text` or `out var` | `out: Hello` |
| Input | `input name` | `input username` |
| If statement | `if condition { }` | `if x == 5 { }` |
| If-else | `if condition { } else { }` | `if x > 0 { } else { }` |
| Equal | `==` | `if x == 5 { }` |
| Not equal | `!=` | `if x != 0 { }` |
| Greater | `>` | `if x > 10 { }` |
| Less | `<` | `if x < 100 { }` |
| Greater/Equal | `>=` | `if x >= 18 { }` |
| Less/Equal | `<=` | `if x <= 50 { }` |
| Add | `add x y` | `let sum: add a b` |
| Subtract | `sub x y` | `let diff: sub a b` |
| Multiply | `mul x y` | `let prod: mul a b` |
| Divide | `div x y` | `let quot: div a b` |
| Uppercase | `upper text` | `let u: upper str` |
| Lowercase | `lower text` | `let l: lower str` |
| Reverse | `reverse text` | `let r: reverse str` |
| Length | `len text` | `let n: len str` |
| Array | `array name: [items]` | `array nums: [1,2,3]` |
| Sort | `sort name` | `sort numbers` |
| Insert | `insert name pos val` | `insert arr 1 10` |
| Cut | `cut name index` | `cut arr 2` |
| Greater | `greater x y` | `greater a b` |
| Less | `less x y` | `less a b` |

---

## Error Messages

Common errors and their meanings:

- `error: division by zero` - Attempted to divide by zero
- `error: array X doesn't exist` - Array not found
- `error: len() expects type string` - Tried to get length of non-string
- `error: file X not found` - Script file doesn't exist
- `error: unknown function 'X'` - Function name not recognized
- `error: invalid if syntax` - Check your if statement condition and braces
- `error: no matching } for if statement` - Missing closing brace for if block

---

## What's Next?

Now that you know Nova basics, try:

1. Writing your own scripts
2. Using if-else for decision making
3. Combining conditions with nested if statements
4. Creating interactive programs with input
5. Processing data with arrays
6. Building calculators and converters

**New in Version 0.2.0:**
- ✅ If-else statements with `{}` syntax
- ✅ All comparison operators (`==`, `!=`, `>`, `<`, `>=`, `<=`)
- ✅ Nested if-else support
- ✅ Conditional logic in your programs

**Coming Soon:**
- `else if` syntax (use nested if-else for now)
- Logical operators (`and`, `or`, `not`)
- While loops with conditions
- For loops
- Switch/case statements

---

**Happy coding with Nova! 🚀**

For more information and updates, check the Nova repository.
