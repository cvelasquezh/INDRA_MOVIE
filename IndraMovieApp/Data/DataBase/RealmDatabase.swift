//
//  RealmDatabase.swift
//  IndraMovieApp
//
//  Created by MDP-DESARROLLADOR on 6/8/21.
//

import Foundation

import RealmSwift

class RealmDataBase<T>: NSObject where T: Object {
    private var realm: Realm
    
    override init() {
        do {
            self.realm = try Realm()
        } catch {
            fatalError("init() database")
        }
    }
    
    public func deleteDatabase() {
        try! self.realm.write {
            self.realm.deleteAll()
        }
    }
    
    public func save(item: T) {
        try! self.realm.write {
            self.realm.add(item, update: .all)
        }
    }
    
    public func save(items: [T]) {
        try! self.realm.write {
            self.realm.add(items)
        }
    }
    
    public func delete(item: T) {
        try! self.realm.write {
            self.realm.delete(item)
        }
    }
    
    public func delete(items: Results<T>) {
        try! self.realm.write {
            self.realm.delete(items)
        }
    }
    
    public func deleteAll() {
        let objects = realm.objects(T.self)
        
        try! realm.write {
            realm.delete(objects)
        }
    }
    
    public func getAll() -> Results<T> {
        return self.realm.objects(T.self)
    }
}
