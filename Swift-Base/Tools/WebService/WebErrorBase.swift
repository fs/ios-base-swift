//
//  WebErrorBase.swift
//  Tools
//
//  Created by Almaz Ibragimov on 08.03.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation

public protocol WebErrorBase {

    // MARK: - Instance Properties

    var logDescription: String { get }
}

// MARK: - URLError

extension URLError: WebErrorBase {

    // MARK: - Instance Properties

    public var logDescription: String {
        return "URLError: \(self.code.rawValue)"
    }
}
