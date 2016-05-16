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

public func FSPrintDocumentsPath () {
    print("\n*******************************************\nDOCUMENTS\n\(NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0])\n*******************************************\n")
}

//MARK: - Interface

public var FSScreenBounds: CGRect {
    return UIScreen.mainScreen().bounds
}

public var FSIsIPad: Bool {
    return UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad
}

public var FSIsIPhone: Bool {
    return UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone
}

public var FSScaleFactor: CGFloat {
    return UIScreen.mainScreen().scale
}

public var FSIsRetina: Bool {
    return FSScaleFactor == 2
}

public var FSDeviceOrientation: UIDeviceOrientation {
    return UIDevice.currentDevice().orientation
}

//MARK: - App Version
public let FSAppVersion      = NSBundle.mainBundle().infoDictionary?.fs_objectForKey("CFBundleShortVersionString", orDefault: "0") as! String
public let FSBuildNumber     = NSBundle.mainBundle().infoDictionary?.fs_objectForKey("CFBundleVersion", orDefault: "0") as! String

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

//MARK: - iOS settings

// App settigns
public func APP_SETTINGS_URL() -> NSURL? {
    return NSURL(string: UIApplicationOpenSettingsURLString)
}

public func CAN_OPEN_SETTINGS_APP() -> Bool {
    if let url = APP_SETTINGS_URL() {
        return UIApplication.sharedApplication().canOpenURL(url)
    }
    
    return false
}

public func OPEN_SETTINGS_APP() -> Bool {
    if let url = APP_SETTINGS_URL() where CAN_OPEN_SETTINGS_APP() {
        return UIApplication.sharedApplication().openURL(url)
    }
    
    return false
}

// WIFI settings
public func WIFI_SETTINGS_URL() -> NSURL? {
    return NSURL(string: "prefs:root=WIFI")
}

public func CAN_OPEN_WIFI_SETTINGS() -> Bool {
    if let url = WIFI_SETTINGS_URL() {
        return UIApplication.sharedApplication().canOpenURL(url)
    }
    
    return false
}

public func OPEN_WIFI_SETTINGS() -> Bool {
    if let url = WIFI_SETTINGS_URL() where CAN_OPEN_WIFI_SETTINGS() {
        return UIApplication.sharedApplication().openURL(url)
    }
    
    return false
}

//MARK: - Other

public var FSGregorianCalendar: NSCalendar {return NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!}

/**
 Try to make call with input number
 
 - parameter number: phone number (string)
 
 - returns: 'true' if can open URL and 'false' if not or if can't initialize URL from input number
 */
public func FSMakePhoneCall (number: String) -> Bool {
    let callURLString = "tel://\(number)"
    guard let URL = NSURL(string: callURLString) else {return false}
    
    guard UIApplication.sharedApplication().canOpenURL(URL) else {
        return false
    }
    
    UIApplication.sharedApplication().openURL(URL)
    return true
}

public func FSGetRandomBool() -> Bool {
    return arc4random()%2 == 0
}

public func FSGetInfoDictionaryValue (key: String) -> AnyObject? {
    return NSBundle.mainBundle().infoDictionary?[key]
}

public func FSDLog(message: String, function: String = #function, file: String = #file, line: Int = #line) {
    #if DEBUG
        print("Message \"\(message)\" (File: \(file), Function: \(function), Line: \(line))")
    #endif
}

public func FSLog(format: String, _ args: CVarArgType...) {
    #if DEBUG
        withVaList(args) { (pointer: CVaListPointer) -> Void in
            NSLogv(format, pointer)
        }
    #endif
}
