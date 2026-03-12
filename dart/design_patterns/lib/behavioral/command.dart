// Intent: Encapsulate a request as an object, letting you parameterize
// clients with different requests and decouple sender from receiver.

// Command
// Declares the interface for executing an operation.

abstract interface class Command {
  void execute();
}

// Receiver
// The object that knows how to perform the actual work.
// Commands delegate to the receiver to carry out requests.

class TextEditor {
  void save() => print('TextEditor: Saving the document.');

  void open() => print('TextEditor: Opening a document.');

  void printDocument() => print('TextEditor: Printing the document.');
}

// Concrete Commands
// Each command wraps a specific action on the receiver.

class SaveCommand implements Command {
  final TextEditor _textEditor;

  SaveCommand(TextEditor textEditor) : _textEditor = textEditor;

  @override
  void execute() => _textEditor.save();
}

class OpenCommand implements Command {
  final TextEditor _textEditor;

  OpenCommand(TextEditor textEditor) : _textEditor = textEditor;

  @override
  void execute() => _textEditor.open();
}

class PrintCommand implements Command {
  final TextEditor _textEditor;

  PrintCommand(TextEditor textEditor) : _textEditor = textEditor;

  @override
  void execute() => _textEditor.printDocument();
}

// Invokers
// Hold a command and trigger it without knowing what the command does.
// Decoupling the sender from the receiver is the key benefit of the pattern.

class Button {
  final Command _command;

  Button(Command command) : _command = command;

  void click() => _command.execute();
}

class Shortcut {
  final Command _command;

  Shortcut(Command command) : _command = command;

  void press() => _command.execute();
}

// Client / Usage
// The client wires up receivers, commands, and invokers.

void commandExample() {
  final textEditor = TextEditor();

  // Wrap each action in a concrete command
  final saveCommand  = SaveCommand(textEditor);
  final openCommand  = OpenCommand(textEditor);
  final printCommand = PrintCommand(textEditor);

  // Assign commands to invokers
  final saveButton    = Button(saveCommand);
  final openButton    = Button(openCommand);
  final printShortcut = Shortcut(printCommand);

  // Trigger via invokers — no direct coupling to TextEditor
  saveButton.click();
  openButton.click();
  printShortcut.press();
}

// Example 2: Command with History
// Demonstrates the Command pattern with Undo/Redo support.

// Command Interface
// Declares execution and rollback methods.
abstract interface class UndoableCommand {
  void execute();
  void unExecute();
}

// Receiver
// Performs the actual business logic (e.g., managing a list).
class StackStore {
  final List<int> _items = [];

  List<int> get items => List.unmodifiable(_items);

  void push(int value) => _items.add(value);

  int? pop() => _items.isNotEmpty ? _items.removeLast() : null;
}

// Concrete Commands
// Encapsulates a specific action and the data required to perform/undo it.

class PushCommand implements UndoableCommand {
  final StackStore _receiver;
  final int _value;

  PushCommand({required StackStore receiver, required int value})
      : _receiver = receiver,
        _value = value;

  @override
  void execute() => _receiver.push(_value);

  @override
  void unExecute() => _receiver.pop();
}

class PopCommand implements UndoableCommand {
  final StackStore _receiver;
  int? _popped;

  PopCommand({required StackStore receiver}) : _receiver = receiver;

  @override
  void execute() => _popped = _receiver.pop();

  @override
  void unExecute() {
    if (_popped != null) _receiver.push(_popped!);
  }
}

// Invoker
// Stores executed commands and handles undo/redo logic.
class CommandManager {
  final List<UndoableCommand> _history = [];
  final List<UndoableCommand> _undoList = [];

  void execute(UndoableCommand command) {
    command.execute();
    _history.add(command);
    _undoList.clear(); // Clear redo history on new action
  }

  void undo() {
    if (_history.isEmpty) return;
    final command = _history.removeLast();
    command.unExecute();
    _undoList.add(command);
  }

  void redo() {
    if (_undoList.isEmpty) return;
    final command = _undoList.removeLast();
    command.execute();
    _history.add(command);
  }
}

// Usage
void commandWithUndoExample() {
  final receiver = StackStore();
  final manager = CommandManager();

  final pushC1 = PushCommand(receiver: receiver, value: 6);
  manager.execute(pushC1);
  print(receiver.items); // [6]

  final pushC2 = PushCommand(receiver: receiver, value: 3);
  manager.execute(pushC2);
  print(receiver.items); // [6, 3]

  final popC1 = PopCommand(receiver: receiver);
  manager.execute(popC1);
  print(receiver.items); // [6]

  manager.undo();
  print(receiver.items); // [6, 3]
}

// Example 3: Use Command as Replay
// Demonstrates using the Command pattern to record a sequence of actions and replay them.

// 1. Receiver
// The object performing the actual work.
class Robot {
  int x = 0;
  int y = 0;

  void moveForward() {
    y += 1;
    print('Robot moved forward to ($x, $y)');
  }

  void moveBackward() {
    y -= 1;
    print('Robot moved backward to ($x, $y)');
  }

  void moveLeft() {
    x -= 1;
    print('Robot moved left to ($x, $y)');
  }

  void moveRight() {
    x += 1;
    print('Robot moved right to ($x, $y)');
  }
}

// 2. Concrete Commands

class ForwardCommand implements UndoableCommand {
  final Robot _robot;
  ForwardCommand(Robot robot) : _robot = robot;

  @override
  void execute() => _robot.moveForward();
  @override
  void unExecute() => _robot.moveBackward();
}

class BackwardCommand implements UndoableCommand {
  final Robot _robot;
  BackwardCommand(Robot robot) : _robot = robot;

  @override
  void execute() => _robot.moveBackward();
  @override
  void unExecute() => _robot.moveForward();
}

class LeftCommand implements UndoableCommand {
  final Robot _robot;
  LeftCommand(Robot robot) : _robot = robot;

  @override
  void execute() => _robot.moveLeft();
  @override
  void unExecute() => _robot.moveRight();
}

class RightCommand implements UndoableCommand {
  final Robot _robot;
  RightCommand(Robot robot) : _robot = robot;

  @override
  void execute() => _robot.moveRight();
  @override
  void unExecute() => _robot.moveLeft();
}

// 3. Invoker
// Stores commands and manages the current state index for undo/redo and replay.
class ReplayManager {
  final List<UndoableCommand> _commands = [];
  int _currentIndex = -1; // Points to the index of the last executed command

  void execute(UndoableCommand command) {
    // If we execute a new command after undoing, we drop the redo history
    if (_currentIndex < _commands.length - 1) {
      _commands.removeRange(_currentIndex + 1, _commands.length);
    }

    _commands.add(command);
    command.execute();
    _currentIndex += 1;
  }

  void undo() {
    if (_currentIndex < 0) return;
    _commands[_currentIndex].unExecute();
    _currentIndex -= 1;
  }

  void redo() {
    if (_currentIndex >= _commands.length - 1) return;
    _currentIndex += 1;
    _commands[_currentIndex].execute();
  }

  void replay() {
    // Replay all commands up to the current index
    if (_currentIndex < 0) return;
    for (var i = 0; i <= _currentIndex; i++) {
      _commands[i].execute();
    }
  }
}

// Usage
void commandAsReplayExample() {
  final robot = Robot();
  final manager = ReplayManager();

  final forward = ForwardCommand(robot);
  final left = LeftCommand(robot);
  final right = RightCommand(robot);

  manager.execute(forward); // (0, 1)
  manager.execute(left);    // (-1, 1)
  manager.execute(forward); // (-1, 2)
  manager.execute(right);   // (0, 2)

  manager.undo(); // undo right -> moves left. Robot is at (-1, 2)
  manager.redo(); // redo right -> moves right. Robot is at (0, 2)

  robot.x = 0;
  robot.y = 0;
  manager.replay(); // Outputs the sequence of the 4 accepted commands
}

void main() {
  commandExample();
  commandWithUndoExample();
  commandAsReplayExample();
}
