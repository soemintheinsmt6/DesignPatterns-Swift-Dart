//
//  Facade.swift
//  DesignPatterns
//
//  Created by Soe Min Thein on 27/02/2026.
//

import Foundation

// MARK: - Subsystem Classes

class DVDPlayer {
    func on() {
        print("DVD Player is ON")
    }
    
    func play(movie: String) {
        print("DVD Player is playing \(movie)")
    }
    
    func stop() {
        print("DVD Player is Stopped")
    }
    
    func off() {
        print("DVD Player is OFF")
    }
}

class Projector {
    func on() {
        print("Projector is ON")
    }
    
    func setInput(_ dvdPlayer: DVDPlayer) {
        print("Setting input to DVD Player")
    }
    
    func display() {
        print("Projector is displaying")
    }
    
    func off() {
        print("Projector is OFF")
    }
}

class SoundSystem {
    func on() {
        print("Sound System is ON")
    }
    
    func setVolume(_ volume: Int) {
        print("Setting volume to \(volume)")
    }
    
    func surroundSound() {
        print("Surround sound is ON")
    }
    
    func off() {
        print("Sound System is OFF")
    }
}

// MARK: - Facade

class HomeTheaterFacade {
    private let dvdPlayer: DVDPlayer
    private let projector: Projector
    private let soundSystem: SoundSystem
    
    init(dvdPlayer: DVDPlayer, projector: Projector, soundSystem: SoundSystem) {
        self.dvdPlayer = dvdPlayer
        self.projector = projector
        self.soundSystem = soundSystem
    }
    
    func watchMovie(_ movie: String) {
        print("Get ready to watch a movie...")
        dvdPlayer.on()
        dvdPlayer.play(movie: movie)
        projector.on()
        projector.setInput(dvdPlayer)
        projector.display()
        soundSystem.on()
        soundSystem.setVolume(10)
        soundSystem.surroundSound()
    }
    
    func endMovie() {
        print("Shutting down the movie theater...")
        dvdPlayer.stop()
        dvdPlayer.off()
        projector.off()
        soundSystem.off()
    }
}

// MARK: - Usage

let dvdPlayer   = DVDPlayer()
let projector   = Projector()
let soundSystem = SoundSystem()

let homeTheater = HomeTheaterFacade(dvdPlayer: dvdPlayer,
                                    projector: projector,
                                    soundSystem: soundSystem)


//MARK: - Example 2: User Management Facade
//
//
// MARK: - Domain Entity

class User {
    let id: String
    var name: String
    
    init(id: String = UUID().uuidString, name: String) {
        self.id = id
        self.name = name
    }
}

// MARK: - Data Access Layer

class UserRepository {
    private var store: [String: User] = [:]
    
    func saveUser(_ user: User) -> User {
        store[user.id] = user
        print("User saved to database with ID: \(user.id)")
        return user
    }
    
    func getUserById(_ userId: String) -> User? {
        return store[userId]
    }
    
    func deleteUser(_ userId: String) {
        store.removeValue(forKey: userId)
        print("User with ID \(userId) removed from database")
    }
}

// MARK: - Integration Layer

class EmailService {
    func sendWelcomeEmail(to user: User) {
        print("Sending welcome email to \(user.name)...")
    }
}

// MARK: - Business Logic Layer

class UserManager {
    private let userRepository: UserRepository
    private let emailService: EmailService
    
    init(userRepository: UserRepository, emailService: EmailService) {
        self.userRepository = userRepository
        self.emailService = emailService
    }
    
    func createUser(name: String) -> User {
        let newUser = User(name: name)
        let savedUser = userRepository.saveUser(newUser)
        emailService.sendWelcomeEmail(to: savedUser)
        return savedUser
    }
    
    func getUserById(_ userId: String) -> User? {
        return userRepository.getUserById(userId)
    }
    
    func deleteUser(_ userId: String) {
        userRepository.deleteUser(userId)
    }
}

// MARK: - Facade

class UserManagementFacade {
    private let userManager: UserManager
    
    init() {
        let userRepository = UserRepository()
        let emailService = EmailService()
        self.userManager = UserManager(userRepository: userRepository,
                                       emailService: emailService)
    }
    
    func createUser(name: String) -> User {
        return userManager.createUser(name: name)
    }
    
    func getUserById(_ userId: String) -> User? {
        return userManager.getUserById(userId)
    }
    
    func deleteUser(_ userId: String) {
        userManager.deleteUser(userId)
    }
}

// MARK: - Usage

let facade = UserManagementFacade()

let newUser = facade.createUser(name: "John Doe")
