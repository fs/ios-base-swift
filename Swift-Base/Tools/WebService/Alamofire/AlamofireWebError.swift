//
//  AlamofireWebError.swift
//  Tools
//
//  Created by Almaz Ibragimov on 08.03.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation
import Alamofire

extension AFError: WebErrorBase {
    
    // MARK: - Instance Properties
    
    public var logDescription: String {
        return "AFError: \(self)"
    }
}

// MARK: -

public final class AlamofireWebError: WebError {
    
    // MARK: - Initializers
    
    public convenience init(fromAFError error: AFError, data: Any?) {
        switch error {
        case .invalidURL:
            self.init(code: .badRequest, base: error, data: data)
            
        case .parameterEncodingFailed:
            self.init(code: .badRequest, base: error, data: data)
            
        case .multipartEncodingFailed:
            self.init(code: .badRequest, base: error, data: data)
            
        case .responseValidationFailed:
            self.init(code: .badResponse, base: error, data: data)
            
        case .responseSerializationFailed:
            self.init(code: .badResponse, base: error, data: data)
        }
    }
}
