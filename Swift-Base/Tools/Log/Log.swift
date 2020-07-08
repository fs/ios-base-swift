//
//  Log.swift
//  ITISService
//
//  Created by Тимур Шафигуллин on 02/11/2018.
//  Copyright © 2018 Timur Shafigullin. All rights reserved.
//

import Foundation

public enum Log {

    // MARK: - Type Properties

    private static let dateFormatter = DateFormatter(dateFormat: Constants.defaultDateFormat)

    // MARK: -

    public private(set) static var printers: [LogPrinter] = [LogConsolePrinter.shared]

    public static var dateFormat: String {
        get { return Log.dateFormatter.dateFormat }
        set { Log.dateFormatter.dateFormat = newValue }
    }

    // MARK: - Type Methods

    @inline(__always)
    private static func print(
        layer: @autoclosure () -> String,
        text: @autoclosure () -> String,
        sender: @autoclosure () -> Any?,
        date: @autoclosure () -> Date
    ) {
        #if DEBUG || LOGGING
            let body = sender().map { "\(String(describing: type(of: $0))): \(text())" } ?? text()
            let line = "\(dateFormatter.string(from: date())) \(layer()) \(body)"

            for printer in printers {
                printer.print(line)
            }
        #endif
    }

    // MARK: -

    public static func registerPrinter(_ printer: LogPrinter) {
        if !printers.contains(where: { $0 === printer }) {
            printers.append(printer)
        }
    }

    public static func unregisterPrinter(_ printer: LogPrinter) {
        printers.removeAll { $0 === printer }
    }

    public static func low(
        _ text: @autoclosure () -> String,
        from sender: @autoclosure () -> Any? = nil,
        date: @autoclosure () -> Date = Date()
    ) {
        print(layer: Constants.lowLayerLabel, text: text(), sender: sender(), date: date())
    }

    public static func medium(
        _ text: @autoclosure () -> String,
        from sender: @autoclosure () -> Any? = nil,
        date: @autoclosure () -> Date = Date()
    ) {
        print(layer: Constants.mediumLayerLabel, text: text(), sender: sender(), date: date())
    }

    public static func high(
        _ text: @autoclosure () -> String,
        from sender: @autoclosure () -> Any? = nil,
        date: @autoclosure () -> Date = Date()
    ) {
        print(layer: Constants.highLayerLabel, text: text(), sender: sender(), date: date())
    }

    public static func extra(
        _ text: @autoclosure () -> String,
        from sender: @autoclosure () -> Any? = nil,
        date: @autoclosure () -> Date = Date()
    ) {
        print(layer: Constants.extraLayerLabel, text: text(), sender: sender(), date: date())
    }
}

// MARK: -

private enum Constants {

    // MARK: - Type Properties

    static let defaultDateFormat = "[HH:mm:ss.SSSS]"

    static let lowLayerLabel = "<*  >"
    static let mediumLayerLabel = "<** >"
    static let highLayerLabel = "<***>"
    static let extraLayerLabel = "<--->"
}
