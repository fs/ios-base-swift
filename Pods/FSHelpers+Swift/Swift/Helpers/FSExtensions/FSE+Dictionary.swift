//
//  FSExtensions+Dictionary.swift
//  SwiftHelpers
//
//  Created by Kruperfone on 31.07.15.
//  Copyright (c) 2015 FlatStack. All rights reserved.
//

import Foundation

public extension Dictionary {
    
    public mutating func fs_updateIfExist (object: Value?, forKey key: Key) {
        guard let lObject = object else {return}
        self.updateValue(lObject, forKey: key)
    }
    
    public func fs_objectForKey(key:Key, orDefault def:Value) -> Value {
        guard let value = self[key] else {return def}
        return value
    }
    
}

public func + <KeyType, ValueType> (left: Dictionary<KeyType, ValueType>, right: Dictionary<KeyType, ValueType>) -> Dictionary<KeyType, ValueType> {
    var result: Dictionary<KeyType, ValueType> = left
    for (k, v) in right {
        result.updateValue(v, forKey: k)
    }
    return result
}

public func += <KeyType, ValueType> (inout left: Dictionary<KeyType, ValueType>, right: Dictionary<KeyType, ValueType>) {
    for (k, v) in right {
        left.updateValue(v, forKey: k)
    }
}
