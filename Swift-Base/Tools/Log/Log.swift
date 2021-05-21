//
//  Log.swift
//  Tools
//
//  Created by Timur Shafigullin on 02/11/2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation

enum LogEvent: String {

    // MARK: - Enumeration cases

    case e = "[‼️]" // error
    case i = "[ℹ️]" // info
    case d = "[💬]" // debug
    case v = "[🔬]" // verbose
    case w = "[⚠️]" // warning
    case s = "[🔥]" // severe
}

// Wrapping Swift.print() within LOGGING flag

func print(_ object: Any) {
    #if LOGGING
        Swift.print(object)
    #endif
}

class Log {

    // MARK: - Type Properties
    
    static var dateFormat = "hh:mm:ss"

    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()

        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current

        return formatter
    }

    // MARK: - Type Methods

    private static var isLoggingEnabled: Bool {
        #if LOGGING
        return true
        #else
        return false
        #endif
    }

    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }

    private class func printLog(_ object: Any?, filename: String, line: Int, column: Int, funcName: String, event: LogEvent) {
        if Log.isLoggingEnabled {
            var body = "\(Date().string) \(event.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName)"

            if let object = object {
                body.append(" -> \(object)")
            }

            print(body)
        }
    }

    // MARK: -
    
    class func e(_ object: Any? = nil, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        Log.printLog(object, filename: filename, line: line, column: column, funcName: funcName, event: .e)
    }
    
    class func d(_ object: Any? = nil, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        Log.printLog(object, filename: filename, line: line, column: column, funcName: funcName, event: .d)
    }

    class func i(_ object: Any? = nil, sender: Any, line: Int = #line, column: Int = #column, funcName: String = #function) {
        Log.printLog(object, filename: "\(String(describing: type(of: sender)))", line: line, column: column, funcName: funcName, event: .i)
    }
    
    class func i(_ object: Any? = nil, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        Log.printLog(object, filename: filename, line: line, column: column, funcName: funcName, event: .i)
    }
    
    class func v(_ object: Any? = nil, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        Log.printLog(object, filename: filename, line: line, column: column, funcName: funcName, event: .v)
    }
    
    class func w(_ object: Any? = nil, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        Log.printLog(object, filename: filename, line: line, column: column, funcName: funcName, event: .w)
    }
    
    class func s(_ object: Any? = nil, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        Log.printLog(object, filename: filename, line: line, column: column, funcName: funcName, event: .s)
    }
}

// MARK: - Date

private extension Date {

    // MARK: - Instance Methods

    var string: String {
        return Log.dateFormatter.string(from: self)
    }
}

private enum Constants {

    // MARK: - Type Properties

    static let defaultDateFormat = "[HH:mm:ss.SSSS]"

    static let lowLayerLabel = "<*  >"
    static let mediumLayerLabel = "<** >"
    static let highLayerLabel = "<***>"
    static let extraLayerLabel = "<--->"
}
