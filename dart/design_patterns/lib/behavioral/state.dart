// Real World Problem

String currentState = 'Red';

void changeState() {
  if (currentState == 'Red') {
    currentState = 'Green';
  } else if (currentState == 'Green') {
    currentState = 'Yellow';
  } else if (currentState == 'Yellow') {
    currentState = 'Red';
  }
}

void processFunction() {
  if (currentState == 'Red') {
    print('Stop the car');
  } else if (currentState == 'Green') {
    print('Allow to go');
  } else if (currentState == 'Yellow') {
    print('Slow down');
  }
}

void stateProblemExample() {
  changeState();
  processFunction();
  print(currentState);
}

// State Pattern Solution

abstract class LightState {
  String get color;
  void change(TrafficLight light);
  void process();
}

class TrafficLight {
  LightState _currentLightState;

  TrafficLight(this._currentLightState);

  void changeState() {
    _currentLightState.change(this);
  }

  void process() {
    _currentLightState.process();
  }

  String get currentColor => _currentLightState.color;

  void setState(LightState state) {
    _currentLightState = state;
  }
}

class RedLightState implements LightState {
  @override
  String get color => 'Red';

  @override
  void change(TrafficLight light) {
    light.setState(YellowLightState());
  }

  @override
  void process() {
    print('Stop the car');
  }
}

class YellowLightState implements LightState {
  @override
  String get color => 'Yellow';

  @override
  void change(TrafficLight light) {
    light.setState(GreenLightState());
  }

  @override
  void process() {
    print('Slow down');
  }
}

class GreenLightState implements LightState {
  @override
  String get color => 'Green';

  @override
  void change(TrafficLight light) {
    light.setState(RedLightState());
  }

  @override
  void process() {
    print('Allow to go');
  }
}

void stateExample() {
  final red = RedLightState();
  final trafficLight = TrafficLight(red);
  print(trafficLight.currentColor);
  trafficLight.process();
  trafficLight.changeState();
  print(trafficLight.currentColor);
  trafficLight.process();
}

void main() {
  stateProblemExample();
  stateExample();
}
