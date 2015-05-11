//
//  FSExtensions.swift
//  Swift-Base
//
//  Created by Kruperfone on 10.02.15.
//  Copyright (c) 2015 Flatstack. All rights reserved.
//

import UIKit

//MARK: UIView+Utils
extension UIView {
    func width () -> CGFloat {
        return self.frame.size.width
    }
    func height () -> CGFloat {
        return self.frame.size.height
    }
    func x () -> CGFloat {
        return self.frame.origin.x
    }
    func y () -> CGFloat {
        return self.frame.origin.y
    }
    
    func setSize (size:CGSize) {
        var frame = self.frame
        frame.size = size
        self.frame = frame
    }
    func setWidth (width:CGFloat) {
        setSize(CGSizeMake(width, frame.size.height))
    }
    func setHeight (height:CGFloat) {
        setSize(CGSizeMake(frame.size.width, height))
    }
    
    func setOrigin (origin:CGPoint) {
        var frame = self.frame
        frame.origin = origin
        self.frame = frame
    }
    func setX (x:CGFloat) {
        setOrigin(CGPointMake(x, frame.origin.y))
    }
    func setY (y:CGFloat) {
        setOrigin(CGPointMake(frame.origin.x, y))
    }
    
    func findAndResignFirstResponder () -> Bool {
        if self.isFirstResponder() {
            self.resignFirstResponder()
            return true
        }
        
        for view in subviews {
            if findAndResignFirstResponder() {
                return true
            }
        }
        
        return false
    }
    
    func allSubviews () -> [UIView] {
        var arr:[UIView] = [self]
        
        for view in subviews {
            arr += view.allSubviews()
        }
        
        return arr
    }
}

//MARK: Dictionary+Utils
extension Dictionary {
    func objectForKey(key:String, orDefault def:AnyObject) -> Value {
        var res = key as! Key
        
        if self[res] != nil {
            return self[res]!
        } else {
            return def as! Value
        }
    }
}

//MARK: Array+Utils
extension Array {
    func objectAtIndexOrNil (index:Int) -> T? {
        if (index < self.count && index >= 0) {
            return self[index]
        } else {
            return nil
        }
    }
    
    func shuffle () -> Array {
        var array:Array = self
        
        for (var i = 0; i < array.count; i++) {
            let remainingCount = array.count - i
            let exchangeIndex = i + Int(arc4random_uniform(UInt32(remainingCount)))
            
            swap(&array[i], &array[exchangeIndex])
        }
        
        return array
    }
}

//MARK: String+Utils
extension String {
    
    func getLineCount (font:UIFont, size:CGSize) -> Int {
        let rHeight:CGFloat = self.getStringHeight(font, width: size.width)
        return Int(ceil(rHeight / font.lineHeight))
    }
    
    func URLEncodedString () -> String {
        var str = CFURLCreateStringByAddingPercentEscapes(
            nil,
            self,
            nil,
            "!*'();:@&=+$,/?%#[]",
            CFStringBuiltInEncodings.UTF8.rawValue
        )
        return str as String
    }
    
    func URLDecodedString () -> String? {
        return self.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
    }
    
    func emailValidate () -> Bool {
        var emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        var regExPredicate:NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        return regExPredicate.evaluateWithObject(self)
    }
    
    func getStringWidth (font:UIFont, height:CGFloat) -> CGFloat {
        
        var boundingSize:CGSize = CGSizeMake(CGFloat.max, height)
        
        var attributes = [NSFontAttributeName:font]
        
        let options : NSStringDrawingOptions = unsafeBitCast(
            NSStringDrawingOptions.UsesLineFragmentOrigin.rawValue |
                NSStringDrawingOptions.UsesFontLeading.rawValue,
            NSStringDrawingOptions.self)
        
        var text = self as NSString
        
        var rect = text.boundingRectWithSize(boundingSize, options:options, attributes: attributes, context:nil)
        
        return ceil(rect.size.width)
    }
    
    func getStringHeight (font:UIFont, width:CGFloat) -> CGFloat {
        
        var boundingSize:CGSize = CGSizeMake(width, CGFloat.max)
        
        var attributes = [NSFontAttributeName:font]
        
        let options : NSStringDrawingOptions = unsafeBitCast(
            NSStringDrawingOptions.UsesLineFragmentOrigin.rawValue |
            NSStringDrawingOptions.UsesFontLeading.rawValue,
            NSStringDrawingOptions.self)
        
        var text = self as NSString
        
        var rect = text.boundingRectWithSize(boundingSize, options:options, attributes: attributes, context:nil)
        
        return ceil(rect.size.height)
    }
}

//MARK: UITableView+Utils
extension UITableView {
    func deselectSelectedRow (animated:Bool) {
        if ((self.indexPathForSelectedRow()) != nil) {
            self.deselectRowAtIndexPath(self.indexPathForSelectedRow()!, animated: animated)
        }
    }
}

//MARK: UIColor+Utils
extension UIColor {
    convenience init? (hexString:String) {
        
        var regex:NSRegularExpression = NSRegularExpression(pattern: "[^a-fA-F|0-9]", options: nil, error: nil)!
        
        var match:Int = regex.numberOfMatchesInString(hexString, options: NSMatchingOptions.ReportCompletion, range: NSMakeRange(0, count(hexString)))
        
        if (match != 0) {
            self.init()
            return nil
        }
        
        var cString:String = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(advance(cString.startIndex, 1))
        }
        
        if (count(cString) != 6) {
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
