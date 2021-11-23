//
//  CoreDataStorageManager.swift
//  Tools
//
//  Created by Almaz Ibragimov on 25.02.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation
import CoreData

public class CoreDataStorageManager: StorageManager {

    // MARK: - Instance Properties
    
    public unowned let managedObjectContext: NSManagedObjectContext
    
    // MARK: - StorageManager
    
    unowned public let context: StorageContext
    
    // MARK: - Initializers
    
    public required init(managedObjectContext: NSManagedObjectContext, context: StorageContext) {
        self.managedObjectContext = managedObjectContext
        
        self.context = context
    }
    
    // MARK: - Instance Methods
    
    public func first<Object: StorageObject>(with fetchRequest: StorageFetchRequest<Object>) -> Object? {
        var fetchRequest = fetchRequest
        
        fetchRequest.fetchLimit = 1
        fetchRequest.fetchBatchSize = 1
        
        return self.fetch(with: fetchRequest).first
    }
    
    public func last<Object: StorageObject>(with fetchRequest: StorageFetchRequest<Object>) -> Object? {
        let sortDescriptors = fetchRequest.sortDescriptors.map({ sortDescriptor in
            return sortDescriptor.reversedSortDescriptor as! NSSortDescriptor
        })
        
        var fetchRequest = fetchRequest
        
        fetchRequest.sortDescriptors = sortDescriptors
        fetchRequest.fetchLimit = 1
        fetchRequest.fetchBatchSize = 1
        
        return self.fetch(with: fetchRequest).first
    }
    
    public func fetch<Object: StorageObject>(with fetchRequest: StorageFetchRequest<Object>) -> [Object] {
        guard let objects = (try? self.managedObjectContext.fetch(fetchRequest.coreDataFetchRequest())) as? [Object] else {
            return []
        }
        
        return objects
    }
    
    public func count<Object: StorageObject>(with fetchRequest: StorageFetchRequest<Object>) -> Int {
        guard let count = try? self.managedObjectContext.count(for: fetchRequest.coreDataFetchRequest()) else {
            return 0
        }
        
        return count
    }
    
    public func clear<Object: StorageObject>(with fetchRequest: StorageFetchRequest<Object>) {
        guard let objects = try? self.managedObjectContext.fetch(fetchRequest.coreDataFetchRequest()) else {
            return
        }
            
        for object in objects {
            self.managedObjectContext.delete(object)
        }
    }
    
    public func remove<Object: StorageObject>(object: Object) {
        guard let object = object as? NSManagedObject, !object.isDeleted else {
            return
        }
        
        self.managedObjectContext.delete(object)
    }
    
    public func append<Object: StorageObject>(_ type: Object.Type) -> Object? {
        guard let entity = NSEntityDescription.entity(forEntityName: Object.entityName, in: self.managedObjectContext) else {
            return nil
        }
        
        return NSManagedObject(entity: entity, insertInto: self.managedObjectContext) as? Object
    }
}
