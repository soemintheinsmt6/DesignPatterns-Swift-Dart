//
//  State.swift
//  DesignPatterns
//
//  Created by Soe Min Thein on 22/03/2026.
//

import Foundation

// MARK: - Real World Problem

var currentState = "Red"

func changeState() {
    if currentState == "Red" {
        currentState = "Green"
    } else if currentState == "Green" {
        currentState = "Yellow"
    } else if currentState == "Yellow" {
        currentState = "Red"
    }
}

func processFunction() {
    if currentState == "Red" {
        print("Stop the car")
    } else if currentState == "Green" {
        print("Allow to go")
    } else if currentState == "Yellow" {
        print("Slow down")
    }
}

func stateProblemExample() {
    changeState()
    processFunction()
    print(currentState)
}

// MARK: - State Pattern Solution

protocol LightState {
    var color: String { get }
    func change(light: TrafficLight)
    func process()
}

class TrafficLight {
    private var currentLightState: LightState
    
    init(currentLightState: LightState) {
        self.currentLightState = currentLightState
    }
    
    func changeState() {
        currentLightState.change(light: self)
    }
    
    func process() {
        currentLightState.process()
    }
    
    var currentColor: String {
        currentLightState.color
    }
    
    func setState(_ light: LightState) {
        currentLightState = light
    }
}

class RedLightState: LightState {
    func change(light: TrafficLight) {
        light.setState(YellowLightState())
    }
    
    var color: String {
        "Red"
    }
    
    func process() {
        print("Stop the car")
    }
}

class YellowLightState: LightState {
    func change(light: TrafficLight) {
        light.setState(GreenLightState())
    }
    
    var color: String {
        "Yellow"
    }
    
    func process() {
        print("Slow down")
    }
}

class GreenLightState: LightState {
    func change(light: TrafficLight) {
        light.setState(RedLightState())
    }
    
    var color: String {
        "Green"
    }
    
    func process() {
        print("Allow to go")
    }
}

func stateExample() {
    let red = RedLightState()
    let trafficLight = TrafficLight(currentLightState: red)
    print(trafficLight.currentColor)
    trafficLight.process()
    trafficLight.changeState()
    print(trafficLight.currentColor)
    trafficLight.process()
}
