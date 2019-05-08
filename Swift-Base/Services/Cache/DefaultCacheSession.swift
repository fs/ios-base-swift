//
//  DefaultCacheSession.swift
//  Swift-Base
//
//  Created by Oleg Gorelov on 12/04/2019.
//  Copyright © 2019 Flatstack. All rights reserved.
//

import Foundation

class DefaultCacheSession: CacheSession {

    // MARK: - Instance Properties

    let releaseHandler: () -> Void

    // MARK: - AccountModelSession

    private(set) var model: CacheModel

    // MARK: - Initializers

    required init(model: CacheModel, releaseHandler: @escaping (() -> Void)) {
        self.releaseHandler = releaseHandler

        self.model = model
    }

    deinit {
        self.releaseHandler()
    }
}
