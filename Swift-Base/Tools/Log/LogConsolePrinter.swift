//
//  LogConsolePrinter.swift
//  Tools
//
//  Created by Almaz Ibragimov on 15/04/2020.
//  Copyright © 2020 Flatstack. All rights reserved.
//

import Foundation

public class LogConsolePrinter: LogPrinter {

    // MARK: - Type Properties

    public static let shared = LogConsolePrinter()

    // MARK: - Initializers

    private init() { }

    // MARK: - LogPrinter

    public func print(_ line: String) {
        Swift.print(line)
    }
}
