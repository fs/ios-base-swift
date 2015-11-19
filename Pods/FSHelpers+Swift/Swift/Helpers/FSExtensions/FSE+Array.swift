//
//  FSExtensions+Array.swift
//  SwiftHelpers
//
//  Created by Kruperfone on 31.07.15.
//  Copyright (c) 2015 FlatStack. All rights reserved.
//

import Foundation

public extension Array {
    
    public func fs_objectAtIndexOrNil (index:Int) -> Element? {
        guard index < self.count && index >= 0 else {return nil}
        return self[index]
    }
    
    public func fs_shuffle () -> Array {
        var array:Array = self
        
        for i in 0 ..< array.count {
            let remainingCount = array.count - i
            let exchangeIndex = i + Int(arc4random_uniform(UInt32(remainingCount)))
            
            guard i != exchangeIndex else {continue}
            swap(&array[i], &array[exchangeIndex])
        }
        
        return array
    }
}
