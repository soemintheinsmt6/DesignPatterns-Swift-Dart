// boilerplate such as double-checked locking:
//
// public class Logger {
//     private static volatile Logger instance;
//
//     private Logger() {}
//
//     public static Logger getInstance() {
//         if (instance == null) {
//             synchronized (Logger.class) {
//                 if (instance == null) {
//                     instance = new Logger();
//                 }
//             }
//         }
//         return instance;
//     }
// }
//
// In Dart, a `static final` field is lazily initialized exactly once,
// and since Dart isolates are single-threaded there is no locking to
// worry about. The idiomatic Singleton is a `static final` instance
// with a private named constructor — often exposed through a factory
// constructor so call sites can still write `Logger()`.

// Singleton

class Logger {
  static final Logger _instance = Logger._();

  // Private named constructor prevents creating other instances
  // from outside this library.
  Logger._();

  // Factory constructor always returns the same instance,
  // so `Logger()` at the call site is the singleton.
  factory Logger() => _instance;

  final List<String> history = [];

  void log(String message) {
    history.add(message);
    print('[LOG] $message');
  }
}

// Usage

void main() {
  Logger().log('App started');
  Logger().log('User signed in');

  final logger = Logger();
  logger.log('Fetching data');

  // Both references point to the same instance.
  print('Same instance: ${identical(logger, Logger())}');
  print('History count: ${Logger().history.length}');
}
