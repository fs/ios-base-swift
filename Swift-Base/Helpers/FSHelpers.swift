//
//  FSHelpers.swift
//  Swift-Base
//
//  Created by Kruperfone on 08.12.14.
//  Copyright (c) 2014 Flatstack. All rights reserved.
//


import Foundation

func ApplicationDelegate () -> AppDelegate {
    return UIApplication.sharedApplication().delegate as AppDelegate
}

func ApplicationDirectoryPath (directoryToSearch:NSSearchPathDirectory) -> String {
    return NSSearchPathForDirectoriesInDomains(directoryToSearch, NSSearchPathDomainMask.UserDomainMask, true).first as String
}

func ApplicationDirectoryURL (directoryToSearch:NSSearchPathDirectory) -> NSURL {
    return NSURL(string: ApplicationDirectoryPath(directoryToSearch))!
}

func SetNetworkActivityIndicatorVisible (visible:Bool) {
    UIApplication.sharedApplication().networkActivityIndicatorVisible = visible
}

let ScreenBounds: CGRect = UIScreen.mainScreen().bounds

func IsIPad () -> Bool {
    return UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad
}

func IsIPhone () -> Bool {
    return UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone
}

func IsRetina () -> Bool {
    return UIScreen.mainScreen().scale == 2
}

func InterfaceOrientation () -> UIInterfaceOrientation {
    return UIApplication.sharedApplication().statusBarOrientation
}

func DeviceOrientation () -> UIDeviceOrientation {
    return UIDevice.currentDevice().orientation
}

func SystemVersionEqualTo(version: NSString) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version,
        options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedSame
}

func SystemVersionGreatherThan(version: NSString) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version,
        options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedDescending
}

func SystemVersionGreatherThanOrEqualTo(version: NSString) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version,
        options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedAscending
}

func SystemVersionLessThan(version: NSString) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version,
        options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedAscending
}

func SystemVersionLessThanOrEqualTo(version: NSString) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version,
        options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedDescending
}

func RGBA (r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {    
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

func DLog(message: String, function: String = __FUNCTION__, file: String = __FILE__, line: Int = __LINE__) {
    
    if DEBUG == 1 {
        println("Message \"\(message)\" (File: \(file), Function: \(function), Line: \(line))")
    }
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

extension Double {
    var dispatchTime: dispatch_time_t {
        get {
            return dispatch_time(DISPATCH_TIME_NOW,Int64(self * Double(NSEC_PER_SEC)))
        }
    }
}

func dispatch_after_short (delay:Double, block:dispatch_block_t) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), block);
}

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
        var width = min(UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
        var height = max(UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
        
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
    
    init (size:CGSize) {
        var width = min(size.width, size.height)
        var height = max(size.width, size.height)
        
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
            self = ScreenTypeInch._4
        }
    }
}
