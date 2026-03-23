//
//  Composite.swift
//  DesignPatterns
//
//  Created by Soe Min Thein on 23/03/2026.
//

import Foundation

// MARK: - Component

protocol FileComponent {
    var name: String { get }
    func getSize() -> Int
    func printInfo()
}

// MARK: - Leaf

class File: FileComponent {
    let name: String
    private let sizeInBytes: Int

    init(name: String, sizeInBytes: Int) {
        self.name = name
        self.sizeInBytes = sizeInBytes
    }

    func getSize() -> Int {
        return sizeInBytes
    }

    func printInfo() {
        print("--- file \(name) size=\(getSize()) bytes")
    }
}

// MARK: - Composite

class Directory: FileComponent {
    let name: String
    private var components: [FileComponent] = []

    init(name: String) {
        self.name = name
    }

    func addComponent(_ component: FileComponent) {
        components.append(component)
    }

    func getSize() -> Int {
        return components.reduce(0) { $0 + $1.getSize() }
    }

    func printInfo() {
        print("-- dir \(name) size=\(getSize()) bytes")
        for component in components {
            component.printInfo()
        }
    }
}

// MARK: - Usage

func CompositeExample() {
    
    let file1 = File(name: "document.txt", sizeInBytes: 1024)
    let file2 = File(name: "image.png", sizeInBytes: 2048)
    let file3 = File(name: "notes.md", sizeInBytes: 512)
    
    let subDir = Directory(name: "subfolder")
    subDir.addComponent(file2)
    subDir.addComponent(file3)
    
    let rootDir = Directory(name: "root")
    rootDir.addComponent(file1)
    rootDir.addComponent(subDir)
    
    rootDir.printInfo()
}
