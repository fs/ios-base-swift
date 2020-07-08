//
//  LogFilePrinter.swift
//  Tools
//
//  Created by Almaz Ibragimov on 15/04/2020.
//  Copyright © 2020 Flatstack. All rights reserved.
//

import Foundation

public class LogFilePrinter: LogPrinter {

    // MARK: - Instance Properties

    private var headerContent: String {
        self.fileHeader.isEmpty ? .empty : "\(self.fileHeader)\n"
    }

    // MARK: -

    public let encoding: String.Encoding

    public let fileHeader: String
    public let fileName: String
    public let filePath: String

    public var content: String? {
        try? String(contentsOfFile: self.filePath, encoding: self.encoding)
    }

    // MARK: - Initializers

    public init?(encoding: String.Encoding = .utf8, fileHeader: String = "", fileName: String) {
        let fileManager = FileManager.default

        guard let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }

        self.encoding = encoding

        self.fileHeader = fileHeader
        self.fileName = fileName
        self.filePath = documentURL.appendingPathComponent(fileName).path

        do {
            try fileManager.createDirectory(
                at: documentURL,
                withIntermediateDirectories: true,
                attributes: nil
            )

            var isDirectory: ObjCBool = false

            if fileManager.fileExists(atPath: filePath, isDirectory: &isDirectory), isDirectory.boolValue {
                return nil
            }

            try clear()
        } catch {
            return nil
        }
    }

    // MARK: - LogPrinter

    public func print(_ line: String) {
        try? "\(content ?? headerContent)\(line)\n".write(toFile: filePath, atomically: true, encoding: encoding)
    }

    // MARK: - Instance Methods

    public func clear() throws {
        try headerContent.write(toFile: filePath, atomically: true, encoding: encoding)
    }
}
