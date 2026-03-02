// Intent: Provide a simplified interface to a complex subsystem
// of classes, making it easier to use.

// Subsystem Classes

class Projector {
  void on() => print('Projector: Turning on...');

  void off() => print('Projector: Turning off...');

  void setInput(String input) => print('Projector: Setting input to $input.');

  void wideScreenMode() => print('Projector: Setting widescreen mode (16:9).');
}

class SoundSystem {
  void on() => print('SoundSystem: Turning on...');

  void off() => print('SoundSystem: Turning off...');

  void setVolume(int level) => print('SoundSystem: Setting volume to $level.');

  void setSurroundSound() => print('SoundSystem: Setting surround sound mode.');
}

class DVDPlayer {
  void on() => print('DVDPlayer: Turning on...');

  void off() => print('DVDPlayer: Turning off...');

  void play(String movie) => print('DVDPlayer: Playing "$movie".');

  void stop() => print('DVDPlayer: Stopping playback.');

  void eject() => print('DVDPlayer: Ejecting disc.');
}

// Facade

class HomeTheaterFacade {
  final Projector _projector;
  final SoundSystem _soundSystem;
  final DVDPlayer _dvdPlayer;

  HomeTheaterFacade({
    required Projector projector,
    required SoundSystem soundSystem,
    required DVDPlayer dvdPlayer,
  }) : _projector = projector,
       _soundSystem = soundSystem,
       _dvdPlayer = dvdPlayer;

  /// One-call setup to watch a movie
  void watchMovie(String movie) {
    _projector.on();
    _projector.wideScreenMode();
    _projector.setInput('DVD');
    _soundSystem.on();
    _soundSystem.setSurroundSound();
    _soundSystem.setVolume(8);
    _dvdPlayer.on();
    _dvdPlayer.play(movie);
  }

  /// One-call teardown after the movie
  void endMovie() {
    _dvdPlayer.stop();
    _dvdPlayer.eject();
    _dvdPlayer.off();
    _soundSystem.off();
    _projector.off();
  }
}

// Usage / Client Code

void main() {
  final projector = Projector();
  final soundSystem = SoundSystem();
  final dvdPlayer = DVDPlayer();

  final homeTheater = HomeTheaterFacade(
    projector: projector,
    soundSystem: soundSystem,
    dvdPlayer: dvdPlayer,
  );

  homeTheater.watchMovie('Inception');
  homeTheater.endMovie();
}

// ─────────────────────────────────────────────

/// Facade Pattern — User Management Example
///
/// Intent: Provide a simplified interface to a complex subsystem
/// of classes, making it easier to use.

// Model

class User {
  final String id;
  final String name;

  User({required this.id, required this.name});

  @override
  String toString() => 'User(id: $id, name: $name)';
}

// Subsystem Classes

class UserRepository {
  final Map<String, User> _store = {};

  User saveUser(User user) {
    _store[user.id] = user;
    print('UserRepository: Saved $user.');
    return user;
  }

  User? getUserById(String userId) {
    final user = _store[userId];
    print('UserRepository: Fetched ${user ?? "null"} for id=$userId.');
    return user;
  }

  void deleteUser(String userId) {
    _store.remove(userId);
    print('UserRepository: Deleted user id=$userId.');
  }
}

class EmailService {
  void sendWelcomeEmail(User user) =>
      print('EmailService: Sent welcome email to ${user.name}.');
}

// Business Logic Layer

class UserManager {
  final UserRepository _userRepository;
  final EmailService _emailService;

  UserManager({
    required UserRepository userRepository,
    required EmailService emailService,
  }) : _userRepository = userRepository,
       _emailService = emailService;

  User createUser(String name) {
    final newUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
    );
    final savedUser = _userRepository.saveUser(newUser);
    _emailService.sendWelcomeEmail(savedUser);
    return savedUser;
  }

  User? getUserById(String userId) => _userRepository.getUserById(userId);

  void deleteUser(String userId) => _userRepository.deleteUser(userId);
}

// Facade

class UserManagementFacade {
  final UserManager _userManager;

  UserManagementFacade()
    : _userManager = UserManager(
        userRepository: UserRepository(),
        emailService: EmailService(),
      );

  User createUser(String name) => _userManager.createUser(name);

  User? getUserById(String userId) => _userManager.getUserById(userId);

  void deleteUser(String userId) => _userManager.deleteUser(userId);
}

// Usage / Client Code

void userManagementExample() {
  final facade = UserManagementFacade();

  final newUser = facade.createUser('John Doe');
  facade.getUserById(newUser.id);
  facade.deleteUser(newUser.id);
}
