//
//  WebMethod.swift
//  Tools
//
//  Created by Almaz Ibragimov on 08.03.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation

public enum WebMethod {
    
    // MARK: - Enumeration Cases
    
    case head
    case get
    case delete
    case patch
    case post
    case put
    
    // MARK: - Instance Properties
    
    public var logDescription: String {
        switch self {
        case .head:
            return "HEAD"
            
        case .get:
            return "GET"
            
        case .delete:
            return "DELETE"
        
        case .patch:
            return "PATCH"
            
        case .post:
            return "POST"
            
        case .put:
            return "PUT"
        }
    }
}
