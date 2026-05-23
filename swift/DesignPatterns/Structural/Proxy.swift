//
//  Proxy.swift
//  DesignPatterns
//
//  Created by Soe Min Thein on 23/05/2026.
//

import Foundation

protocol DatabaseDAO {
    func query()
}

struct DatabaseDAOImpl: DatabaseDAO {
    func query() {
        print("QUERY")
    }
}

struct CacheProxyDatabase: DatabaseDAO {
    private let dao: DatabaseDAO
    
    init(dao: DatabaseDAO) {
        self.dao = dao
    }
    
    func query() {
        print("Cache:: Query from Cache")
        dao.query()
    }
}

struct LoggingProxy: DatabaseDAO {
    private let dao: DatabaseDAO
    
    init(dao: DatabaseDAO) {
        self.dao = dao
    }
    
    func query() {
        print("Log:: Start Query")
        dao.query()
        print("Log:: End Query")
    }
}

func proxyExample() {
    let db = DatabaseDAOImpl()
    let cache = CacheProxyDatabase(dao: db)
    let logProxy = LoggingProxy(dao: cache)
    
    logProxy.query()
}
