// Intent: Define a family of algorithms, encapsulate each one,
// and make them interchangeable at runtime.

// Strategy
// Defines the interface for interchangeable algorithms.

abstract interface class RouteStrategy {
  void calculateRoute(String startPoint, String endPoint);
}

// Concrete Strategies
// Each strategy encapsulates a specific route calculation algorithm.

class CarRouteStrategy implements RouteStrategy {
  @override
  void calculateRoute(String startPoint, String endPoint) {
    print('Calculating car route from $startPoint to $endPoint');
  }
}

class BusRouteStrategy implements RouteStrategy {
  @override
  void calculateRoute(String startPoint, String endPoint) {
    print('Calculating bus route from $startPoint to $endPoint');
  }
}

class WalkRouteStrategy implements RouteStrategy {
  @override
  void calculateRoute(String startPoint, String endPoint) {
    print('Calculating walk route from $startPoint to $endPoint');
  }
}

// Context
// Maintains a reference to a strategy and delegates the work to it.

class NavigationContext {
  RouteStrategy _routeStrategy;

  NavigationContext(RouteStrategy routeStrategy)
      : _routeStrategy = routeStrategy;

  void setRouteStrategy(RouteStrategy strategy) {
    _routeStrategy = strategy;
  }

  void calculateRoute(String startPoint, String endPoint) {
    _routeStrategy.calculateRoute(startPoint, endPoint);
  }
}

// Usage
// Swap strategies at runtime without changing the context.

void strategyExample() {
  final navigationContext = NavigationContext(BusRouteStrategy());
  navigationContext.calculateRoute('Start Point', 'End Point');

  navigationContext.setRouteStrategy(CarRouteStrategy());
  navigationContext.calculateRoute('Start Point', 'End Point');

  navigationContext.setRouteStrategy(WalkRouteStrategy());
  navigationContext.calculateRoute('Start Point', 'End Point');
}

// Example 2: Sorting Strategy

// Strategy

abstract interface class SortStrategy {
  void sort(List<int> list);
}

// Concrete Strategies

class BubbleSort implements SortStrategy {
  @override
  void sort(List<int> list) => print('BubbleSort applied.');
}

class QuickSort implements SortStrategy {
  @override
  void sort(List<int> list) => print('QuickSort applied.');
}

class MergeSort implements SortStrategy {
  @override
  void sort(List<int> list) => print('MergeSort applied.');
}

// Context

class Products {
  final List<int> _list;
  SortStrategy _sortStrategy;

  Products({required List<int> list, required SortStrategy sortStrategy})
      : _list = list,
        _sortStrategy = sortStrategy;

  void setSortStrategy(SortStrategy sortStrategy) {
    _sortStrategy = sortStrategy;
  }

  void sort() => _sortStrategy.sort(_list);

  void display() {
    print('Sorted array: ');
    for (final num in _list) {
      print(num);
    }
  }
}

// Usage

void sortStrategyExample() {
  final products = Products(
    list: [64, 34, 25, 12, 22, 11, 90],
    sortStrategy: BubbleSort(),
  );

  products.sort();
  products.display();

  products.setSortStrategy(QuickSort());
  products.sort();
  products.display();

  products.setSortStrategy(MergeSort());
  products.sort();
  products.display();
}

void main() {
  strategyExample();
  sortStrategyExample();
}
