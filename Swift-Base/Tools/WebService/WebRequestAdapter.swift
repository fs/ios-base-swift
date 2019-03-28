//
//  WebRequestAdapter.swift
//  Tools
//
//  Created by Almaz Ibragimov on 08.03.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation

public protocol WebRequestAdapter {
    
    // MARK: - Instance Methods
    
    func adapt(_ request: URLRequest) throws -> URLRequest
}
