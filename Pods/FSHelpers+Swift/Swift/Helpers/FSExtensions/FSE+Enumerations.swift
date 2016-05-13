//
//  FSE+Enumerations.swift
//  FSHelpers
//
//  Created by Sergey Nikolaev on 04.05.16.
//  Copyright © 2016 FlatStack. All rights reserved.
//

import Foundation

// MARK: Raw Representable
public extension RawRepresentable {
    public init?(_ rawValue: RawValue) {
        self.init(rawValue: rawValue)
    }
}

public extension RawRepresentable where Self.RawValue == Int {
    public static var allCases: [Self] {
        var i = -1
        return Array( AnyGenerator{i += 1;return self.init(rawValue: i)})
    }
}
