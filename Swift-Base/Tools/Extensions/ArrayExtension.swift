//
//  ArrayExtension.swift
//  Tools
//
//  Created by Almaz Ibragimov on 01.01.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation

public extension Array {

    // MARK: - Intance Methods

    mutating func removeFirst(where predicate: ((Element) -> Bool)) -> Element? {
        guard let index = self.firstIndex(where: predicate) else {
            return nil
        }

        return self.remove(at: index)
    }

    mutating func prepend(_ element: Element) {
        self.insert(element, at: 0)
    }
}

// MARK: - Array<AnyObject>

public extension Array where Element: AnyObject {

    // MARK: - Instance Methods

    @discardableResult
    mutating func remove(object: Element) -> Element? {
        guard let index = self.firstIndex(where: { $0 === object }) else {
            return nil
        }

        return self.remove(at: index)
    }

    func contains(object: Element) -> Bool {
        return self.contains(where: { $0 === object })
    }
}
