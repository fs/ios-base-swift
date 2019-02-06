//
//  FSE+Data.swift
//  FSHelpers
//
//  Created by Timur Shafigullin on 05/01/2019.
//  Copyright © 2019 FlatStack. All rights reserved.
//

import Foundation

public extension Data {
    
    public var fs_hexEncoded: String {
        return self.reduce("", { result, byte in
            return result + String(format: "%02hhx", byte)
        })
    }
}
