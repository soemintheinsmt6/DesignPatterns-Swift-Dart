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

void main() {
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
