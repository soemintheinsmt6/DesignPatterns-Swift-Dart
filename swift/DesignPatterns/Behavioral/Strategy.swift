//
//  Strategy.swift
//  DesignPatterns
//
//  Created by Soe Min Thein on 19/03/2026.
//

import Foundation

// MARK: - Strategy
// Defines the interface for interchangeable algorithms.

protocol RouteStrategy {
    func calculateRoute(startPoint: String, endPoint: String)
}

// MARK: - Concrete Strategies
// Each strategy encapsulates a specific route calculation algorithm.

class CarRouteStrategy: RouteStrategy {
    func calculateRoute(startPoint: String, endPoint: String) {
        print("Calculating car route from \(startPoint) to \(endPoint)")
    }
}

class BusRouteStrategy: RouteStrategy {
    func calculateRoute(startPoint: String, endPoint: String) {
        print("Calculating bus route from \(startPoint) to \(endPoint)")
    }
}

class WalkRouteStrategy: RouteStrategy {
    func calculateRoute(startPoint: String, endPoint: String) {
        print("Calculating walk route from \(startPoint) to \(endPoint)")
    }
}

// MARK: - Context
// Maintains a reference to a strategy and delegates the work to it.

class NavigationContext {
    private var routeStrategy: RouteStrategy
    
    init(routeStrategy: RouteStrategy) {
        self.routeStrategy = routeStrategy
    }
    
    func setRouteStrategy(_ strategy: RouteStrategy) {
        routeStrategy = strategy
    }
    
    func calculateRoute(startPoint: String, endPoint: String) {
        routeStrategy.calculateRoute(startPoint: startPoint, endPoint: endPoint)
    }
}

// MARK: - Usage
// Swap strategies at runtime without changing the context.

func strategyExample() {
    let busRouteStrategy = BusRouteStrategy()
    let navigationContext = NavigationContext(routeStrategy: busRouteStrategy)
    navigationContext.calculateRoute(startPoint: "Start Point", endPoint: "End Point")
    
    let carRouteStrategy = CarRouteStrategy()
    navigationContext.setRouteStrategy(carRouteStrategy)
    navigationContext.calculateRoute(startPoint: "Start Point", endPoint: "End Point")
    
    let walkRouteStrategy = WalkRouteStrategy()
    navigationContext.setRouteStrategy(walkRouteStrategy)
    navigationContext.calculateRoute(startPoint: "Start Point", endPoint: "End Point")
}


// MARK: - Example 2: Sorting Strategy

// MARK: - Strategy

protocol SortStrategy {
    func sort(_ list: [Int])
}

// MARK: - Concrete Strategies

class BubbleSort: SortStrategy {
    func sort(_ list: [Int]) {
        print("BubbleSort applied.")
    }
}

class QuickSort: SortStrategy {
    func sort(_ list: [Int]) {
        print("QuickSort applied.")
    }
}

class MergeSort: SortStrategy {
    func sort(_ list: [Int]) {
        print("MergeSort applied.")
    }
}

// MARK: - Context

class Products {
    private let list: [Int]
    private var sortStrategy: SortStrategy

    init(list: [Int], sortStrategy: SortStrategy) {
        self.list = list
        self.sortStrategy = sortStrategy
    }

    func setSortStrategy(_ sortStrategy: SortStrategy) {
        self.sortStrategy = sortStrategy
    }

    func sort() {
        sortStrategy.sort(list)
    }

    func display() {
        print("Sorted array: ")
        for num in list {
            print(num)
        }
    }
}

// MARK: - Usage

func sortStrategyExample() {
    let list = [64, 34, 25, 12, 22, 11, 90]

    let products = Products(list: list, sortStrategy: BubbleSort())

    products.sort()
    products.display()

    products.setSortStrategy(QuickSort())
    products.sort()
    products.display()

    products.setSortStrategy(MergeSort())
    products.sort()
    products.display()
}
