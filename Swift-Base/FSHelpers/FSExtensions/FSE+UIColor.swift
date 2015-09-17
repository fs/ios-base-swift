//
//  FSE+UIColor.swift
//  SwiftHelpers
//
//  Created by Kruperfone on 31.07.15.
//  Copyright (c) 2015 FlatStack. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init? (hexString:String) {
        
        let regex:NSRegularExpression = try! NSRegularExpression(pattern: "[^a-fA-F|0-9]", options: [])
        
        let match:Int = regex.numberOfMatchesInString(hexString, options: NSMatchingOptions.ReportCompletion, range: NSMakeRange(0, hexString.characters.count))
        
        if (match != 0) {
            self.init()
            return nil
        }
        
        var cString:String = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
        }
        
        if (cString.characters.count != 6) {
            self.init()
            return nil
        }
        
        var rgbValue:UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func hexString () -> String {
        
        // Special case, as white doesn't fall into the RGB color space
        if (self == UIColor.whiteColor()) {
            return "ffffff"
        }
        
        var red:CGFloat = 0
        var blue:CGFloat = 0
        var green:CGFloat = 0
        var alpha:CGFloat = 0
        
        self.getRed(&(red), green: &green, blue: &blue, alpha: &alpha)
        
        let hexString:String = NSString(format: "%02x%02x%02x", (Int(red*255)), (Int(blue*255)), (Int(green*255))) as String
        
        return hexString
    }
}
