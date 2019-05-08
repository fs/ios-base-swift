//
//  Services.swift
//  Swift-Base
//
//  Created by Elina Batyrova on 28/03/2019.
//  Copyright © 2019 Flatstack. All rights reserved.
//

import Foundation

enum Services {

    // MARK: - Type Properties

    static let cacheProvider: CacheProvider = DefaultCacheProvider<DefaultCacheSession>(model: Models.cacheModel)

    static var cacheViewContext: CacheContext {
        return Services.cacheProvider.model.viewContext
    }
}
