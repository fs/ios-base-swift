//
//  APIManagerError.swift
//  Swift-Base
//
//  Created by Kruperfone on 19.11.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import Foundation

enum APIManagerError: Int {
    
    case cancelled = 0
    case deviceTokenIsMissing
    case notImplemented
    
    //---------------//
    static let domain: String = "com.apimanager"
    
    init? (error: NSError) {
        guard error.domain == APIManagerError.domain else {return nil}
        guard let code = APIManagerError(rawValue: error.code) else {return nil}
        self = code
    }
    
    var localizedDescription: String {
        
        switch self {
        case cancelled:
            return "\(self.rawValue): Request was cancelled"
            
        case notImplemented:
            return "\(self.rawValue): This feature is not implemented yet"
            
        default:
            return "\(self.rawValue): Something went wrong. Please try again later"
        }
    }
    
    var failureReason: String {
        switch self {
            
        case cancelled:
            return "Operation was cancelled"
            
        case deviceTokenIsMissing:
            return "Device token is missing"
            
        case notImplemented:
            return "The feature is not implemented"
        }
    }
    
    func generateError (userInfo: [NSObject : AnyObject]? = nil) -> NSError {
        
        var info: [NSObject : AnyObject] = [:]
        if let lUserInfo = userInfo {
            info += lUserInfo
        }
        
        info.updateValue(self.localizedDescription, forKey: NSLocalizedDescriptionKey)
        info.updateValue(self.failureReason, forKey: NSLocalizedFailureReasonErrorKey)
        
        let error = NSError(domain: APIManagerError.domain, code: self.rawValue, userInfo: info)
        return error
    }
}
