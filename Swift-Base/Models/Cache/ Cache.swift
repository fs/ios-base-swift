//
//   Cache.swift
//  Swift-Base
//
//  Created by mac-mini-137 on 20.05.2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation

class Cache {

    // MARK: - Type Properties

    static let storageModel: StorageModel = CoreDataStorageModel(identifier: "Swift-Base")

    // MARK: - Instance Properties

    lazy var currentUserCacheManager: CurrentUserCacheManager = DefaultCurrentUserCacheManager(storageModel: Cache.storageModel)
    lazy var userCacheManager: UserCacheManager = DefaultUserCacheManager(storageModel: Cache.storageModel)
}
