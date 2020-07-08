//
//  DataExtension.swift
//  Tools
//
//  Created by Almaz Ibragimov on 20.05.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation

public extension Data {

    // MARK: - Instance Properties

    var hexEncoded: String {
        return self.reduce("", { result, byte in
            return result + String(format: "%02hhx", byte)
        })
    }
}
