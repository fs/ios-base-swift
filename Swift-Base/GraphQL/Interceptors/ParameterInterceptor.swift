//
//  ParameterInterceptor.swift
//  Swift-Base
//
//  Created by Анастасия Леонтьева on 20.05.2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation
import Apollo

class ParameterInterceptor: ApolloInterceptor {

    // MARK: - Nested Types

    private enum Keys {

        // MARK: - Type Properties

        static let deviceSource = "device_source"
        static let deviceVersion = "device_version"
        static let appVersion = "app_version"
    }

    // MARK: - ApolloInterceptor Methods

    func interceptAsync<Operation>(chain: RequestChain, request: HTTPRequest<Operation>, response: HTTPResponse<Operation>?, completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) where Operation: GraphQLOperation {
        let deviceVersion = UIDevice.current.systemVersion

        var queryItems = [URLQueryItem(name: Keys.deviceSource, value: "iOS"),
                          URLQueryItem(name: Keys.deviceVersion, value: deviceVersion)]

        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            queryItems.append(URLQueryItem(name: Keys.appVersion, value: appVersion))
        }

        let graphQLEndpoint = request.graphQLEndpoint
        var urlComponents = URLComponents(string: graphQLEndpoint.absoluteString)!

        urlComponents.queryItems = queryItems
        request.graphQLEndpoint = urlComponents.url!

        chain.proceedAsync(request: request, response: response, completion: completion)
    }
}
