//
//  StorageContextObserver.swift
//  Tools
//
//  Created by Almaz Ibragimov on 10.05.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation

public protocol StorageContextObserver: AnyObject {
    
    // MARK: - Instance Methods
    
    func storageContext(_ storageContext: StorageContext, didRemoveObjects objects: [StorageObject])
    func storageContext(_ storageContext: StorageContext, didAppendObjects objects: [StorageObject])
    func storageContext(_ storageContext: StorageContext, didUpdateObjects objects: [StorageObject])
    func storageContext(_ storageContext: StorageContext, didChangeObjects objects: [StorageObject])
}
