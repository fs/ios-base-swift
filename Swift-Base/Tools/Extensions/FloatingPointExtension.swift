//
//  FloatingPointExtension.swift
//  Tools
//
//  Created by Almaz Ibragimov on 18.04.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation

extension FloatingPoint {

    // MARK: - Instance Properties

    var degreesToRadians: Self {
        return self * .pi / 180
    }

    var radiansToDegrees: Self {
        return self * 180 / .pi
    }
}
