// Abstract Products

abstract class Button {
  void render();
}

abstract class Checkbox {
  void render();
}

// Concrete Products — Light family

class LightButton implements Button {
  @override
  void render() {
    print('Rendering a light button');
  }
}

class LightCheckbox implements Checkbox {
  @override
  void render() {
    print('Rendering a light checkbox');
  }
}

// Concrete Products — Dark family

class DarkButton implements Button {
  @override
  void render() {
    print('Rendering a dark button');
  }
}

class DarkCheckbox implements Checkbox {
  @override
  void render() {
    print('Rendering a dark checkbox');
  }
}

// Abstract Factory

abstract class UIFactory {
  Button makeButton();
  Checkbox makeCheckbox();
}

// Concrete Factories

class LightUIFactory implements UIFactory {
  @override
  Button makeButton() => LightButton();

  @override
  Checkbox makeCheckbox() => LightCheckbox();
}

class DarkUIFactory implements UIFactory {
  @override
  Button makeButton() => DarkButton();

  @override
  Checkbox makeCheckbox() => DarkCheckbox();
}

// Client — depends only on the abstract factory, so the whole UI stays
// in one family without the client knowing which one.

void renderForm(UIFactory factory) {
  final button = factory.makeButton();
  final checkbox = factory.makeCheckbox();
  button.render();
  checkbox.render();
}

// Usage

void main() {
  print('-- Light theme --');
  renderForm(LightUIFactory());

  print('-- Dark theme --');
  renderForm(DarkUIFactory());
}
