//
//  StorageManager.swift
//  Tools
//
//  Created by Almaz Ibragimov on 24.02.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation

public protocol StorageManager {
    
    // MARK: - Instance Properties
    
    var context: StorageContext { get }
    
    // MARK: - Instance Methods
    
    func first<Object: StorageObject>(_ type: Object.Type, sortDescriptors: [NSSortDescriptor], predicate: NSPredicate?) -> Object?
    func first<Object: StorageObject>(_ type: Object.Type, sortDescriptors: [NSSortDescriptor]) -> Object?
    func first<Object: StorageObject>(with fetchRequest: StorageFetchRequest<Object>) -> Object?
    
    func last<Object: StorageObject>(_ type: Object.Type, sortDescriptors: [NSSortDescriptor], predicate: NSPredicate?) -> Object?
    func last<Object: StorageObject>(_ type: Object.Type, sortDescriptors: [NSSortDescriptor]) -> Object?
    func last<Object: StorageObject>(with fetchRequest: StorageFetchRequest<Object>) -> Object?
    
    func fetch<Object: StorageObject>(_ type: Object.Type, sortDescriptors: [NSSortDescriptor], predicate: NSPredicate?) -> [Object]
    func fetch<Object: StorageObject>(_ type: Object.Type, sortDescriptors: [NSSortDescriptor]) -> [Object]
    func fetch<Object: StorageObject>(with fetchRequest: StorageFetchRequest<Object>) -> [Object]
    
    func count<Object: StorageObject>(_ type: Object.Type, sortDescriptors: [NSSortDescriptor], predicate: NSPredicate?) -> Int
    func count<Object: StorageObject>(_ type: Object.Type, sortDescriptors: [NSSortDescriptor]) -> Int
    func count<Object: StorageObject>(with fetchRequest: StorageFetchRequest<Object>) -> Int
    
    func clear<Object: StorageObject>(_ type: Object.Type, sortDescriptors: [NSSortDescriptor], predicate: NSPredicate?)
    func clear<Object: StorageObject>(_ type: Object.Type, sortDescriptors: [NSSortDescriptor])
    func clear<Object: StorageObject>(with fetchRequest: StorageFetchRequest<Object>)
    
    func remove<Object: StorageObject>(object: Object)
    func append<Object: StorageObject>(_ type: Object.Type) -> Object?
}

// MARK: -

public extension StorageManager {
    
    // MARK: - Instance Methods
    
    func first<Object: StorageObject>(_ type: Object.Type, sortDescriptors: [NSSortDescriptor], predicate: NSPredicate?) -> Object? {
        return self.first(with: StorageFetchRequest<Object>(sortDescriptors: sortDescriptors, predicate: predicate))
    }
    
    func first<Object: StorageObject>(_ type: Object.Type, sortDescriptors: [NSSortDescriptor]) -> Object? {
        return self.first(type, sortDescriptors: sortDescriptors, predicate: nil)
    }
    
    func last<Object: StorageObject>(_ type: Object.Type, sortDescriptors: [NSSortDescriptor], predicate: NSPredicate?) -> Object? {
        return self.last(with: StorageFetchRequest<Object>(sortDescriptors: sortDescriptors, predicate: predicate))
    }
    
    func last<Object: StorageObject>(_ type: Object.Type, sortDescriptors: [NSSortDescriptor]) -> Object? {
        return self.last(type, sortDescriptors: sortDescriptors, predicate: nil)
    }
    
    func fetch<Object: StorageObject>(_ type: Object.Type, sortDescriptors: [NSSortDescriptor], predicate: NSPredicate?) -> [Object] {
        return self.fetch(with: StorageFetchRequest<Object>(sortDescriptors: sortDescriptors, predicate: predicate))
    }
    
    func fetch<Object: StorageObject>(_ type: Object.Type, sortDescriptors: [NSSortDescriptor]) -> [Object] {
        return self.fetch(type, sortDescriptors: sortDescriptors, predicate: nil)
    }
    
    func count<Object: StorageObject>(_ type: Object.Type, sortDescriptors: [NSSortDescriptor], predicate: NSPredicate?) -> Int {
        return self.count(with: StorageFetchRequest<Object>(sortDescriptors: sortDescriptors, predicate: predicate))
    }
    
    func count<Object: StorageObject>(_ type: Object.Type, sortDescriptors: [NSSortDescriptor]) -> Int {
        return self.count(type, sortDescriptors: sortDescriptors, predicate: nil)
    }
    
    func clear<Object: StorageObject>(_ type: Object.Type, sortDescriptors: [NSSortDescriptor], predicate: NSPredicate?) {
        self.clear(with: StorageFetchRequest<Object>(sortDescriptors: sortDescriptors, predicate: predicate))
    }
    
    func clear<Object: StorageObject>(_ type: Object.Type, sortDescriptors: [NSSortDescriptor]) {
        self.clear(type, sortDescriptors: sortDescriptors, predicate: nil)
    }

    func append<Object: StorageObject>(_ type: Object.Type) -> Object? {
        self.append(type)
    }
}
