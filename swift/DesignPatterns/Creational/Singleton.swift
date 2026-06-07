//
//  Singleton.swift
//  DesignPatterns
//
//  Created by Soe Min Thein on 07/06/2026.
//

import Foundation

// boilerplate such as double-checked locking:
//
// public class Logger {
//     private static volatile Logger instance;
//
//     private Logger() {}
//
//     public static Logger getInstance() {
//         if (instance == null) {
//             synchronized (Logger.class) {
//                 if (instance == null) {
//                     instance = new Logger();
//                 }
//             }
//         }
//         return instance;
//     }
// }
//
// In Swift, a `static let` stored property is lazily initialized
// exactly once and is thread-safe by language guarantee (it uses
// dispatch_once under the hood), so the idiomatic Singleton is
// just a `shared` constant with a private initializer.

final class Logger {
    static let shared = Logger()
    
    // Private init prevents creating other instances:
    // `Logger()` outside this file is a compile-time error.
    private init() {}
    
    private(set) var history: [String] = []
    
    func log(_ message: String) {
        history.append(message)
        print("[LOG] \(message)")
    }
}

func singletonExample() {
    Logger.shared.log("App started")
    Logger.shared.log("User signed in")
    
    let logger = Logger.shared
    logger.log("Fetching data")
    
    // Both references point to the same instance.
    print("Same instance: \(logger === Logger.shared)")
    print("History count: \(Logger.shared.history.count)")
    
    // let another = Logger() // compile error: 'Logger' initializer is inaccessible
}
