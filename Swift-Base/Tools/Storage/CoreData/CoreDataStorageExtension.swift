//
//  CoreDataStorageExtension.swift
//  Tools
//
//  Created by Almaz Ibragimov on 25.08.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject: StorageObject {
    
    // MARK: - Type Properties
    
    public static var entityName: String {
        return self.entity().name ?? String(describing: self)
    }
}

// MARK: -

extension NSManagedObjectContext {

    // MARK: - Instance Properties
    
    var storageContextType: StorageContextType {
        switch self.concurrencyType {
        case .mainQueueConcurrencyType:
            return .mainQueue
            
        case .privateQueueConcurrencyType, .confinementConcurrencyType:
            return .privateQueue

        @unknown default:
            fatalError()
        }
    }
}

// MARK: -

extension StorageFetchRequest {
    
    // MARK: - Instance Methods
    
    func coreDataFetchRequest() -> NSFetchRequest<NSManagedObject> {
        let coreDataFetchRequest = NSFetchRequest<NSManagedObject>(entityName: Object.entityName)
        
        coreDataFetchRequest.predicate = self.predicate
        coreDataFetchRequest.sortDescriptors = self.sortDescriptors
        
        coreDataFetchRequest.returnsObjectsAsFaults = self.returnsObjectsAsFaults
        
        coreDataFetchRequest.includesSubentities = self.includesSubentities
        coreDataFetchRequest.includesPendingChanges = self.includesPendingChanges
        coreDataFetchRequest.includesPropertyValues = self.includesPropertyValues
        
        coreDataFetchRequest.shouldRefreshRefetchedObjects = self.shouldRefreshRefetchedObjects
        
        coreDataFetchRequest.fetchOffset = self.fetchOffset
        coreDataFetchRequest.fetchLimit = self.fetchLimit
        coreDataFetchRequest.fetchBatchSize = self.fetchBatchSize
        
        coreDataFetchRequest.relationshipKeyPathsForPrefetching = self.relationshipsForPrefetching
        
        return coreDataFetchRequest
    }
}
