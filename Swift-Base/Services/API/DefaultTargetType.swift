//
//  DefaultTargetType.swift
//  Swift-Base
//
//  Created by Elina Batyrova on 29/03/2019.
//  Copyright © 2019 Flatstack. All rights reserved.
//

import Moya

protocol DefaultTargetType: TargetType {}

// MARK: -

extension DefaultTargetType {

    // MARK: - Instance Properties

    var baseURL: URL {
        guard let apiServerURLString = Bundle.main.infoDictionary?["URL_HOST"] as? String else {
            fatalError("URL_HOST IS NOT DEFINED")
        }

        guard let baseURL = URL(string: apiServerURLString) else {
            fatalError()
        }

        return baseURL
    }

    var sampleData: Data {
        return Data()
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
