//
//  Helpers.swift
//  Swift-Base
//
//  Created by Kruperfone on 19.11.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import Foundation

//MARK: - Logs
public func Log(_ error: Error) {
    Log(error.localizedDescription)
}

public func Log(_ message: String, function: String = #function, file: String = #file, line: Int = #line) {
    #if DEBUG
        let fileName = file.components(separatedBy: "/").last != nil ? "[\(file.components(separatedBy: "/").last!)]" : ""
        print("****\(fileName)[\(function)][\(line)]:\r\(message)\n")
    #endif
}
