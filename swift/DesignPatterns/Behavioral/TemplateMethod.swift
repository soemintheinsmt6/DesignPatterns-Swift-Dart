//
//  TemplateMethod.swift
//  DesignPatterns
//
//  Created by Soe Min Thein on 20/03/2026.
//

import Foundation

// MARK: - Abstract Template

protocol HouseBuilder {
    func layFoundation()
    func buildWalls()
    func buildRoof()
    func installDoors()
}

extension HouseBuilder {
    // Template method
    func buildHouse() {
        layFoundation()
        buildWalls()
        buildRoof()
        installDoors()
    }
}

// MARK: - Builders

class WoodenHouseBuilder: HouseBuilder {
    func layFoundation() {
        print("Laying wooden foundation")
    }
    
    func buildWalls() {
        print("Building wooden walls")
    }
    
    func buildRoof() {
        print("Building wooden roof")
    }
    
    func installDoors() {
        print("Installing wooden doors")
    }
}

class BrickHouseBuilder: HouseBuilder {
    func layFoundation() {
        print("Laying brick foundation")
    }
    
    func buildWalls() {
        print("Building brick walls")
    }
    
    func buildRoof() {
        print("Building brick roof")
    }
    
    func installDoors() {
        print("Installing brick doors")
    }
}

class GlassHouseBuilder: HouseBuilder {
    func layFoundation() {
        print("Laying glass foundation")
    }
    
    func buildWalls() {
        print("Building glass walls")
    }
    
    func buildRoof() {
        print("Building glass roof")
    }
    
    func installDoors() {
        print("Installing glass doors")
    }
}

// MARK: - Usage

func templateMethodExample() {
    let woodenHouseBuilder = WoodenHouseBuilder()
    woodenHouseBuilder.buildHouse()
}

