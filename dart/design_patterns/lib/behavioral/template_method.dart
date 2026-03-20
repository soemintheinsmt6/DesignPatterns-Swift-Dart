// Template Method Pattern

// Abstract Template
abstract class HouseBuilder {
  // Template method
  void buildHouse() {
    layFoundation();
    buildWalls();
    buildRoof();
    installDoors();
  }

  void layFoundation();
  void buildWalls();
  void buildRoof();
  void installDoors();
}

// Concrete Builders

class WoodenHouseBuilder extends HouseBuilder {
  @override
  void layFoundation() {
    print('Laying wooden foundation');
  }

  @override
  void buildWalls() {
    print('Building wooden walls');
  }

  @override
  void buildRoof() {
    print('Building wooden roof');
  }

  @override
  void installDoors() {
    print('Installing wooden doors');
  }
}

class BrickHouseBuilder extends HouseBuilder {
  @override
  void layFoundation() {
    print('Laying brick foundation');
  }

  @override
  void buildWalls() {
    print('Building brick walls');
  }

  @override
  void buildRoof() {
    print('Building brick roof');
  }

  @override
  void installDoors() {
    print('Installing brick doors');
  }
}

class GlassHouseBuilder extends HouseBuilder {
  @override
  void layFoundation() {
    print('Laying glass foundation');
  }

  @override
  void buildWalls() {
    print('Building glass walls');
  }

  @override
  void buildRoof() {
    print('Building glass roof');
  }

  @override
  void installDoors() {
    print('Installing glass doors');
  }
}

// Usage
void main() {
  final woodenHouseBuilder = WoodenHouseBuilder();
  woodenHouseBuilder.buildHouse();
}
