//
//  CGPointExtension.swift
//  Tools
//
//  Created by Almaz Ibragimov on 01.01.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation
import CoreGraphics

public extension CGPoint {

    // MARK: - Instance Properties

    var adjusted: CGPoint {
        return CGPoint(x: Int(floor(self.x)),
                       y: Int(floor(self.y)))
    }
}
