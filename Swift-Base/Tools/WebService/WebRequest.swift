//
//  WebRequest.swift
//  Tools
//
//  Created by Almaz Ibragimov on 08.03.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation

public struct WebRequest {

    // MARK: - Instance Properties

    public var method: WebMethod
    public var path: String

    public var parameters: [String: Any]
    public var headers: [String: String]

    public var encoding: WebRequestEncoding

    // MARK: -

    public var logDescription: String {
        return "\(self.method.logDescription) *\(self.path)"
    }

    // MARK: - Initializers

    public init(method: WebMethod, path: String, parameters: [String: Any] = [:], headers: [String: String] = [:], encoding: WebRequestEncoding = .url) {
        self.method = method
        self.path = path

        self.parameters = parameters
        self.headers = headers

        self.encoding = encoding
    }
}
