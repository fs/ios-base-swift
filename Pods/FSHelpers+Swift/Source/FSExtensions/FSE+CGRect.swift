//
//  FSE+CGRect.swift
//  FSHelpers
//
//  Created by Timur Shafigullin on 05/01/2019.
//  Copyright © 2019 FlatStack. All rights reserved.
//

import Foundation
import CoreGraphics

public extension CGRect {
    
    public var fs_top: CGFloat {
        return self.origin.y
    }
    
    public var fs_bottom: CGFloat {
        return self.origin.y + self.size.height
    }
    
    public var fs_left: CGFloat {
        return self.origin.x
    }
    
    public var fs_right: CGFloat {
        return self.origin.x + self.size.width
    }
    
    public var fs_adjusted: CGRect {
        return CGRect(x: Int(floor(self.origin.x)),
                      y: Int(floor(self.origin.y)),
                      width: Int(ceil(self.size.width)),
                      height: Int(ceil(self.size.height)))
    }
    
    public init(x: CGFloat, y: CGFloat, size: CGSize) {
        self.init(x: x, y: y, width: size.width, height: size.height)
    }
    
    public init(x: Double, y: Double, size: CGSize) {
        self.init(x: x, y: y, width: Double(size.width), height: Double(size.height))
    }
    
    public init(x: Int, y: Int, size: CGSize) {
        self.init(x: CGFloat(x), y: CGFloat(y), width: size.width, height: size.height)
    }
}
