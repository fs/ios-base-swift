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
    
    @available(iOS 10.0, *)
    public fileprivate(set) lazy var persistentContainer: NSPersistentContainer = { [unowned self] in
        let container = NSPersistentContainer(name: self.identifier)
        
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            guard error == nil else {
                fatalError()
            }
        })
        
        return container
    }()
    
    public fileprivate(set) lazy var managedObjectContext: NSManagedObjectContext = { [unowned self] in
        if #available(iOS 10.0, *) {
            return self.persistentContainer.viewContext
        } else {
            let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            
            managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator
            managedObjectContext.mergePolicy = NSErrorMergePolicy
            
            return managedObjectContext
        }
    }()
    
    public fileprivate(set) lazy var managedObjectModel: NSManagedObjectModel = { [unowned self] in
        if #available(iOS 10.0, *) {
            return self.persistentContainer.managedObjectModel
        } else {
            guard let fileURL = Bundle.main.url(forResource: self.identifier, withExtension:"momd") else {
                fatalError()
            }
            
            guard let managedObjectModel = NSManagedObjectModel(contentsOf: fileURL) else {
                fatalError()
            }
            
            return managedObjectModel
        }
    }()
    
    public fileprivate(set) lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = { [unowned self] in
        if #available(iOS 10.0, *) {
            return self.persistentContainer.persistentStoreCoordinator
        } else {
            let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
            
            let rootURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
            let fileURL = rootURL.appendingPathComponent("\(self.identifier).sqlite")
            
            do {
                try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                                  configurationName: nil,
                                                                  at: fileURL,
                                                                  options: nil)
            } catch {
                fatalError()
            }
            
            return persistentStoreCoordinator
        }
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
