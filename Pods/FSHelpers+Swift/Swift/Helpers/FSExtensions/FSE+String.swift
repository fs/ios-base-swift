//
//  FSExtensions+String.swift
//  SwiftHelpers
//
//  Created by Kruperfone on 31.07.15.
//  Copyright (c) 2015 FlatStack. All rights reserved.
//

import UIKit

public extension String {
    
    public func fs_toDouble   () -> Double?   {return Double(self)}
    public func fs_toInt      () -> Int?      {return Int(self)}
    
    public var fs_lenght: Int {
        return self.characters.count
    }
    
    public func fs_getRowHeight (font: UIFont) -> CGFloat {
        return self.fs_getStringHeight(font, width: CGFloat.max)
    }
    
    public func fs_getLineCount (font: UIFont) -> Int {
        let rowHeight = self.fs_getRowHeight(font)
        return Int(ceil(rowHeight / font.lineHeight))
    }
    
    public func fs_URLEncodedString () -> String? {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
    }
    
    public func fs_URLDecodedString () -> String? {
        return self.stringByRemovingPercentEncoding
    }
    
    public func fs_emailValidate () -> Bool {
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let regExPredicate:NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        return regExPredicate.evaluateWithObject(self.lowercaseString)
    }
    
    public func fs_getStringWidth (font: UIFont, height: CGFloat) -> CGFloat {
        
        let boundingSize:CGSize = CGSizeMake(CGFloat.max, height)
        
        let attributes = [NSFontAttributeName:font]
        
        let options : NSStringDrawingOptions = unsafeBitCast(
            NSStringDrawingOptions.UsesLineFragmentOrigin.rawValue |
                NSStringDrawingOptions.UsesFontLeading.rawValue,
            NSStringDrawingOptions.self)
        
        let text = self as NSString
        
        let rect = text.boundingRectWithSize(boundingSize, options:options, attributes: attributes, context:nil)
        
        return ceil(rect.size.width)
    }
    
    public func fs_getStringHeight (font: UIFont, width: CGFloat) -> CGFloat {
        
        let boundingSize:CGSize = CGSizeMake(width, CGFloat.max)
        
        let attributes = [NSFontAttributeName:font]
        
        let options : NSStringDrawingOptions = unsafeBitCast(
            NSStringDrawingOptions.UsesLineFragmentOrigin.rawValue |
                NSStringDrawingOptions.UsesFontLeading.rawValue,
            NSStringDrawingOptions.self)
        
        let text = self as NSString
        
        let rect = text.boundingRectWithSize(boundingSize, options:options, attributes: attributes, context:nil)
        
        return ceil(rect.size.height)
    }
    
    public func fs_getStringBetweenString (firstString: String, secondString: String) -> String? {
        var string = self
        
        guard let lFirstRange = self.rangeOfString(firstString) else {return nil}
        let strinBefore = self.substringToIndex(lFirstRange.endIndex)
        string = self.stringByReplacingOccurrencesOfString(strinBefore, withString: "")
        
        guard let lSecondRange = string.rangeOfString(secondString) else {return nil}
        let stringAfter = string.substringFromIndex(lSecondRange.startIndex)
        string = string.stringByReplacingOccurrencesOfString(stringAfter, withString: "")
        
        return string
    }
    
    public var fs_localizedString: String {
        let localized = NSLocalizedString(self.fs_localizedStringFormat, comment: "")
        return localized
    }
    
    internal var fs_localizedStringFormat: String {
        
        let uppercase = self.uppercaseString
        let formatted = uppercase.stringByReplacingOccurrencesOfString(" ", withString: "_", options: .LiteralSearch, range: nil)
        
        return formatted
    }
    
    public subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    public subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    public subscript (range: Range<Int>) -> String {
        return self.substringWithRange(Range(self.startIndex.advancedBy(range.startIndex) ..< self.startIndex.advancedBy(range.endIndex)))
    }
}
