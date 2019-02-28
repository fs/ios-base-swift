//
//  Helpers.swift
//  Swift-Base
//
//  Created by Kruperfone on 19.11.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import Foundation

// MARK: - Logs
// swiftlint:disable:next identifier_name
public func Log(_ error: Error) {
    Log(error.localizedDescription)
}
// swiftlint:disable:next identifier_name
public func Log(_ message: String, function: String = #function, file: String = #file, line: Int = #line) {
    #if DEBUG
    // swiftlint:disable:next force_unwrapping
        let fileName = file.components(separatedBy: "/").last != nil ? "[\(file.components(separatedBy: "/").last!)]" : ""
        print("****\(fileName)[\(function)][\(line)]:\r\(message)\n")
    #endif
}
// MARK: -
//The server time format - 2016-06-07T12:24:35.732Z
var defaultISO8601Formatter: DateFormatter = {
    let dateFormatter = DateFormatter.init()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    return dateFormatter
}()
