//
//  FSE+CGSize.swift
//  FSHelpers
//
//  Created by Timur Shafigullin on 05/01/2019.
//  Copyright © 2019 FlatStack. All rights reserved.
//

import Foundation
import CoreGraphics

public extension CGSize {
    
    public var fs_adjusted: CGSize {
        return CGSize(width: Int(ceil(self.width)),
                      height: Int(ceil(self.height)))
    }
    
    public init(equilateral side: CGFloat) {
        self.init(width: side, height: side)
    }
    
    public init(equilateral side: Double) {
        self.init(width: side, height: side)
    }
    
    public init(equilateral side: Int) {
        self.init(width: side, height: side)
    }
}
