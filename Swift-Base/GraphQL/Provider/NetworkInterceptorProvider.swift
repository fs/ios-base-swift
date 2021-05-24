//
//  NetworkInterceptorProvider.swift
//  Swift-Base
//
//  Created by Анастасия Леонтьева on 20/05/2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation
import Apollo

@available(iOS 13.0, *)
class NetworkInterceptorProvider: LegacyInterceptorProvider {

    // MARK: - Insatnce Properties

    private let accessManager: AccessManager
    private let isUpdateToken: Bool

    // MARK: - Initializers

    init(accessManager: AccessManager, store: ApolloStore, isUpdateToken: Bool) {
        self.accessManager = accessManager
        self.isUpdateToken = isUpdateToken

        super.init(store: store)
    }

    // MARK: - InterceptorProvider Methods

    override func interceptors<Operation>(for operation: Operation) -> [ApolloInterceptor] where Operation: GraphQLOperation {
        var interceptors = super.interceptors(for: operation)
        let authorizationInterceptor = AuthorizationInterceptor(accessManager: self.accessManager, isUpdateToken: self.isUpdateToken)
        interceptors.insert(authorizationInterceptor, at: 0)
        let parameterInterceptor = ParameterInterceptor()
        interceptors.append(parameterInterceptor)
        if !self.isUpdateToken {
            let refreshTokenInterceptor = RefreshTokenInterceptor(accessManager: self.accessManager)
            interceptors.append(refreshTokenInterceptor)
        }
        let logInterceptor = LogInterceptor()
        interceptors.append(logInterceptor)

        let errorHandlerInterceptor = ErrorHandlerInterseptor()
        interceptors.append(errorHandlerInterceptor)

        return interceptors
    }
}
