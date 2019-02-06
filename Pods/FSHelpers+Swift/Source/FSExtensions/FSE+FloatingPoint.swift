//
//  FSE+FloatingPoint.swift
//  FSHelpers
//
//  Created by Timur Shafigullin on 05/01/2019.
//  Copyright © 2019 FlatStack. All rights reserved.
//

import Foundation

extension FloatingPoint {
    
    var fs_degreesToRadians: Self {
        return self * .pi / 180
    }
    
    var fs_radiansToDegrees: Self {
        return self * 180 / .pi
    }
}
