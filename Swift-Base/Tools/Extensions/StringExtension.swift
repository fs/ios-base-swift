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
    
    func isValidEmail() -> Bool {
        let emailRegEx = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
        "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
        "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
        "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
        "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
        "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
        "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"

        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
