//
//  FSHelpers.swift
//  Swift-Base
//
//  Created by Kruperfone on 08.12.14.
//  Copyright (c) 2014 Flatstack. All rights reserved.
//


import UIKit

//MARK: - Application Directory

func ApplicationDirectoryPath (directoryToSearch:NSSearchPathDirectory) -> String {
    return NSSearchPathForDirectoriesInDomains(directoryToSearch, NSSearchPathDomainMask.UserDomainMask, true).first as! String
}

func ApplicationDirectoryURL (directoryToSearch:NSSearchPathDirectory) -> NSURL {
    return NSURL(string: ApplicationDirectoryPath(directoryToSearch))!
}

//MARK: - Interface

let ScreenBounds: CGRect = UIScreen.mainScreen().bounds

func IsIPad () -> Bool {
    return UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad
}

func IsIPhone () -> Bool {
    return UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone
}

func ScaleFactor () -> CGFloat {
    return UIScreen.mainScreen().scale
}

func IsRetina () -> Bool {
    return ScaleFactor() == 2
}

func DeviceOrientation () -> UIDeviceOrientation {
    return UIDevice.currentDevice().orientation
}

//MARK: - System Version

func SystemVersionEqualTo(version: String) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version,
        options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedSame
}

func SystemVersionGreatherThan(version: String) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version,
        options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedDescending
}

func SystemVersionGreatherThanOrEqualTo(version: String) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version,
        options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedAscending
}

func SystemVersionLessThan(version: String) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version,
        options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedAscending
}

func SystemVersionLessThanOrEqualTo(version: String) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version,
        options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedDescending
}

//MARK: - Images and colors

func RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {    
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

func ImageFromColor (color:UIColor) -> UIImage {
    
    var rect:CGRect = CGRectMake(0, 0, 1, 1)
    UIGraphicsBeginImageContext(rect.size)
    var context:CGContextRef = UIGraphicsGetCurrentContext()
    
    CGContextSetFillColorWithColor(context, color.CGColor)
    CGContextFillRect(context, rect)
    
    var image:UIImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image
}

func RandomColor () -> UIColor {
    var red:CGFloat = CGFloat(arc4random_uniform(255))/255.0
    var green:CGFloat = CGFloat(arc4random_uniform(255))/255.0
    var blue:CGFloat = CGFloat(arc4random_uniform(255))/255.0
    
    return UIColor(red: red, green: green, blue: blue, alpha: 1)
}

//MARK: - GCD

func dispatch_after_short (delay:Double, block:dispatch_block_t) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), block);
}

//MARK: - Other

func DLog(message: String, function: String = __FUNCTION__, file: String = __FILE__, line: Int = __LINE__) {
    #if DEBUG
        println("Message \"\(message)\" (File: \(file), Function: \(function), Line: \(line))")
    #endif
}

//MARK: - Enumerations

enum ScreenTypeInch {
    case _3_5
    case _4
    case _4_7
    case _5_5
    
    var size:CGSize {
        switch self {
        case ._3_5: return CGSizeMake(320, 480)
        case ._4:   return CGSizeMake(320, 568)
        case ._4_7: return CGSizeMake(375, 667)
        case ._5_5: return CGSizeMake(414, 736)
        }
    }
    
    init () {
        let size = UIScreen.mainScreen().bounds.size
        let width = min(size.width, size.height)
        let height = max(size.width, size.height)
        
        switch CGSizeMake(width, height) {
        case ScreenTypeInch._3_5.size:
            self = ScreenTypeInch._3_5
            
        case ScreenTypeInch._4.size:
            self = ScreenTypeInch._4
            
        case ScreenTypeInch._4_7.size:
            self = ScreenTypeInch._4_7
            
        case ScreenTypeInch._5_5.size:
            self = ScreenTypeInch._5_5
            
        default:
            self = ScreenTypeInch._5_5
        }
    }
    
    func getScreenValue (#value3_5:Any, value4:Any, value4_7:Any, value5_5:Any) -> Any {
        switch ScreenTypeInch() {
        case ._3_5:     return value3_5
        case ._4:       return value4
        case ._4_7:     return value4_7
        case ._5_5:     return value5_5
        }
    }
    
    func getScreenCGFloat (#value3_5:CGFloat, value4:CGFloat, value4_7:CGFloat, value5_5:CGFloat) -> CGFloat {
        return self.getScreenValue(value3_5:value3_5, value4: value4, value4_7: value4_7, value5_5: value5_5) as! CGFloat
    }
    
    func getScreenCGFloat (#value4:CGFloat, value4_7:CGFloat, value5_5:CGFloat) -> CGFloat {
        return self.getScreenCGFloat(value3_5:value4, value4: value4, value4_7: value4_7, value5_5: value5_5)
    }
}
