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

func dispatch_after_short (delay:CGFloat, block:dispatch_block_t) {    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64(delay) * Int64(NSEC_PER_SEC))), dispatch_get_main_queue(), block);
}
