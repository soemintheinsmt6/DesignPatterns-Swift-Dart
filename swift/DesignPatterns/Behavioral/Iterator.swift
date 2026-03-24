//
//  Iterator.swift
//  DesignPatterns
//
//  Created by Soe Min Thein on 24/03/2026.
//

import Foundation

protocol MyIterator {
    var hasNext: Bool { get }
    mutating func next() -> Int?
}

protocol MyAggregate {
    func makeIterator() -> MyIterator
}

struct MyCollectionIterator: MyIterator {
    private let items: [Int]
    private var currentIndex = 0
    
    init(items: [Int]) {
        self.items = items
    }
    
    var hasNext: Bool {
        currentIndex < items.count
    }
    
    mutating func next() -> Int? {
        guard hasNext else { return nil }
        let item = items[currentIndex]
        currentIndex += 1
        return item
    }
}

struct MyCollection: MyAggregate {
    private let items: [Int]
    
    init(items: [Int]) {
        self.items = items
    }
    
    func makeIterator() -> MyIterator {
        MyCollectionIterator(items: items)
    }
}

func iteratorExample() {
    let items = [1, 2, 3, 4, 5]
    let myCollection = MyCollection(items: items)
    var iterator = myCollection.makeIterator()
    
    while iterator.hasNext {
        print(iterator.next() as Any)
    }
}
