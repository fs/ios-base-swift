//
//  Models.swift
//  Swift-Base
//
//  Created by Timur Shafigullin on 08/05/2019.
//  Copyright © 2019 Flatstack. All rights reserved.
//

import Foundation

enum Models {

    // MARK: - Type Properties

    static let cacheStorageModel: StorageModel = CoreDataStorageModel(identifier: "Swift-Base")

    static let cacheContextFactory: CacheContextFactory = DefaultCacheContextFactory()
    static let cacheManagerFactory: CacheManagerFactory = DefaultCacheManagerFactory()

    // MARK: -

    static let cacheModel: CacheModel = DefaultCacheModel(storageModel: Models.cacheStorageModel,
                                                          contextFactory: Models.cacheContextFactory,
                                                          managerFactory: Models.cacheManagerFactory)
}
