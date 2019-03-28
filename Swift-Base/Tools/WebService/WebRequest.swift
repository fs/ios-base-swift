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
    public var params: [String: Any]
    public var headers: [String: String]?
    
    // MARK: -
    
    public var logDescription: String {
        return "\(self.method.logDescription) *\(self.path)"
    }
    
    // MARK: - Initializers
    
    public init(method: WebMethod, path: String, params: [String: Any] = [:], headers: [String: String]? = nil) {
        self.method = method
        self.path = path
        self.params = params
        self.headers = headers
    }
}
