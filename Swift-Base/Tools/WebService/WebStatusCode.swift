//
//  WebStatusCode.swift
//  Tools
//
//  Created by Almaz Ibragimov on 08.03.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation

public struct WebStatusCode: WebErrorBase {

    // MARK: - Instance Properties

    public var rawValue: Int

    // MARK: - WebErrorBase

    public var logDescription: String {
        return "WebStatusCode: \(self.rawValue)"
    }
}
