import 'dart:math';

// Adaptee

class MileDistanceCalculator {
  double distance({required String from, required String to}) {
    return Random().nextDouble() * 100;
  }
}

//Interface

abstract class KilometerDistanceProviding {
  double distanceInKilometers({required String from, required String to});
}

// Adapter

class KilometerDistanceAdapter implements KilometerDistanceProviding {
  final MileDistanceCalculator _mileCalculator;

  KilometerDistanceAdapter({required MileDistanceCalculator mileCalculator})
      : _mileCalculator = mileCalculator;

  @override
  double distanceInKilometers({required String from, required String to}) {
    final miles = _mileCalculator.distance(from: from, to: to);
    return miles * 1.609344;
  }
}

// Usage

void main() {
  final mileCalculator = MileDistanceCalculator();
  final miles = mileCalculator.distance(from: 'city1', to: 'city2');
  print('The distance between city1 and city2 = $miles miles');

  final kilometerAdapter = KilometerDistanceAdapter(
      mileCalculator: mileCalculator);
  final kilometers = kilometerAdapter.distanceInKilometers(
      from: 'city3', to: 'city4');
  print('The distance between city3 and city4 = $kilometers kilometers');
}
