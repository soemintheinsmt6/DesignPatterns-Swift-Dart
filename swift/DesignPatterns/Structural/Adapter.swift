//
//  Adapter.swift
//  DesignPatterns
//
//  Created by Soe Min Thein on 22/05/2026.
//

import Foundation

struct MileDistanceCalculator {
    func distance(from origin: String, to destination: String) -> Double {
        Double.random(in: 0...100)
    }
}

protocol KilometerDistanceProviding {
    func distance(inKilometersFrom origin: String, to destination: String) -> Double
}

struct KilometerDistanceAdapter: KilometerDistanceProviding {
    private let mileCalculator: MileDistanceCalculator
    
    init(mileCalculator: MileDistanceCalculator) {
        self.mileCalculator = mileCalculator
    }
    
    func distance(inKilometersFrom origin: String, to destination: String) -> Double {
        let miles = mileCalculator.distance(from: origin, to: destination)
        return miles * 1.609344
    }
}

func adapterExample() {
    let mileCalculator = MileDistanceCalculator()
    let miles = mileCalculator.distance(from: "city1", to: "city2")
    print("The distance between city1 and city2 = \(miles) miles")
    
    let kilometerAdapter = KilometerDistanceAdapter(mileCalculator: mileCalculator)
    let kilometers = kilometerAdapter.distance(inKilometersFrom: "city3", to: "city4")
    print("The distance between city3 and city4 = \(kilometers) kilometers")
}
