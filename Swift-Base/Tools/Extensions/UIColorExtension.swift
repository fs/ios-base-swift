//
//  UIColorExtension.swift
//  Tools
//
//  Created by Almaz Ibragimov on 01.01.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import UIKit

public extension UIColor {

    // MARK: - Initializers

    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }

    convenience init(redByte: UInt8, greenByte: UInt8, blueByte: UInt8, alphaByte: UInt8) {
        self.init(red: CGFloat(redByte) / 255.0,
                  green: CGFloat(greenByte) / 255.0,
                  blue: CGFloat(blueByte) / 255.0,
                  alpha: CGFloat(alphaByte) / 255.0)
    }

    convenience init(redByte: UInt8, greenByte: UInt8, blueByte: UInt8, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(redByte) / 255.0,
                  green: CGFloat(greenByte) / 255.0,
                  blue: CGFloat(blueByte) / 255.0,
                  alpha: alpha)
    }

    convenience init(white: CGFloat) {
        self.init(white: white, alpha: 1.0)
    }

    convenience init(whiteByte: UInt, alphaByte: UInt8) {
        self.init(white: CGFloat(whiteByte) / 255.0, alpha: CGFloat(alphaByte) / 255.0)
    }

    convenience init(whiteByte: UInt, alpha: CGFloat = 1.0) {
        self.init(white: CGFloat(whiteByte) / 255.0, alpha: alpha)
    }

    convenience init(withRGBHex hex: UInt32) {
        self.init(redByte: UInt8((hex >> 16) & 255),
                  greenByte: UInt8((hex >> 8) & 255),
                  blueByte: UInt8(hex & 255))
    }
}
