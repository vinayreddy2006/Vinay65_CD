# MyCompiler - Mini Expression Compiler

This is a custom compiler built using **Flex**, **Bison**, and **C++** that parses and evaluates mathematical expressions and domain-specific statements like `VINAY`.

## 🧾 Features

- Parses arithmetic expressions like:
  ```
  a = b + c * t

  ```
- Custom formats:

  - `VINAY a = b, c, t;` → Custom logic: `a = b + c * t`
- Generates:
  - Three Address Code (TAC)
  - Optimized pseudo-instructions
  - Final code representation

## 🛠 Build Instructions

### Requirements
- Flex
- Bison
- A C++ compiler (e.g., g++)

### Compile & Run

```bash
make
./mycompiler
```

### Clean the project
```bash
make clean
```

## 🧪 Example Input

```
VINAY a = 10, 2, 5;
```

### Output

```
[Three Address Code]
t1 = 2.00 * 5.00
t2 = 10.00 + t1
a = t2

[Optimized Instructions]
VINAY a = 10, 2, 5

[Evaluated Result] a = 20.00

[Final Code]
STORE a
```

## 📂 Project Structure

- `lexer.l` – Tokenizer using Flex
- `parser.y` – Grammar and logic using Bison
- `main.cpp` – Main driver for the compiler
- `Makefile` – Build instructions

---

Happy compiling! 🚀
