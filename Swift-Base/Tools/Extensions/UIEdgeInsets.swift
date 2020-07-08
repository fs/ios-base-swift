//
//  UIEdgeInsets.swift
//  Tools
//
//  Created by Almaz Ibragimov on 01.01.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import UIKit

public extension UIEdgeInsets {

    // MARK: - Initializers

    init(equilateral side: CGFloat) {
        self.init(top: side, left: side, bottom: side, right: side)
    }
}
