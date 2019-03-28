//
//  ExampleRequest.swift
//  Swift-Base
//
//  Created by Elina Batyrova on 28.03.2019.
//  Copyright © 2019 Flatstack. All rights reserved.
//

import Moya

enum ExampleRequest {
    
    // MARK: - Enumeration Cases
    
    case exampleFetch(phoneNumber: String, code: String)
}

// MARK: - TargetType

extension ExampleRequest: TargetType {
    
    // MARK: - Instance Properties
    
    var baseURL: URL {
        return Keys.apiServerBaseURL
    }
    
    var path: String {
        return "/YOUR_PATH"
    }
    
    var method: Method {
        return .post
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .exampleFetch(let phoneNumber, let code):
            return .requestParameters(parameters: ["code": code,
                                                   "phone": phoneNumber],
                                      encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
