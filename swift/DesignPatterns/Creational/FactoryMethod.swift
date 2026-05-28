//
//  FactoryMethod.swift
//  DesignPatterns
//
//  Created by Soe Min Thein on 28/05/2026.
//

import Foundation

protocol Shape {
    func draw()
}

struct Circle: Shape {
    func draw() {
        print("Drawing a circle")
    }
}

struct Rectangle: Shape {
    func draw() {
        print("Drawing a rectangle")
    }
}

enum ShapeType {
    case circle
    case rectangle
}

struct ShapeFactory {
    static func makeShape(_ type: ShapeType) -> Shape {
        switch type {
        case .circle:
            return Circle()
        case .rectangle:
            return Rectangle()
        }
    }
}

func factoryExample() {
    let circle = ShapeFactory.makeShape(.circle)
    circle.draw()
    
    let rectangle = ShapeFactory.makeShape(.rectangle)
    rectangle.draw()
}
