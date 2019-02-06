//
//  FSHelpers.swift
//  Swift-Base
//
//  Created by Kruperfone on 08.12.14.
//  Copyright (c) 2014 Flatstack. All rights reserved.
//


import UIKit

//MARK: - Application Directory

public enum FSAppDirectory {
    public static func Path (_ directoryToSearch: FileManager.SearchPathDirectory) -> String {
        return NSSearchPathForDirectoriesInDomains(directoryToSearch, FileManager.SearchPathDomainMask.userDomainMask, true).first!
    }
    
    public static func URL (_ directoryToSearch: FileManager.SearchPathDirectory) -> Foundation.URL {
        return Foundation.URL(string: Path(directoryToSearch))!
    }
    
    public static func PrintDocumentsPath () {
        print("\n*******************************************\nDOCUMENTS\n\(NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0])\n*******************************************\n")
    }
}

//MARK: - App Version
public let FSAppVersion      = Bundle.main.infoDictionary?.fs_objectForKey("CFBundleShortVersionString", orDefault: "0") as! String
public let FSBuildNumber     = Bundle.main.infoDictionary?.fs_objectForKey("CFBundleVersion", orDefault: "0") as! String

//MARK: - System Version

public enum FSSystemVersion {
    
    public static func EqualTo(_ version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: .numeric) == .orderedSame
    }
    
    public static func GreatherThan(_ version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: .numeric) == .orderedDescending
    }
    
    public static func GreatherThanOrEqualTo(_ version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: .numeric) != .orderedAscending
    }
    
    public static func LessThan(_ version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: .numeric) == .orderedAscending
    }
    
    public static func LessThanOrEqualTo(_ version: String) -> Bool {
        return UIDevice.current.systemVersion.compare(version, options: .numeric) != .orderedDescending
    }
}

//MARK: - Images and colors

public func FSRGBA (_ r:CGFloat, _ g:CGFloat, _ b:CGFloat, _ a:CGFloat) -> UIColor {
    return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
}

public func FSImageFromColor (_ color:UIColor) -> UIImage {
    
    let rect:CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
    UIGraphicsBeginImageContext(rect.size)
    let context:CGContext = UIGraphicsGetCurrentContext()!
    
    context.setFillColor(color.cgColor)
    context.fill(rect)
    
    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
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

public func FSDispatch_after_short (_ delay:Double, block:@escaping ()->()) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: block);
}

//MARK: - iOS settings

public protocol FSSettingsAppProtocol {
    var URL: Foundation.URL {get}
    var canOpen: Bool {get}
    func open () -> Bool
}

public extension FSSettingsAppProtocol {
    public var canOpen: Bool {
        return UIApplication.shared.canOpenURL(URL)
    }
    
    public func open () -> Bool {
        guard canOpen else {return false}
        return UIApplication.shared.openURL(URL)
    }
}

public enum FSSettingsApp: FSSettingsAppProtocol {
    
    case settings
    
    public var URL: Foundation.URL {
        switch self {
        case .settings: return Foundation.URL(string: UIApplicationOpenSettingsURLString)!
        }
    }
}

//MARK: - Other

public var FSGregorianCalendar: Calendar {return Calendar(identifier: Calendar.Identifier.gregorian)}

/**
 Try to make call with input number
 
 - parameter number: phone number (string)
 
 - returns: 'true' if can open URL and 'false' if not or if can't initialize URL from input number
 */
public func FSMakePhoneCall (_ number: String) -> Bool {
    let callURLString = "tel://\(number)"
    guard let URL = URL(string: callURLString) else {return false}
    
    guard UIApplication.shared.canOpenURL(URL) else {
        return false
    }
    
    return UIApplication.shared.openURL(URL)
}

public func FSGetRandomBool() -> Bool {
    return arc4random()%2 == 0
}

public func FSGetInfoDictionaryValue (_ key: String) -> AnyObject? {
    return Bundle.main.infoDictionary?[key] as AnyObject?
}

public func FSDLog(_ message: String, function: String = #function, file: String = #file, line: Int = #line) {
    #if DEBUG
        print("Message \"\(message)\" (File: \(file), Function: \(function), Line: \(line))")
    #endif
}

public func FSLog(_ format: String, _ args: CVarArg...) {
    #if DEBUG
        withVaList(args) { (pointer: CVaListPointer) -> Void in
            NSLogv(format, pointer)
        }
    #endif
}
