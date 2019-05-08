//
//  CacheProvider.swift
//  Swift-Base
//
//  Created by Oleg Gorelov on 12/04/2019.
//  Copyright © 2019 Flatstack. All rights reserved.
//

import Foundation
import PromiseKit

protocol CacheProvider {

    // MARK: - Instance Properties

    var isModelCaptured: Bool { get }

    var model: CacheModel { get }

    // MARK: - Instance Methods

    func captureModel() -> Guarantee<CacheSession>
}
