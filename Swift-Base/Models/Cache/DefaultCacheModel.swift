//
//  DefaultCacheModel.swift
//  Swift-Base
//
//  Created by Oleg Gorelov on 08/09/2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation

final class DefaultCacheModel: CacheModel {

    // MARK: - Instance Properties

    let storageModel: StorageModel

    let contextFactory: CacheContextFactory
    let managerFactory: CacheManagerFactory

    private(set) lazy var viewContext: CacheContext = { [unowned self] in
        return self.contextFactory.createCacheContext(storageContext: self.storageModel.viewContext, model: self, parent: nil)
    }()

    // MARK: - Initializers

    init(storageModel: StorageModel, contextFactory: CacheContextFactory, managerFactory: CacheManagerFactory) {
        self.storageModel = storageModel

        self.contextFactory = contextFactory
        self.managerFactory = managerFactory
    }
}
