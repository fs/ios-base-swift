//
//  StringExtension.swift
//  Tools
//
//  Created by Almaz Ibragimov on 01.01.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation

public extension String {

    // MARK: - Type Properties

    static let empty = ""

    // MARK: - Instance Methods

    func localized(tableName: String? = nil, comment: String = "") -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: Bundle.main, value: "", comment: comment)
    }

    // MARK: -

    func prefix(count: Int) -> String {
        return ((self.count > count) ? String(self[..<self.index(self.startIndex, offsetBy: count)]) : self)
    }

    func suffix(from index: Int) -> String {
        return ((self.count > index) ? String(self[self.index(self.startIndex, offsetBy: index)...]) : "")
    }
}
