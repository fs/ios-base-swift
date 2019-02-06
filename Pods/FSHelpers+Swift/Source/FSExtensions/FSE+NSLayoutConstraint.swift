//
//  FSE+NSLayoutConstraint.swift
//  FSHelpers
//
//  Created by Timur Shafigullin on 05/01/2019.
//  Copyright © 2019 FlatStack. All rights reserved.
//

import UIKit

public extension NSLayoutConstraint {
    
    @IBInspectable public final var fs_preciseConstant: Int {
        get {
            return Int(self.constant * UIScreen.main.scale)
        }
        
        set {
            self.constant = CGFloat(newValue) / UIScreen.main.scale
        }
    }
}
