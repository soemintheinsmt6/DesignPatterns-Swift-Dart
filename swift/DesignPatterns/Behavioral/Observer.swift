//
//  Observer.swift
//  DesignPatterns
//
//  Created by Soe Min Thein on 21/03/2026.
//

import Foundation

// MARK: - Example 1: Event Source

protocol EventObserver {
    func update(_ event: String)
}

class EventListener: EventObserver {
    func update(_ event: String) {
        // Implement the update method
    }
}

class EventSource {
    private var observers = [EventObserver]()
    
    func notifyObservers(_ event: String) {
        for observer in observers {
            observer.update(event)
        }
    }
    
    func addObserver(_ observer: EventObserver) {
        observers.append(observer)
    }
}

func eventSourceExample() {
    let eventSource = EventSource()
    
    let event1 = EventListener()
    let event2 = EventListener()
    eventSource.addObserver(event1)
    eventSource.addObserver(event2)
    
    eventSource.notifyObservers("Event occurred")
}

// MARK: - Example 2: Scoreboard

protocol ScoreObserver: AnyObject {
    func update(_ score: Int)
}

class Scoreboard {
    private var score: Int = 0
    private var observers = [ScoreObserver]()
    
    func setScore(_ newScore: Int) {
        score = newScore
        notifyObservers()
    }
    
    func registerObserver(_ observer: ScoreObserver) {
        observers.append(observer)
    }
    
    func unregisterObserver(_ observer: ScoreObserver) {
        observers.removeAll { $0 === observer }
    }
    
    private func notifyObservers() {
        for observer in observers {
            observer.update(score)
        }
    }
}

class PlayerScoreDisplay: ScoreObserver {
    func update(_ score: Int) {
        print("Player score: \(score)")
    }
}

func scoreboardExample() {
    let scoreboard = Scoreboard()
    
    let display1 = PlayerScoreDisplay()
    let display2 = PlayerScoreDisplay()
    scoreboard.registerObserver(display1)
    scoreboard.registerObserver(display2)
    
    scoreboard.setScore(10)
    scoreboard.unregisterObserver(display1)
    scoreboard.setScore(20)
}

// MARK: - Example 3: Delegation (1-to-1 Observer)
// Common UIKit pattern: cell notifies view controller via delegate.

protocol ProductCellDelegate: AnyObject {
    func didTapBuyButton(in cell: ProductCell)
}

class ProductCell {
    weak var delegate: ProductCellDelegate?

    func buyButtonTapped() {
        delegate?.didTapBuyButton(in: self)
    }
}

class ProductListViewController: ProductCellDelegate {
    private var products = ["iPhone", "MacBook", "AirPods"]

    func showProducts() {
        for product in products {
            let cell = ProductCell()
            cell.delegate = self
            print("Displaying: \(product)")
            cell.buyButtonTapped()
        }
    }

    func didTapBuyButton(in cell: ProductCell) {
        print("Buy button tapped, navigating to checkout")
    }
}

func delegationExample() {
    let viewController = ProductListViewController()
    viewController.showProducts()
}
