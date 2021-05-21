//
//  DefaultCurrentIUserCacheManager.swift
//  Swift-Base
//
//  Created by mac-mini-137 on 20.05.2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation
import CoreData

struct DefaultCurrentUserCacheManager: CurrentUserCacheManager {

    // MARK: - Instance Properties

    var storageModel: StorageModel!

    // MARK: - Instance Methods

    
    func save() {
        self.storageModel.viewContext.save()
    }
    
    func save(context: StorageContext) {
        context.save()
    }
    
    func remove() {
        self.storageModel.viewContext.manager.clear(CurrentUser.self, sortDescriptors: [])
    }
}
