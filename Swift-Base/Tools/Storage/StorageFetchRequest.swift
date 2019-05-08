//
//  StorageFetchRequest.swift
//  Tools
//
//  Created by Almaz Ibragimov on 24.02.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation

public struct StorageFetchRequest<Object: StorageObject> {
    
    // MARK: - Instance Properties
    
    public var sortDescriptors: [NSSortDescriptor]
    public var predicate: NSPredicate?
    
    // MARK: -
    
    public var returnsObjectsAsFaults: Bool = true
    
    public var includesSubentities: Bool = true
    public var includesPendingChanges: Bool = true
    public var includesPropertyValues: Bool = true
    
    public var shouldRefreshRefetchedObjects: Bool = false
    
    public var fetchOffset: Int = 0
    public var fetchLimit: Int = 0
    public var fetchBatchSize: Int = 0
    
    public var relationshipsForPrefetching: [String]?
    
    // MARK: - Initializers
    
    public init(sortDescriptors: [NSSortDescriptor], predicate: NSPredicate?) {
        self.sortDescriptors = sortDescriptors
        self.predicate = predicate
    }
}
