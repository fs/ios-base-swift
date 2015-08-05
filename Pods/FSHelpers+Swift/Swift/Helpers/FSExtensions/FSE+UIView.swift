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
    
    func setSize (size:CGSize) {
        var frame = self.frame
        frame.size = size
        self.frame = frame
    }
    
    var width:CGFloat {
        
        set (value) {
            self.setSize(CGSizeMake(value, frame.size.height))
        }
        
        get {
            return self.frame.size.width
        }
    }
    
    var height:CGFloat {
        
        set (value) {
            self.setSize(CGSizeMake(frame.size.width, height))
        }
        
        get {
            return self.frame.size.height
        }
    }
    
    //MARK: - Set origin
    
    func setOrigin (origin:CGPoint) {
        var frame = self.frame
        frame.origin = origin
        self.frame = frame
    }
    
    var x:CGFloat {
        
        set (value) {
            self.setOrigin(CGPointMake(value, frame.origin.y))
        }
        
        get {
            return self.frame.origin.x
        }
    }
    
    var y:CGFloat {
        
        set (value) {
            setOrigin(CGPointMake(frame.origin.x, value))
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
            if findAndResignFirstResponder() {
                return true
            }
        }
        
        return false
    }
    
    var allSubviews:[UIView] {
        var arr:[UIView] = [self]
        
        for view in subviews {
            arr += view.allSubviews
        }
        
        return arr
    }
}
