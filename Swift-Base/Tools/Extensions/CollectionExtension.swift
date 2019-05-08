//
//  CollectionExtension.swift
//  Tools
//
//  Created by Almaz Ibragimov on 26.05.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation

public extension Collection {

    // MARK: - Instance Methods

    func split(maxSplits: Int, by predicate: (Element, Element) throws -> Bool) rethrows -> [SubSequence] {
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

    func split(by predicate: (Element, Element) throws -> Bool) rethrows -> [SubSequence] {
        return try self.split(maxSplits: self.count, by: predicate)
    }
}
