//
//  WebURLRequestAdapter.swift
//  Tools
//
//  Created by Almaz Ibragimov on 08.03.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation

public protocol WebURLRequestAdapter {

    // MARK: - Instance Methods

    func adapt(urlRequest: URLRequest) throws -> URLRequest
}
