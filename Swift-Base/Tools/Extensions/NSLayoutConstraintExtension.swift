//
//  NSLayoutConstraintExtension.swift
//  Tools
//
//  Created by Almaz Ibragimov on 01.01.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import UIKit

public extension NSLayoutConstraint {

    // MARK: - Instance Properties

    @IBInspectable final var preciseConstant: Int {
        get {
            return Int(self.constant * UIScreen.main.scale)
        }

        set {
            self.constant = CGFloat(newValue) / UIScreen.main.scale
        }
    }
}
