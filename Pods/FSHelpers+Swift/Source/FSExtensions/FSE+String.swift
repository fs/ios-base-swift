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
    
    public func fs_getRowHeight (_ font: UIFont) -> CGFloat {
        return self.fs_getStringHeight(font, width: CGFloat.greatestFiniteMagnitude)
    }
    
    public func fs_getLineCount (_ font: UIFont) -> Int {
        let rowHeight = self.fs_getRowHeight(font)
        return Int(ceil(rowHeight / font.lineHeight))
    }
    
    public func fs_URLEncodedString () -> String? {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)
    }
    
    public func fs_URLDecodedString () -> String? {
        return self.removingPercentEncoding
    }
    
    public func fs_emailValidate () -> Bool {
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let regExPredicate:NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        return regExPredicate.evaluate(with: self.lowercased())
    }
    
    public func fs_getStringWidth (_ font: UIFont, height: CGFloat) -> CGFloat {
        
        let boundingSize:CGSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        
        let attributes = [NSAttributedStringKey.font:font]
        
        let options : NSStringDrawingOptions = unsafeBitCast(
            NSStringDrawingOptions.usesLineFragmentOrigin.rawValue |
                NSStringDrawingOptions.usesFontLeading.rawValue,
            to: NSStringDrawingOptions.self)
        
        let text = self as NSString
        
        let rect = text.boundingRect(with: boundingSize, options:options, attributes: attributes, context:nil)
        
        return ceil(rect.size.width)
    }
    
    public func fs_getStringHeight (_ font: UIFont, width: CGFloat) -> CGFloat {
        
        let boundingSize:CGSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let attributes = [NSAttributedStringKey.font:font]
        
        let options : NSStringDrawingOptions = unsafeBitCast(
            NSStringDrawingOptions.usesLineFragmentOrigin.rawValue |
                NSStringDrawingOptions.usesFontLeading.rawValue,
            to: NSStringDrawingOptions.self)
        
        let text = self as NSString
        
        let rect = text.boundingRect(with: boundingSize, options:options, attributes: attributes, context:nil)
        
        return ceil(rect.size.height)
    }
    
    public func fs_getStringBetweenString (_ firstString: String, secondString: String) -> String? {
        var string = self
        
        guard let lFirstRange = self.range(of: firstString) else {return nil}
        string.removeFirst(lFirstRange.upperBound.encodedOffset)
        
        guard let lSecondRange = string.range(of: secondString) else {return nil}
        string.removeSubrange(lSecondRange.lowerBound...)
        
        return string
    }
    
    public func fs_trim() -> String{
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    public func fs_toURL() -> URL? {
        return URL(string: self)
    }
    
    public func fs_prefix(count: Int) -> String {
        return ((self.count > count) ? String(self[..<self.index(self.startIndex, offsetBy: count)]) : self)
    }
    
    public func fs_suffix(from index: Int) -> String {
        return ((self.count > index) ? String(self[self.index(self.startIndex, offsetBy: index)...]) : "")
    }
    
    public var fs_localizedString: String {
        let localized = NSLocalizedString(self.fs_localizedStringFormat, comment: "")
        return localized
    }
    
    internal var fs_localizedStringFormat: String {
        
        let uppercase = self.uppercased()
        let formatted = uppercase.replacingOccurrences(of: " ", with: "_", options: .literal, range: nil)
        
        return formatted
    }
    
    public subscript (i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }
    
    public subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
}
