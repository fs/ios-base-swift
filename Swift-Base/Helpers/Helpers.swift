//
//  Helpers.swift
//  Swift-Base
//
//  Created by Flatstack on 19.11.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import Foundation

//The server time format - 2016-06-07T12:24:35.732Z

var defaultISO8601Formatter: DateFormatter = {
    let dateFormatter = DateFormatter.init()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    return dateFormatter
}()
