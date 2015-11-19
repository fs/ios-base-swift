//
//  FSExtensions+UIView.swift
//  SwiftHelpers
//
//  Created by Kruperfone on 31.07.15.
//  Copyright (c) 2015 FlatStack. All rights reserved.
//

import UIKit

public extension UIView {
    
    //MARK: - Set size
    
    var fs_size: CGSize {
        set (value) {self.frame.size = value}
        get         {return self.frame.size}
    }
    
    var fs_width:CGFloat {
        set (value) {self.fs_size = CGSizeMake(value, frame.size.height)}
        get         {return self.frame.size.width}
    }
    
    var fs_height:CGFloat {
        set (value) {self.fs_size = CGSizeMake(frame.size.width, value)}
        get         {return self.frame.size.height}
    }
    
    //MARK: - Set origin
    
    var fs_origin: CGPoint {
        set (value) {self.frame.origin = value}
        get         {return self.frame.origin}
    }
    
    var fs_x: CGFloat {
        set (value) {self.fs_origin = CGPointMake(value, frame.origin.y)}
        get         {return self.frame.origin.x}
    }
    
    var fs_y: CGFloat {
        set (value) {self.fs_origin = CGPointMake(frame.origin.x, value)}
        get         {return self.frame.origin.y}
    }
    
    //MARK: - Other
    
    func fs_findAndResignFirstResponder () -> Bool {
        if self.isFirstResponder() {
            self.resignFirstResponder()
            return true
        }
        
        for view in subviews {
            if view.fs_findAndResignFirstResponder() {
                return true
            }
        }
        
        return false
    }
    
    var fs_allSubviews: [UIView] {
        var arr:[UIView] = [self]
        
        for view in subviews {
            arr += view.fs_allSubviews
        }
        
        return arr
    }
}
