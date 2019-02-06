//
//  FSE+UIColor.swift
//  SwiftHelpers
//
//  Created by Kruperfone on 31.07.15.
//  Copyright (c) 2015 FlatStack. All rights reserved.
//

import UIKit

public extension UIColor {
    
    convenience public init? (fs_hexString: String, alpha: CGFloat = 1) {
        
        let regex: NSRegularExpression = try! NSRegularExpression(pattern: "[^a-fA-F|0-9|#]", options: [])
        
        let match: Int = regex.numberOfMatches(in: fs_hexString, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, fs_hexString.count))
        
        if (match != 0) {
            self.init()
            return nil
        }
        
        var cString: String = fs_hexString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.removeFirst()
        }
        
        if (cString.count != 6) {
            self.init()
            return nil
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        self.init(
            red     : CGFloat((rgbValue & 0xFF0000) >> 16)  / 255,
            green   : CGFloat((rgbValue & 0x00FF00) >> 8)   / 255,
            blue    : CGFloat((rgbValue & 0x0000FF) >> 0)   / 255,
            alpha   : alpha
        )
    }
    
    public convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    public convenience init(redByte: UInt8, greenByte: UInt8, blueByte: UInt8, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(redByte) / 255.0,
                  green: CGFloat(greenByte) / 255.0,
                  blue: CGFloat(blueByte) / 255.0,
                  alpha: alpha)
    }
    
    public convenience init(white: CGFloat) {
        self.init(white: white, alpha: 1.0)
    }
    
    public convenience init(whiteByte: UInt, alpha: CGFloat = 1.0) {
        self.init(white: CGFloat(whiteByte) / 255.0, alpha: alpha)
    }
    
    public convenience init(withRGBHex hex: UInt32) {
        self.init(redByte: UInt8((hex >> 16) & 255),
                  greenByte: UInt8((hex >> 8) & 255),
                  blueByte: UInt8(hex & 255))
    }
    
    public func fs_hexString () -> String {
        
        // Special case, as white doesn't fall into the RGB color space
        if (self == UIColor.white) {
            return "ffffff"
        }
        
        var red     : CGFloat = 0
        var blue    : CGFloat = 0
        var green   : CGFloat = 0
        var alpha   : CGFloat = 0
        
        self.getRed(&(red), green: &green, blue: &blue, alpha: &alpha)
        
        let hexString = NSString(format: "%02x%02x%02x", (Int(red*255)), (Int(green*255)), (Int(blue*255))) as String
        
        return hexString
    }
    
}
