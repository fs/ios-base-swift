//
//  CoreDataStorage.swift
//  Tools
//
//  Created by Almaz Ibragimov on 25.02.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation
import CoreData

public class CoreDataStorageModel<Manager: CoreDataStorageManager, Context: CoreDataStorageContext<Manager>>: StorageModel {
    
    // MARK: - Instance Propertes

    public fileprivate(set) lazy var persistentContainer: NSPersistentContainer = { [unowned self] in
        let container = NSPersistentContainer(name: self.identifier)
        
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            guard error == nil else {
                 fatalError()
            }
        })
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.undoManager = nil
        container.viewContext.shouldDeleteInaccessibleFaults = true

        container.viewContext.automaticallyMergesChangesFromParent = true
        
        return container
        }()
    
    public fileprivate(set) lazy var managedObjectContext: NSManagedObjectContext = { [unowned self] in
        return self.persistentContainer.viewContext
        }()
    
    public fileprivate(set) lazy var managedObjectModel: NSManagedObjectModel = { [unowned self] in
        return self.persistentContainer.managedObjectModel
        }()
    
    public fileprivate(set) lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = { [unowned self] in
        return self.persistentContainer.persistentStoreCoordinator
        }()
    
    // MARK: - Storage
    
    public let identifier: String
    
    public fileprivate(set) lazy var viewContext: StorageContext = { [unowned self] in
        return Context(managedObjectContext: self.managedObjectContext, model: self, parent: nil)
    }()
    
    // MARK: - Initializers
    
    public required init(identifier: String) {
        assert(!identifier.isEmpty)
        
        self.identifier = identifier
    }
}
