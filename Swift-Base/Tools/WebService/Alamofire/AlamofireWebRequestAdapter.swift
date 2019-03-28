//
//  AlamofireWebRequestAdapter.swift
//  Tools
//
//  Created by Almaz Ibragimov on 09.03.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation
import Alamofire

struct AlamofireWebRequestAdapter: RequestAdapter {
    
    // MARK: - Instance Properties
    
    let adapter: WebRequestAdapter
    
    // MARK: - Instance Methods
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        return try self.adapter.adapt(urlRequest)
    }
}
