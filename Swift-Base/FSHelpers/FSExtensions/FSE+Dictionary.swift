//
//  FSExtensions+Dictionary.swift
//  SwiftHelpers
//
//  Created by Kruperfone on 31.07.15.
//  Copyright (c) 2015 FlatStack. All rights reserved.
//

import Foundation

extension Dictionary {
    
    func objectForKey(key:String, orDefault def:AnyObject) -> Value {
        let res = key as! Key
        
        if self[res] != nil {
            return self[res]!
        } else {
            return def as! Value
        }
    }
}
