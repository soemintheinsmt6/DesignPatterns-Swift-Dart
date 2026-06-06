//
//  Builder.swift
//  DesignPatterns
//
//  Created by Soe Min Thein on 06/06/2026.
//

import Foundation

// Without Builder — plain constructor (initializer) approach.
// Every field must be passed in one long call, and at the call site
// it is hard to tell which argument is which in languages without
// argument labels (like Java):
//
// struct Person {
//     let firstName: String
//     let lastName: String
//     let age: Int
//     let email: String
//     let phone: String
//     let address: String
//
//     init(firstName: String, lastName: String, age: Int,
//          email: String, phone: String, address: String) {
//         self.firstName = firstName
//         self.lastName = lastName
//         self.age = age
//         self.email = email
//         self.phone = phone
//         self.address = address
//     }
// }
//
// let person = Person(firstName: "John", lastName: "Doe", age: 30,
//                     email: "john.doe@example.com",
//                     phone: "+1234567890",
//                     address: "123 Main Street")

struct Person: CustomStringConvertible {
    let firstName: String
    let lastName: String
    let age: Int?
    let email: String?
    let phone: String?
    let address: String?
    
    private init(builder: Builder) {
        self.firstName = builder.firstName
        self.lastName = builder.lastName
        self.age = builder.age
        self.email = builder.email
        self.phone = builder.phone
        self.address = builder.address
    }
    
    var description: String {
        "Person{firstName='\(firstName)', lastName='\(lastName)', age=\(age.map(String.init) ?? "nil"), email='\(email ?? "nil")', phone='\(phone ?? "nil")', address='\(address ?? "nil")'}"
    }
    
    class Builder {
        fileprivate let firstName: String
        fileprivate let lastName: String
        fileprivate var age: Int?
        fileprivate var email: String?
        fileprivate var phone: String?
        fileprivate var address: String?
        
        init(firstName: String, lastName: String) {
            self.firstName = firstName
            self.lastName = lastName
        }
        
        @discardableResult
        func age(_ age: Int) -> Builder {
            self.age = age
            return self
        }
        
        @discardableResult
        func email(_ email: String) -> Builder {
            self.email = email
            return self
        }
        
        @discardableResult
        func phone(_ phone: String) -> Builder {
            self.phone = phone
            return self
        }
        
        @discardableResult
        func address(_ address: String) -> Builder {
            self.address = address
            return self
        }
        
        func build() -> Person {
            Person(builder: self)
        }
    }
}

func builderExample() {
    let person = Person.Builder(firstName: "John", lastName: "Doe")
        .age(30)
        .email("john.doe@example.com")
        .phone("+1234567890")
        .address("123 Main Street")
        .build()
    print(person)
}
