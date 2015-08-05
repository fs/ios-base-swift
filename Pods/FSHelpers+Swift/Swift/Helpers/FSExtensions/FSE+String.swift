//
//  FSExtensions+String.swift
//  SwiftHelpers
//
//  Created by Kruperfone on 31.07.15.
//  Copyright (c) 2015 FlatStack. All rights reserved.
//

import UIKit

extension String {
    
    func getRowHeight (font:UIFont) -> CGFloat {
        return self.getStringHeight(font, width: CGFloat.max)
    }
    
    func getLineCount (font:UIFont, size:CGSize) -> Int {
        let rowHeight = self.getRowHeight(font)
        return Int(ceil(rowHeight / font.lineHeight))
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
