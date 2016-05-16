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
        return NSStringFromClass(self).componentsSeparatedByString(".").last!
    }
    
    public var fs_className: String {
        return self.dynamicType.fs_className
    }
}
