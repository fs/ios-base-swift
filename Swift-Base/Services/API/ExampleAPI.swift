//
//  ExampleAPI.swift
//  Swift-Base
//
//  Created by Elina Batyrova on 29.03.2019.
//  Copyright © 2019 Flatstack. All rights reserved.
//

import Moya

enum ExampleAPI {
    
    // MARK: - Enumeration Cases
    
    case exampleFetch(phoneNumber: String, code: String)
}

// MARK: - TargetType

extension ExampleAPI: DefaultTargetType {
    
    // MARK: - Instance Properties
    
    var path: String {
        return "/YOUR_PATH"
    }
    
    var method: Method {
        return .post
    }
    
    var task: Task {
        switch self {
        case .exampleFetch(let phoneNumber, let code):
            return .requestParameters(parameters: ["code": code,
                                                   "phone": phoneNumber],
                                      encoding: JSONEncoding.default)
        }
    }
}
