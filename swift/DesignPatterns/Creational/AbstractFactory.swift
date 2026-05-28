//
//  AbstractFactory.swift
//  DesignPatterns
//
//  Created by Soe Min Thein on 28/05/2026.
//

import Foundation

// Abstract Products

protocol ThemedButton {
    func render()
}

protocol ThemedCheckbox {
    func render()
}

// Concrete Products — Light family

struct LightButton: ThemedButton {
    func render() {
        print("Rendering a light button")
    }
}

struct LightCheckbox: ThemedCheckbox {
    func render() {
        print("Rendering a light checkbox")
    }
}

// Concrete Products — Dark family

struct DarkButton: ThemedButton {
    func render() {
        print("Rendering a dark button")
    }
}

struct DarkCheckbox: ThemedCheckbox {
    func render() {
        print("Rendering a dark checkbox")
    }
}

// Abstract Factory

protocol UIFactory {
    func makeButton() -> ThemedButton
    func makeCheckbox() -> ThemedCheckbox
}

// Concrete Factories

struct LightUIFactory: UIFactory {
    func makeButton() -> ThemedButton { LightButton() }
    func makeCheckbox() -> ThemedCheckbox { LightCheckbox() }
}

struct DarkUIFactory: UIFactory {
    func makeButton() -> ThemedButton { DarkButton() }
    func makeCheckbox() -> ThemedCheckbox { DarkCheckbox() }
}

// Client — depends only on the abstract factory, so the whole UI stays
// in one family without the client knowing which one.

func renderForm(using factory: UIFactory) {
    let button = factory.makeButton()
    let checkbox = factory.makeCheckbox()
    button.render()
    checkbox.render()
}

func abstractFactoryExample() {
    print("-- Light theme --")
    renderForm(using: LightUIFactory())
    
    print("-- Dark theme --")
    renderForm(using: DarkUIFactory())
}
