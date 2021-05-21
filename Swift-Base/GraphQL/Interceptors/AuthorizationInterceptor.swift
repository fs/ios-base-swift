//
//  AuthorizationInterceptor.swift
//  Swift-Base
//
//  Created by Анастасия Леонтьева on 20.05.2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation
import Apollo

class AuthorizationInterceptor: ApolloInterceptor {

    // MARK: - Instance Properties

    private let accessManager: AccessManager
    private let isUpdateToken: Bool

    // MARK: - Initalizers

    init(accessManager: AccessManager, isUpdateToken: Bool) {
        self.accessManager = accessManager
        self.isUpdateToken = isUpdateToken
    }

    // MARK: - ApolloInterceptor Methods

    func interceptAsync<Operation>(chain: RequestChain, request: HTTPRequest<Operation>, response: HTTPResponse<Operation>?, completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) where Operation: GraphQLOperation {
        if self.isUpdateToken {
            if let token = self.accessManager.refreshToken {
                request.addHeader(name: "Authorization", value: "Bearer \(token)")
            }
        } else {
            if let token = self.accessManager.token {
                request.addHeader(name: "Authorization", value: "Bearer \(token)")
            }
        }

        chain.proceedAsync(request: request, response: response, completion: completion)
    }
}

