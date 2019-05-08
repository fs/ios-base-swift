//
//  CacheSession.swift
//  Swift-Base
//
//  Created by Oleg Gorelov on 12/04/2019.
//  Copyright © 2019 Flatstack. All rights reserved.
//

import Foundation

protocol CacheSession: AnyObject {

    // MARK: - Instance Properties

    var model: CacheModel { get }

    // MARK: - Initializers

    init(model: CacheModel, releaseHandler: @escaping (() -> Void))
}
