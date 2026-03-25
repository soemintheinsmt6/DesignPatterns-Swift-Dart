//
//  ChainOfResponsibility.swift
//  DesignPatterns
//
//  Created by Soe Min Thein on 25/03/2026.
//

import Foundation

// MARK: - Real World Problem
// Without Chain of Responsibility, route checking and permission logic are tightly coupled:
//
// if route == "/hello" {
//     if user.type == .admin {
//         print("Success")
//     } else {
//         print("Not allowed")
//     }
// } else {
//     print("Not found")
// }
//
// This becomes unmaintainable as we add more routes, auth checks, logging, rate limiting, etc.
// Chain of Responsibility lets us split each concern into its own handler and chain them together.

// MARK: - Models

enum CORUserType {
    case admin
    case member
    case guest
}

struct CORUser {
    var name: String
    var type: CORUserType
}

struct CORRequest {
    var url: String
    var user: CORUser
}

// MARK: - Chain of Responsibility Pattern

protocol Middleware: AnyObject {
    var next: Middleware? { get set }
    func handle(request: CORRequest)
}

extension Middleware {
    @discardableResult
    func setNext(_ handler: Middleware) -> Middleware {
        self.next = handler
        return handler
    }
}

// MARK: - Concrete Handlers

class RouteHandler: Middleware {
    var next: Middleware?
    
    func handle(request: CORRequest) {
        if request.url.contains("/hello") {
            print("RouteHandler: Route matched '/hello'")
            next?.handle(request: request)
        } else {
            print("RouteHandler: 404 Not Found")
        }
    }
}

class AuthHandler: Middleware {
    var next: Middleware?
    
    func handle(request: CORRequest) {
        if request.user.type != .guest {
            print("AuthHandler: User '\(request.user.name)' is authenticated")
            next?.handle(request: request)
        } else {
            print("AuthHandler: Unauthorized - Guest access denied")
        }
    }
}

class PermissionHandler: Middleware {
    var next: Middleware?
    
    func handle(request: CORRequest) {
        if request.user.type == .admin {
            print("PermissionHandler: Admin access granted - Success")
            next?.handle(request: request)
        } else {
            print("PermissionHandler: Sorry, you don't have permission")
        }
    }
}

// MARK: - Middleware Pipeline

class MiddlewareHandler {
    private var handler: Middleware?
    
    func setHandler(_ handler: Middleware) {
        self.handler = handler
    }
    
    func handle(request: CORRequest) {
        handler?.handle(request: request)
    }
}

// MARK: - Usage

func chainOfResponsibilityExample() {
    // Build the chain: Route -> Auth -> Permission
    let routeHandler = RouteHandler()
    let authHandler = AuthHandler()
    let permissionHandler = PermissionHandler()
    
    routeHandler.setNext(authHandler).setNext(permissionHandler)
    
    let middleware = MiddlewareHandler()
    middleware.setHandler(routeHandler)
    
    // Case 1: Admin with valid route - passes all handlers
    print("Case 1: Admin + valid route")
    let adminUser = CORUser(name: "Alice", type: .admin)
    let validRequest = CORRequest(url: "http://www.example.com/hello", user: adminUser)
    middleware.handle(request: validRequest)
    
    // Case 2: Member with valid route - blocked at permission
    print("Case 2: Member + valid route")
    let memberUser = CORUser(name: "Bob", type: .member)
    let memberRequest = CORRequest(url: "http://www.example.com/hello", user: memberUser)
    middleware.handle(request: memberRequest)
    
    // Case 3: Guest with valid route - blocked at auth
    print("Case 3: Guest + valid route")
    let guestUser = CORUser(name: "Charlie", type: .guest)
    let guestRequest = CORRequest(url: "http://www.example.com/hello", user: guestUser)
    middleware.handle(request: guestRequest)
    
    // Case 4: Admin with invalid route - blocked at route
    print("Case 4: Admin + invalid route")
    let badRequest = CORRequest(url: "http://www.example.com/unknown", user: adminUser)
    middleware.handle(request: badRequest)
}
