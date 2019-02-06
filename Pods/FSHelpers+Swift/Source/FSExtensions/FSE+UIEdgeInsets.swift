//
//  FSE+UIEdgeInsets.swift
//  FSHelpers
//
//  Created by Timur Shafigullin on 05/01/2019.
//  Copyright © 2019 FlatStack. All rights reserved.
//

import UIKit

public extension UIEdgeInsets {
    
    public init(equilateral side: CGFloat) {
        self.init(top: side, left: side, bottom: side, right: side)
    }
}
