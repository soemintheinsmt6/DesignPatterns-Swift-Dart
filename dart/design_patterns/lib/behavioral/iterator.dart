// Intent: Provide a way to access elements of a collection
// sequentially without exposing its underlying representation.

// Iterator
// Defines the interface for accessing and traversing elements.

abstract interface class MyIterator {
  bool get hasNext;
  int? next();
}

// Aggregate
// Defines the interface for creating an iterator.

abstract interface class MyAggregate {
  MyIterator createIterator();
}

// Concrete Iterator
// Implements the iterator interface and tracks the current position.

class MyCollectionIterator implements MyIterator {
  final List<int> _items;
  int _currentIndex = 0;

  MyCollectionIterator(this._items);

  @override
  bool get hasNext => _currentIndex < _items.length;

  @override
  int? next() {
    if (!hasNext) return null;
    final item = _items[_currentIndex];
    _currentIndex++;
    return item;
  }
}

// Concrete Aggregate
// Implements the aggregate interface and returns a concrete iterator.

class MyCollection implements MyAggregate {
  final List<int> _items;

  MyCollection(this._items);

  @override
  MyIterator createIterator() => MyCollectionIterator(_items);
}

// Usage
// Iterate through the collection without knowing its internal structure.

void iteratorExample() {
  final items = [1, 2, 3, 4, 5];
  final myCollection = MyCollection(items);
  final iterator = myCollection.createIterator();

  while (iterator.hasNext) {
    print(iterator.next());
  }
}

void main() {
  iteratorExample();
}
