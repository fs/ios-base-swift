//
//  Log.swift
//  Tools
//
//  Created by Almaz Ibragimov on 01.01.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation

public final class Log {

    // MARK: - Type Properties

    fileprivate static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "HH:mm:ss.SSSS"
        
        return dateFormatter
    }()

    public fileprivate(set) static var fileName: String? = nil
    public fileprivate(set) static var filePath: String? = nil

    // MARK: -

    public static var dateFormat: String {
        return Log.dateFormatter.dateFormat
    }
    
    public static var content: String? {
        if let filePath = Log.filePath {
            return try? String(contentsOfFile: filePath, encoding: .utf8)
        }

        return nil
    }

    // MARK: - Type Methods

    fileprivate static func print(layer: String, text: String, sender: Any?, date: Date) {
        let body: String

        if let sender = sender {
            body = "\(String(describing: type(of: sender))): \(text)"
        } else {
            body = text
        }

        let line = "[\(Log.dateFormatter.string(from: date))] \(layer) \(body)"

        Swift.print(line, separator: " ", terminator: "\n")

        if let filePath = Log.filePath {
            var content = try? String(contentsOfFile: filePath, encoding: .utf8)

            if content == nil {
                content = "Log File"
            }

            try? "\(content!)\n\(line)".write(toFile: filePath, atomically: true, encoding: .utf8)
        }
    }

    // MARK: -

    public static func initialize(withDateFormat dateFormat: String, fileName: String? = nil) {
        #if LOGGING
            Log.dateFormatter.dateFormat = dateFormat
            
            Log.fileName = fileName
            Log.filePath = nil

            if let fileName = fileName {
                if let documentURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    Log.filePath = documentURLs.appendingPathComponent(fileName).path

                    if Log.content?.isEmpty ?? true {
                        Log.clear()
                    }
                }
            }
        #endif
    }

    public static func low(_ text: String, from sender: Any?, date: Date = Date()) {
        #if LOGGING
            Log.print(layer: "<*  >", text: text, sender: sender, date: date)
        #endif
    }

    public static func medium(_ text: String, from sender: Any?, date: Date = Date()) {
        #if LOGGING
            Log.print(layer: "<** >", text: text, sender: sender, date: date)
        #endif
    }

    public static func high(_ text: String, from sender: Any?, date: Date = Date()) {
        #if LOGGING
            Log.print(layer: "<***>", text: text, sender: sender, date: date)
        #endif
    }

    public static func extra(_ text: String, from sender: Any?, date: Date = Date()) {
        #if LOGGING
            Log.print(layer: "<--->", text: text, sender: sender, date: date)
        #endif
    }

    public static func clear() {
        #if LOGGING
            if let filePath = Log.filePath {
                try? "Log File".write(toFile: filePath, atomically: true, encoding: .utf8)
            }
        #endif
    }
}
