//
//  FSExtensions+UIView.swift
//  SwiftHelpers
//
//  Created by Kruperfone on 31.07.15.
//  Copyright (c) 2015 FlatStack. All rights reserved.
//

import UIKit

extension UIView {
    
    //MARK: - Set size
    
    var size: CGSize {
        set (value) {
            self.frame.size = size
        }
        
        get {
            return self.frame.size
        }
    }
    
    var width:CGFloat {
        
        set (value) {
            self.size = CGSizeMake(value, frame.size.height)
        }
        
        get {
            return self.frame.size.width
        }
    }
    
    var height:CGFloat {
        
        set (value) {
            self.size = CGSizeMake(frame.size.width, value)
        }
        
        get {
            return self.frame.size.height
        }
    }
    
    //MARK: - Set origin
    
    var origin: CGPoint {
        set (value) {
            self.frame.origin = value
        }
        get {
            return self.frame.origin
        }
    }
    
    var x: CGFloat {
        
        set (value) {
            self.origin = CGPointMake(value, frame.origin.y)
        }
        
        get {
            return self.frame.origin.x
        }
    }
    
    var y: CGFloat {
        
        set (value) {
            self.origin = CGPointMake(frame.origin.x, value)
        }
        
        get {
            return self.frame.origin.y
        }
    }
    
    //MARK: - Other
    
    func findAndResignFirstResponder () -> Bool {
        if self.isFirstResponder() {
            self.resignFirstResponder()
            return true
        }
        
        for view in subviews {
            if view.findAndResignFirstResponder() {
                return true
            }
        }
        
        return false
    }
    
    var allSubviews: [UIView] {
        var arr:[UIView] = [self]
        
        for view in subviews {
            arr += view.allSubviews
        }
        
        return arr
    }
}
