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
        
        let regex: NSRegularExpression = try! NSRegularExpression(pattern: "[^a-fA-F|0-9]", options: [])
        
        let match: Int = regex.numberOfMatchesInString(fs_hexString, options: NSMatchingOptions.ReportCompletion, range: NSMakeRange(0, fs_hexString.characters.count))
        
        if (match != 0) {
            self.init()
            return nil
        }
        
        var cString: String = fs_hexString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
        }
        
        if (cString.characters.count != 6) {
            self.init()
            return nil
        }
        
        var rgbValue: UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
        
        self.init(
            red     : CGFloat((rgbValue & 0xFF0000) >> 16)  / 255,
            green   : CGFloat((rgbValue & 0x00FF00) >> 8)   / 255,
            blue    : CGFloat((rgbValue & 0x0000FF) >> 0)   / 255,
            alpha   : alpha
        )
    }
    
    public func fs_hexString () -> String {
        
        // Special case, as white doesn't fall into the RGB color space
        if (self == UIColor.whiteColor()) {
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
