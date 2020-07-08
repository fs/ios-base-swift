//
//  WebMultiPartDataItem.swift
//  Tools
//
//  Created by Almaz Ibragimov on 22.03.2018.
//  Copyright © 2018 Flastack. All rights reserved.
//

import Foundation

public struct WebMultiPartDataItem: WebMultiPartItem {

    // MARK: - Instance Properties

    public let data: Data

    public let name: String
    public let fileName: String
    public let mimeType: String

    // MARK: - WebMultiPartItem

    public var stream: InputStream {
        return InputStream(data: self.data)
    }

    public var streamLength: UInt64 {
        return UInt64(self.data.count)
    }

    // MARK: - Initializers

    public init(data: Data, name: String, fileName: String, mimeType: String) {
        self.data = data

        self.name = name
        self.fileName = fileName
        self.mimeType = mimeType
    }
}
