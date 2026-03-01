# Design Patterns — Swift & Dart

> 🚧 **Work in Progress** — Patterns are being added incrementally.

A language-agnostic reference implementation of **Gang of Four (GoF) design patterns**, with implementations in **Swift and Dart, designed for extensibility and community contributions across additional languages.

---

## 📁 Project Structure

```
DesignPatterns-Swift-Dart/
├── swift/                  # Swift implementations (Swift Package)
│   └── Sources/
│       └── DesignPatterns/
│           ├── Creational/
│           ├── Structural/
│           └── Behavioral/
└── dart/                   # Dart implementations (Dart package)
    └── design_patterns/
        └── lib/
            ├── creational/
            ├── structural/
            └── behavioral/
```

---

## 🗂️ Patterns

### Creational
| Pattern | Swift | Dart |
|---------|:-----:|:----:|
| Singleton | | |
| Factory Method | | |
| Abstract Factory | | |
| Builder | | |
| Prototype | | |

### Structural
| Pattern | Swift | Dart |
|---------|:-----:|:----:|
| Adapter | | |
| Bridge | | |
| Composite | | |
| Decorator | | |
| Facade | ✅ | ✅ |
| Flyweight | | |
| Proxy | | |

### Behavioral
| Pattern | Swift | Dart |
|---------|:-----:|:----:|
| Chain of Responsibility | | |
| Command | | |
| Iterator | | |
| Mediator | | |
| Memento | | |
| Observer | | |
| State | | |
| Strategy | | |
| Template Method | | |
| Visitor | | |

> ✅ = implemented &nbsp;|&nbsp; 🚧 = in progress &nbsp;|&nbsp; _(blank)_ = coming soon

---

## 🚀 Getting Started

### Swift
Requires Xcode or Swift toolchain (Swift 5.5+).
```bash
cd swift
swift run
```

### Dart
Requires [Dart SDK](https://dart.dev/get-dart) (Dart 3+).
```bash
cd dart/design_patterns
dart pub get
dart run
```

---

## 📖 References

- [Design Patterns — saturngod.net](https://designpatterns.saturngod.net/cover.html)
- [Refactoring Guru — Design Patterns](https://refactoring.guru/design-patterns)
- [Gang of Four — Design Patterns (Book)](https://en.wikipedia.org/wiki/Design_Patterns)
