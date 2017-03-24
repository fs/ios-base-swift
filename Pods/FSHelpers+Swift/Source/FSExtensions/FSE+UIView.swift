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
        set (value) {self.fs_size = CGSize(width: value, height: frame.size.height)}
        get         {return self.frame.size.width}
    }
    
    var fs_height:CGFloat {
        set (value) {self.fs_size = CGSize(width: frame.size.width, height: value)}
        get         {return self.frame.size.height}
    }
    
    //MARK: - Set origin
    
    var fs_origin: CGPoint {
        set (value) {self.frame.origin = value}
        get         {return self.frame.origin}
    }
    
    var fs_x: CGFloat {
        set (value) {self.fs_origin = CGPoint(x: value, y: frame.origin.y)}
        get         {return self.frame.origin.x}
    }
    
    var fs_y: CGFloat {
        set (value) {self.fs_origin = CGPoint(x: frame.origin.x, y: value)}
        get         {return self.frame.origin.y}
    }
    
    //MARK: - Other
    
    func fs_findAndResignFirstResponder () -> Bool {
        if self.isFirstResponder {
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

//MARK: - Extensions for Storyboard
public extension UIView {
    
    @IBInspectable var fs_cornerRadius: CGFloat {
        set(newValue) { self.layer.cornerRadius = newValue }
        get { return self.layer.cornerRadius }
    }
    
    @IBInspectable var fs_borderColor: UIColor {
        set(newValue) { self.layer.borderColor = newValue.cgColor }
        get { return UIColor(cgColor: self.layer.borderColor!) }
    }
    
    @IBInspectable var fs_borderWidth: CGFloat {
        set(newValue) { self.layer.borderWidth = newValue }
        get { return self.layer.borderWidth }
    }
    
    @IBInspectable var fs_shadowColor: UIColor {
        set(newValue) { self.layer.shadowColor = newValue.cgColor }
        get { return UIColor(cgColor: self.layer.shadowColor!) }
    }
    
    @IBInspectable var fs_shadowOffset: CGSize {
        set(newValue) { self.layer.shadowOffset = newValue }
        get { return  self.layer.shadowOffset}
    }
    
    @IBInspectable var fs_shadowOpacity: Float {
        set(newValue) { self.layer.shadowOpacity = newValue }
        get { return  self.layer.shadowOpacity}
    }
    
    @IBInspectable var fs_shadowRadius: CGFloat {
        set(newValue) { self.layer.shadowRadius = newValue }
        get { return  self.layer.shadowRadius}
    }
    
    @IBInspectable var fs_masksToBounds: Bool {
        set(newValue) { self.layer.masksToBounds = newValue }
        get { return self.layer.masksToBounds }
    }
}

//MARK: - Collection View Animated Reload
public extension UICollectionView {
    
    /**
     - parameter options: UIViewAnimationOptionTransition's only available
     */
    func fs_reloadDataWithAnimation(_ duration: TimeInterval = 0.2, options: UIViewAnimationOptions, completion: ((Bool) -> Void)?) {
        
        UIView.transition(with: self,
            duration: duration,
            options: options,
            animations: { [weak self] () -> Void in
                self?.reloadData()
            },
            completion: completion)
    }
}

//MARK: - Table View Animated Reload
public extension UITableView {
    
    /**
     - parameter options: UIViewAnimationOptionTransition's only available
     */
    func fs_reloadDataWithAnimation(_ duration: TimeInterval = 0.2, options: UIViewAnimationOptions, completion: ((Bool) -> Void)?) {
        
        UIView.transition(with: self,
            duration: duration,
            options: options,
            animations: { [weak self] () -> Void in
                self?.reloadData()
            },
            completion: completion)
    }
}
