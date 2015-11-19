//
//  FSHelpers.swift
//  Swift-Base
//
//  Created by Kruperfone on 08.12.14.
//  Copyright (c) 2014 Flatstack. All rights reserved.
//


import UIKit

//MARK: - Application Directory

public func FSApplicationDirectoryPath (directoryToSearch:NSSearchPathDirectory) -> String {
    return NSSearchPathForDirectoriesInDomains(directoryToSearch, NSSearchPathDomainMask.UserDomainMask, true).first!
}

public func FSApplicationDirectoryURL (directoryToSearch:NSSearchPathDirectory) -> NSURL {
    return NSURL(string: FSApplicationDirectoryPath(directoryToSearch))!
}

//MARK: - Interface

public let FSScreenBounds: CGRect = UIScreen.mainScreen().bounds

public func FSIsIPad () -> Bool {
    return UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad
}

public func FSIsIPhone () -> Bool {
    return UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone
}

public func FSScaleFactor () -> CGFloat {
    return UIScreen.mainScreen().scale
}

public func FSIsRetina () -> Bool {
    return FSScaleFactor() == 2
}

public func FSDeviceOrientation () -> UIDeviceOrientation {
    return UIDevice.currentDevice().orientation
}

//MARK: - System Version

public func FSSystemVersionEqualTo(version: String) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version,
        options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedSame
}

public func FSSystemVersionGreatherThan(version: String) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version,
        options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedDescending
}

public func FSSystemVersionGreatherThanOrEqualTo(version: String) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version,
        options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedAscending
}

public func FSSystemVersionLessThan(version: String) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version,
        options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedAscending
}

public func FSSystemVersionLessThanOrEqualTo(version: String) -> Bool {
    return UIDevice.currentDevice().systemVersion.compare(version,
        options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedDescending
}

//MARK: - Images and colors

public func FSRGBA (r:CGFloat, _ g:CGFloat, _ b:CGFloat, _ a:CGFloat) -> UIColor {
    return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
}

public func FSImageFromColor (color:UIColor) -> UIImage {
    
    let rect:CGRect = CGRectMake(0, 0, 1, 1)
    UIGraphicsBeginImageContext(rect.size)
    let context:CGContextRef = UIGraphicsGetCurrentContext()!
    
    CGContextSetFillColorWithColor(context, color.CGColor)
    CGContextFillRect(context, rect)
    
    let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image
}

public func FSRandomColor () -> UIColor {
    let red     = CGFloat(arc4random_uniform(255))/255.0
    let green   = CGFloat(arc4random_uniform(255))/255.0
    let blue    = CGFloat(arc4random_uniform(255))/255.0
    
    return UIColor(red: red, green: green, blue: blue, alpha: 1)
}

//MARK: - GCD

public func FSDispatch_after_short (delay:Double, block:dispatch_block_t) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), block);
}

//MARK: - Other

public func FSDLog(message: String, function: String = __FUNCTION__, file: String = __FILE__, line: Int = __LINE__) {
    #if DEBUG
        print("Message \"\(message)\" (File: \(file), Function: \(function), Line: \(line))")
    #endif
}

//MARK: - Enumerations

public enum FSScreenTypeInch {
    case _3_5
    case _4
    case _4_7
    case _5_5
    
    public var size:CGSize {
        switch self {
        case ._3_5: return CGSizeMake(320, 480)
        case ._4:   return CGSizeMake(320, 568)
        case ._4_7: return CGSizeMake(375, 667)
        case ._5_5: return CGSizeMake(414, 736)
        }
    }
    
    public init () {
        self = FSScreenTypeInch.typeForSize(UIScreen.mainScreen().bounds.size)
    }
    
    public init (size: CGSize) {
        self = FSScreenTypeInch.typeForSize(size)
    }
    
    static private func typeForSize (size: CGSize) -> FSScreenTypeInch {
        let width = min(size.width, size.height)
        let height = max(size.width, size.height)
        
        switch CGSizeMake(width, height) {
        case FSScreenTypeInch._3_5.size:  return FSScreenTypeInch._3_5
        case FSScreenTypeInch._4.size:    return FSScreenTypeInch._4
        case FSScreenTypeInch._4_7.size:  return FSScreenTypeInch._4_7
        case FSScreenTypeInch._5_5.size:  return FSScreenTypeInch._5_5
        default:                          return FSScreenTypeInch._4
        }
    }
    
    public func getScreenValue (value3_5 value3_5:Any, value4:Any, value4_7:Any, value5_5:Any) -> Any {
        switch self {
        case ._3_5:     return value3_5
        case ._4:       return value4
        case ._4_7:     return value4_7
        case ._5_5:     return value5_5
        }
    }
    
    public func getScreenCGFloat (value3_5 value3_5:CGFloat, value4:CGFloat, value4_7:CGFloat, value5_5:CGFloat) -> CGFloat {
        return self.getScreenValue(value3_5:value3_5, value4: value4, value4_7: value4_7, value5_5: value5_5) as! CGFloat
    }
    
    public func getScreenCGFloat (value4 value4:CGFloat, value4_7:CGFloat, value5_5:CGFloat) -> CGFloat {
        return self.getScreenCGFloat(value3_5:value4, value4: value4, value4_7: value4_7, value5_5: value5_5)
    }
}
