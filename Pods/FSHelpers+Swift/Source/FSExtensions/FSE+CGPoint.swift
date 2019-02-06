//
//  FSE+CGPoint.swift
//  FSHelpers
//
//  Created by Timur Shafigullin on 05/01/2019.
//  Copyright © 2019 FlatStack. All rights reserved.
//

import Foundation
import CoreGraphics

public extension CGPoint {
    
    public var fs_adjusted: CGPoint {
        return CGPoint(x: Int(floor(self.x)),
                       y: Int(floor(self.y)))
    }
}
