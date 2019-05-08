//
//  StorageContext.swift
//  Tools
//
//  Created by Almaz Ibragimov on 24.02.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation

public protocol StorageContext: class {
    
    // MARK: - Instance Properties
    
    var observers: [StorageContextObserver] { get }
    
    var model: StorageModel! { get }
    var parent: StorageContext? { get }
        
    var manager: StorageManager { get }
    
    var type: StorageContextType { get }
    
    // MARK: - Instance Methods
    
    func addObserver(_ observer: StorageContextObserver)
    func removeObserver(_ observer: StorageContextObserver)
    
    func createMainQueueChildContext() -> StorageContext
    func createPrivateQueueChildContext() -> StorageContext
    
    func performAndWait(block: @escaping () -> Void)
    func perform(block: @escaping () -> Void)
    
    func rollback()
    func save()
}
