// Example 1: Event Source

abstract class EventObserver {
  void update(String event);
}

class EventListener implements EventObserver {
  @override
  void update(String event) {
    // Implement the update method
  }
}

class EventSource {
  final List<EventObserver> _observers = [];

  void notifyObservers(String event) {
    for (final observer in _observers) {
      observer.update(event);
    }
  }

  void addObserver(EventObserver observer) {
    _observers.add(observer);
  }
}

void eventSourceExample() {
  final eventSource = EventSource();

  final event1 = EventListener();
  final event2 = EventListener();
  eventSource.addObserver(event1);
  eventSource.addObserver(event2);

  eventSource.notifyObservers('Event occurred');
}

// Example 2: Scoreboard

abstract class ScoreObserver {
  void update(int score);
}

class Scoreboard {
  int _score = 0;
  final List<ScoreObserver> _observers = [];

  void setScore(int newScore) {
    _score = newScore;
    _notifyObservers();
  }

  void registerObserver(ScoreObserver observer) {
    _observers.add(observer);
  }

  void unregisterObserver(ScoreObserver observer) {
    _observers.remove(observer);
  }

  void _notifyObservers() {
    for (final observer in _observers) {
      observer.update(_score);
    }
  }
}

class PlayerScoreDisplay implements ScoreObserver {
  @override
  void update(int score) {
    print('Player score: $score');
  }
}

void scoreboardExample() {
  final scoreboard = Scoreboard();

  final display1 = PlayerScoreDisplay();
  final display2 = PlayerScoreDisplay();
  scoreboard.registerObserver(display1);
  scoreboard.registerObserver(display2);

  scoreboard.setScore(10);
  scoreboard.unregisterObserver(display1);
  scoreboard.setScore(20);
}

void main() {
  eventSourceExample();
  scoreboardExample();
}
