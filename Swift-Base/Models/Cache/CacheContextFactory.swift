//
//  CacheContextFactory.swift
//  Swift-Base
//
//  Created by Oleg Gorelov on 30/09/2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation

protocol CacheContextFactory {

    // MARK: - Instance Methods

    func createCacheContext(storageContext: StorageContext, model: CacheModel, parent: CacheContext?) -> CacheContext
}
