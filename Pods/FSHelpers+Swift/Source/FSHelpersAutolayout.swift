//
//  FSHelpersAutolayout.swift
//  FSHelpers
//
//  Created by Sergey Nikolaev on 04.01.16.
//  Copyright © 2016 FlatStack. All rights reserved.
//

import UIKit

@available(*, deprecated, message: "Deprecated. Use NSLayoutDimension")
public enum FSConstraint {
    
    public static func Visual (
        _ format  : String,
        options : NSLayoutFormatOptions = NSLayoutFormatOptions(),
        metrics : [String : Any]? = nil,
        views   : [String : Any]) -> [NSLayoutConstraint]
    {
        let constraints = NSLayoutConstraint.constraints(withVisualFormat: format, options: options, metrics: metrics, views: views)
        return constraints
    }
    
    public static func Edges (_ view: UIView, edges: UIEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)) -> [NSLayoutConstraint] {
        
        let dict   : [String : Any] = ["view": view]
        let metrics: [String : Any] = ["LEFT": edges.left, "TOP": edges.top, "RIGHT": edges.right, "BOTTOM": edges.bottom]
        
        var constraints:[NSLayoutConstraint] = []
        
        constraints += Visual("H:|-LEFT-[view]-RIGHT-|", options: [], metrics: metrics, views: dict)
        constraints += Visual("V:|-TOP-[view]-BOTTOM-|", options: [], metrics: metrics, views: dict)
        
        return constraints
    }
    
    public static func Size (_ view:UIView, size:CGSize) -> [NSLayoutConstraint] {
        let dict   : [String : Any] = ["view" : view]
        let metrics: [String : Any] = ["WIDTH" : size.width, "HEIGHT" : size.height]
        
        var constraints:[NSLayoutConstraint] = []
        
        constraints += Visual("H:[view(WIDTH)]", options: [], metrics: metrics, views: dict)
        constraints += Visual("V:[view(HEIGHT)]", options: [], metrics: metrics, views: dict)
        
        return constraints
    }
    
    public static func Center (_ view: UIView, centerOffset: CGPoint = CGPoint.zero) -> [NSLayoutConstraint] {
        return [
            NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: view.superview!, attribute: .centerX, multiplier: 1, constant: centerOffset.x),
            NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: view.superview!, attribute: .centerY, multiplier: 1, constant: centerOffset.y)
        ]
    }
    
    public static func CenterY (_ view: UIView, offset: CGFloat = 0) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: view.superview, attribute: .centerY, multiplier: 1, constant: offset)
    }
    
    public static func CenterX (_ view: UIView, offset: CGFloat = 0) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: view.superview, attribute: .centerX, multiplier: 1, constant: offset)
    }
    
    public static func ProportionalWidth (_ firstView: UIView, secondView: UIView, multipler: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: firstView, attribute: .width, relatedBy: .equal, toItem: secondView, attribute: .width, multiplier: multipler, constant: constant)
    }
    
    public static func ProportionalHeight (_ firstView: UIView, secondView: UIView, multipler: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: firstView, attribute: .height, relatedBy: .equal, toItem: secondView, attribute: .height, multiplier: multipler, constant: constant)
    }
    
    public static func ProportionalHeightToWidth (_ firstView: UIView, secondView: UIView, multipler: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: firstView, attribute: .height, relatedBy: .equal, toItem: secondView, attribute: .width, multiplier: multipler, constant: constant)
    }
    
    public static func ProportionalWidthToHeight (_ firstView: UIView, secondView: UIView, multipler: CGFloat, constant: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: firstView, attribute: .width, relatedBy: .equal, toItem: secondView, attribute: .height, multiplier: multipler, constant: constant)
    }
    
}
