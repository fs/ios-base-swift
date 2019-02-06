//
//  FSE+Collection.swift
//  FSHelpers
//
//  Created by Timur Shafigullin on 05/01/2019.
//  Copyright © 2019 FlatStack. All rights reserved.
//

import Foundation

public extension Collection {
    
    public func fs_split(maxSplits: Int, by predicate: (Element, Element) throws -> Bool) rethrows -> [SubSequence] {
        var subSequences: [SubSequence] = []
        
        var elementIndex = self.startIndex
        
        while (elementIndex < self.endIndex) && (subSequences.count < maxSplits) {
            let firstElement = self[elementIndex]
            
            var nextElementIndex = self.index(after: elementIndex)
            
            while nextElementIndex < self.endIndex {
                let nextElement = self[nextElementIndex]
                
                if !(try predicate(firstElement, nextElement)) {
                    break
                }
                
                nextElementIndex = self.index(after: nextElementIndex)
            }
            
            subSequences.append(self[elementIndex..<nextElementIndex])
            
            elementIndex = nextElementIndex
        }
        
        if elementIndex < self.endIndex {
            subSequences.append(self[elementIndex..<self.endIndex])
        }
        
        return subSequences
    }
    
    public func fs_split(by predicate: (Element, Element) throws -> Bool) rethrows -> [SubSequence] {
        return try self.fs_split(maxSplits: self.count, by: predicate)
    }
}
