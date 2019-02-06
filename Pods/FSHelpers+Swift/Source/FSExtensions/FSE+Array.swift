//
//  FSExtensions+Array.swift
//  SwiftHelpers
//
//  Created by Kruperfone on 31.07.15.
//  Copyright (c) 2015 FlatStack. All rights reserved.
//

import Foundation

public extension Array {
    
    public mutating func fs_appendIfExist (_ object: Element?) {
        guard let lObject = object else {return}
        self.append(lObject)
    }
    
    public func fs_objectAtIndexOrNil (_ index:Int) -> Element? {
        guard index < self.count && index >= 0 else {return nil}
        return self[index]
    }
    
    public func fs_shuffle () -> Array {
        var array:Array = self
        
        for i in 0 ..< array.count {
            let remainingCount = array.count - i
            let exchangeIndex = i + Int(arc4random_uniform(UInt32(remainingCount)))
            
            guard i != exchangeIndex else {continue}
            array.swapAt(i, exchangeIndex)
        }
        
        return array
    }
    
    public mutating func fs_removeFirst(where predicate: ((Element) -> Bool)) -> Element? {
        guard let index = self.index(where: predicate) else {
            return nil
        }
        
        return self.remove(at: index)
    }
    
    public mutating func fs_prepend(_ element: Element) {
        self.insert(element, at: 0)
    }
}

public extension Array where Element: AnyObject {
    
    // MARK: - Instance Methods
    
    @discardableResult
    public mutating func fs_remove(object: Element) -> Element? {
        guard let index = self.index(where: { $0 === object }) else {
            return nil
        }
        
        return self.remove(at: index)
    }
    
    public func fs_contains(object: Element) -> Bool {
        return self.contains(where: { $0 === object })
    }
}

public func + <ValueType> (left: Array<ValueType>, right: Array<ValueType>) -> Array<ValueType> {
    var result: Array<ValueType> = left
    for value in right {
        result.append(value)
    }
    return result
}

public func += <ValueType> (left: inout Array<ValueType>, right: Array<ValueType>) {
    for value in right {
        left.append(value)
    }
}
