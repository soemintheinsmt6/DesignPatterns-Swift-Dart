//
//  Command.swift
//  DesignPatterns
//
//  Created by Soe Min Thein on 01/03/2026.
//

import Foundation

// MARK: - Command
// Declares the interface for executing an operation.

protocol CommandProtocol {
    func execute()
}

// MARK: - Receiver
// The object that knows how to perform the actual work.
// Commands delegate to the receiver to carry out requests.

class TextEditor {
    func save() {
        print("Saving the document")
    }
    
    func open() {
        print("Opening a document")
    }
    
    // Named printDocument to avoid shadowing Swift's global print(_:)
    func printDocument() {
        print("Printing the document")
    }
}

// MARK: - Concrete Commands
// Each command wraps a specific action on the receiver.

class SaveCommand: CommandProtocol {
    private let textEditor: TextEditor
    
    init(textEditor: TextEditor) {
        self.textEditor = textEditor
    }
    
    func execute() {
        textEditor.save()
    }
}

class OpenCommand: CommandProtocol {
    private let textEditor: TextEditor
    
    init(textEditor: TextEditor) {
        self.textEditor = textEditor
    }
    
    func execute() {
        textEditor.open()
    }
}

class PrintCommand: CommandProtocol {
    private let textEditor: TextEditor
    
    init(textEditor: TextEditor) {
        self.textEditor = textEditor
    }
    
    func execute() {
        textEditor.printDocument()
    }
}

// MARK: - Invokers
// Invokers hold a command and trigger it without knowing what the command does.
// Decoupling the sender from the receiver is the key benefit of the pattern.

class Button {
    private let command: CommandProtocol
    
    init(command: CommandProtocol) {
        self.command = command
    }
    
    func click() {
        command.execute()
    }
}

class Shortcut {
    private let command: CommandProtocol
    
    init(command: CommandProtocol) {
        self.command = command
    }
    
    func press() {
        command.execute()
    }
}

// MARK: - Usage
// Wire up receivers, commands, and invokers.

func commandExample() {
    let textEditor = TextEditor()
    
    // Wrap each action in a concrete command
    let saveCommand  = SaveCommand(textEditor: textEditor)
    let openCommand  = OpenCommand(textEditor: textEditor)
    let printCommand = PrintCommand(textEditor: textEditor)
    
    // Assign commands to invokers
    let saveButton    = Button(command: saveCommand)
    let openButton    = Button(command: openCommand)
    let printShortcut = Shortcut(command: printCommand)
    
    // Trigger via invokers — no direct coupling to TextEditor
    saveButton.click()
    openButton.click()
    printShortcut.press()
}


// MARK: - Example 2: Command with History
// Demonstrates the Command pattern with Undo/Redo support.

// Command Interface
// Declares execution and rollback methods.
protocol Command {
    func execute()
    func unExecute()
}

// Receiver
// Performs the actual business logic (e.g., managing an array).
final class StackStore {
    private(set) var items: [Int] = []
    
    func push(_ value: Int) {
        items.append(value)
    }
    
    func pop() -> Int? {
        items.popLast()
    }
}

// Concrete Commands
// Encapsulates a specific action and the data required to perform/undo it.
final class PushCommand: Command {
    private let receiver: StackStore
    private let value: Int
    
    init(receiver: StackStore, value: Int) {
        self.receiver = receiver
        self.value = value
    }
    
    func execute() {
        receiver.push(value)
    }
    
    func unExecute() {
        _ = receiver.pop()
    }
}

final class PopCommand: Command {
    private let receiver: StackStore
    private var popped: Int?
    
    init(receiver: StackStore) {
        self.receiver = receiver
    }
    
    func execute() {
        popped = receiver.pop()
    }
    
    func unExecute() {
        if let value = popped {
            receiver.push(value)
        }
    }
}

// Invoker
// Stores executed commands and handles undo/redo logic.
final class CommandManager {
    private var history: [Command] = []
    private var undoList: [Command] = []
    
    func execute(_ command: Command) {
        command.execute()
        history.append(command)
        undoList.removeAll() // Clear redo history on new action
    }
    
    func undo() {
        guard let command = history.popLast() else { return }
        command.unExecute()
        undoList.append(command)
    }
    
    func redo() {
        guard let command = undoList.popLast() else { return }
        command.execute()
        history.append(command)
    }
}

// MARK: - Usage
func commandWithUndoExample() {
    let receiver = StackStore()
    let manager = CommandManager()
    
    let pushC1 = PushCommand(receiver: receiver, value: 6)
    manager.execute(pushC1)
    print(receiver.items) // [6]
    
    let pushC2 = PushCommand(receiver: receiver, value: 3)
    manager.execute(pushC2)
    print(receiver.items) // [6, 3]
    
    let popC1 = PopCommand(receiver: receiver)
    manager.execute(popC1)
    print(receiver.items) // [6]
    
    manager.undo()
    print(receiver.items) // [6, 3]
}


// MARK: - Example 3: Use Command as Replay
// Demonstrates using the Command pattern to record a sequence of actions and replay them.

// 1. Receiver
// The object performing the actual work.
final class Robot {
    var position = (x: 0, y: 0)
    
    func moveForward() {
        position.y += 1
        print("Robot moved forward to \(position)")
    }
    
    func moveBackward() {
        position.y -= 1
        print("Robot moved backward to \(position)")
    }
    
    func moveLeft() {
        position.x -= 1
        print("Robot moved left to \(position)")
    }
    
    func moveRight() {
        position.x += 1
        print("Robot moved right to \(position)")
    }
}

// 2. Concrete Commands
final class ForwardCommand: Command {
    private let robot: Robot
    init(robot: Robot) { self.robot = robot }
    
    func execute()   { robot.moveForward() }
    func unExecute() { robot.moveBackward() }
}

final class BackwardCommand: Command {
    private let robot: Robot
    init(robot: Robot) { self.robot = robot }
    
    func execute()   { robot.moveBackward() }
    func unExecute() { robot.moveForward() }
}

final class LeftCommand: Command {
    private let robot: Robot
    init(robot: Robot) { self.robot = robot }
    
    func execute()   { robot.moveLeft() }
    func unExecute() { robot.moveRight() }
}

final class RightCommand: Command {
    private let robot: Robot
    init(robot: Robot) { self.robot = robot }
    
    func execute()   { robot.moveRight() }
    func unExecute() { robot.moveLeft() }
}

// 3. Invoker
// Stores commands and manages the current state index for undo/redo and replay.
final class ReplayManager {
    private var commands: [Command] = []
    private var currentIndex = -1 // Points to the index of the last executed command
    
    func execute(_ command: Command) {
        // If we execute a new command after undoing, we drop the redo history
        if currentIndex < commands.count - 1 {
            commands.removeSubrange((currentIndex + 1)...)
        }
        
        commands.append(command)
        command.execute()
        currentIndex += 1
    }
    
    func undo() {
        guard currentIndex >= 0 else { return }
        commands[currentIndex].unExecute()
        currentIndex -= 1
    }
    
    func redo() {
        guard currentIndex < commands.count - 1 else { return }
        currentIndex += 1
        commands[currentIndex].execute()
    }
    
    func replay() {
        // Replay all commands up to the current index
        guard currentIndex >= 0 else { return }
        for i in 0...currentIndex {
            commands[i].execute()
        }
    }
}

// MARK: - Usage
func commandAsReplayExample() {
    let robot = Robot()
    let manager = ReplayManager()
    
    let forward = ForwardCommand(robot: robot)
    let left = LeftCommand(robot: robot)
    let right = RightCommand(robot: robot)
    
    manager.execute(forward) // (0, 1)
    manager.execute(left)    // (-1, 1)
    manager.execute(forward) // (-1, 2)
    manager.execute(right)   // (0, 2)
    
    manager.undo() // undo right -> moves left. Robot is at (-1, 2)
    manager.redo() // redo right -> moves right. Robot is at (0, 2)
    
    robot.position = (x: 0, y: 0)
    manager.replay() // Outputs the sequence of the 4 accepted commands
}
