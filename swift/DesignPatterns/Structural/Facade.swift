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
        print("DVDPlayer: Turning on...")
    }
    
    func play(movie: String) {
        print("DVDPlayer: Playing \"\(movie)\".")
    }
    
    func stop() {
        print("DVDPlayer: Stopping playback.")
    }
    
    func eject() {
        print("DVDPlayer: Ejecting disc.")
    }
    
    func off() {
        print("DVDPlayer: Turning off...")
    }
}

class Projector {
    func on() {
        print("Projector: Turning on...")
    }
    
    func setInput(_ input: String) {
        print("Projector: Setting input to \(input).")
    }
    
    func wideScreenMode() {
        print("Projector: Setting widescreen mode (16:9).")
    }
    
    func off() {
        print("Projector: Turning off...")
    }
}

class SoundSystem {
    func on() {
        print("SoundSystem: Turning on...")
    }
    
    func setVolume(_ volume: Int) {
        print("SoundSystem: Setting volume to \(volume).")
    }
    
    func setSurroundSound() {
        print("SoundSystem: Setting surround sound mode.")
    }
    
    func off() {
        print("SoundSystem: Turning off...")
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
        projector.on()
        projector.wideScreenMode()
        projector.setInput("DVD")
        soundSystem.on()
        soundSystem.setSurroundSound()
        soundSystem.setVolume(8)
        dvdPlayer.on()
        dvdPlayer.play(movie: movie)
    }
    
    func endMovie() {
        dvdPlayer.stop()
        dvdPlayer.eject()
        dvdPlayer.off()
        soundSystem.off()
        projector.off()
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

class User: CustomStringConvertible {
    let id: String
    let name: String
    
    init(id: String = UUID().uuidString, name: String) {
        self.id = id
        self.name = name
    }
    
    var description: String {
        return "User(id: \(id), name: \(name))"
    }
}

// MARK: - Data Access Layer

class UserRepository {
    private var store: [String: User] = [:]
    
    func saveUser(_ user: User) -> User {
        store[user.id] = user
        print("UserRepository: Saved \(user).")
        return user
    }
    
    func getUserById(_ userId: String) -> User? {
        let user = store[userId]
        print("UserRepository: Fetched \(user.map { "\($0)" } ?? "null") for id=\(userId).")
        return user
    }
    
    func deleteUser(_ userId: String) {
        store.removeValue(forKey: userId)
        print("UserRepository: Deleted user id=\(userId).")
    }
}

// MARK: - Integration Layer

class EmailService {
    func sendWelcomeEmail(to user: User) {
        print("EmailService: Sent welcome email to \(user.name).")
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

func userManagementExample() {
    let facade = UserManagementFacade()

    let newUser = facade.createUser(name: "John Doe")
    facade.getUserById(newUser.id)
    facade.deleteUser(newUser.id)
}
