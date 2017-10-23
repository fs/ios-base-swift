//
//  FSE+NSObject.swift
//  FSHelpers
//
//  Created by Sergey Nikolaev on 04.05.16.
//  Copyright © 2016 FlatStack. All rights reserved.
//

import Foundation

public extension NSObject {
    
    public class var fs_className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    public var fs_className: String {
        return type(of: self).fs_className
    }
}
