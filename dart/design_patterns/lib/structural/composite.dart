// Composite Pattern

// Component
abstract class FileComponent {
  final String name;

  FileComponent(this.name);

  int getSize();
  void printInfo();
}

// Leaf
class File extends FileComponent {
  final int _sizeInBytes;

  File(super.name, this._sizeInBytes);

  @override
  int getSize() => _sizeInBytes;

  @override
  void printInfo() {
    print('--- file $name size=${getSize()} bytes');
  }
}

// Composite
class Directory extends FileComponent {
  final List<FileComponent> _components = [];

  Directory(super.name);

  void addComponent(FileComponent component) {
    _components.add(component);
  }

  @override
  int getSize() => _components.fold(0, (sum, c) => sum + c.getSize());

  @override
  void printInfo() {
    print('-- dir $name size=${getSize()} bytes');
    for (final component in _components) {
      component.printInfo();
    }
  }
}

// Usage
void compositeExample() {
  final file1 = File('document.txt', 1024);
  final file2 = File('image.png', 2048);
  final file3 = File('notes.md', 512);

  final subDir = Directory('subfolder')
    ..addComponent(file2)
    ..addComponent(file3);

  final rootDir = Directory('root')
    ..addComponent(file1)
    ..addComponent(subDir);

  rootDir.printInfo();
}
