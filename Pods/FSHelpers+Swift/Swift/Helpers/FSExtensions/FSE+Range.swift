//
//  FSE+Range.swift
//  FSHelpers
//
//  Created by Sergey Nikolaev on 04.05.16.
//  Copyright © 2016 FlatStack. All rights reserved.
//

import Foundation

public extension Range where Element: IntegerType {
    
    public func FSGenerateIndexPaths (section: Int) -> [NSIndexPath] {
        guard let start = self.startIndex as? Int else {return []}
        guard let end = self.endIndex as? Int else {return []}
        
        var indexPaths: [NSIndexPath] = []
        for i in start ..< end {
            indexPaths.append(NSIndexPath(forRow: i, inSection: section))
        }
        
        return indexPaths
    }
}
