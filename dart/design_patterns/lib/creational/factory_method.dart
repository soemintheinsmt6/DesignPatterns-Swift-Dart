// Product

abstract class Shape {
  void draw();
}

// Concrete Products

class Circle implements Shape {
  @override
  void draw() {
    print('Drawing a circle');
  }
}

class Rectangle implements Shape {
  @override
  void draw() {
    print('Drawing a rectangle');
  }
}

// Shape Types

enum ShapeType { circle, rectangle }

// Factory

class ShapeFactory {
  static Shape makeShape(ShapeType type) {
    switch (type) {
      case ShapeType.circle:
        return Circle();
      case ShapeType.rectangle:
        return Rectangle();
    }
  }
}

// Usage

void main() {
  final circle = ShapeFactory.makeShape(ShapeType.circle);
  circle.draw();

  final rectangle = ShapeFactory.makeShape(ShapeType.rectangle);
  rectangle.draw();
}
