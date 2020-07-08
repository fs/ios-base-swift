//
//  CGSizeExtension.swift
//  Tools
//
//  Created by Almaz Ibragimov on 01.01.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation
import CoreGraphics

public extension CGSize {

    // MARK: - Instance Properties

    var adjusted: CGSize {
        return CGSize(width: Int(ceil(self.width)),
                      height: Int(ceil(self.height)))
    }

    // MARK: - Initializers

    init(equilateral side: CGFloat) {
        self.init(width: side, height: side)
    }

    init(equilateral side: Double) {
        self.init(width: side, height: side)
    }

    init(equilateral side: Int) {
        self.init(width: side, height: side)
    }
}
