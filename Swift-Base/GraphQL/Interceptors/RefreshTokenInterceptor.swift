//
//  RefreshTokenInterceptor.swift
//  Swift-Base
//
//  Created by Анастасия Леонтьева on 20.05.2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation
import Apollo
import Combine

@available(iOS 13.0, *)
class RefreshTokenInterceptor: ApolloInterceptor {

    // MARK: - Nested Types

    private enum JSONKeys {

        // MARK: - Type Properties

        static let profile = "me"
        static let status = "status"
    }

    // MARK: - Instance Properties

    private let accessManager: AccessManager
    private let authorizationService: AuthorizationService = Services.authorizationService()

    private var refreshTokenSubscriber: Combine.Cancellable?

    // MARK: - Initalizers

    init(accessManager: AccessManager) {
        self.accessManager = accessManager
    }

    // MARK: - Instance Methods

    private func refreshToken<Operation>(chain: RequestChain, request: HTTPRequest<Operation>, response: HTTPResponse<Operation>?, completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) where Operation: GraphQLOperation {
        if !(self.accessManager.refreshToken?.isEmpty ?? true) {
            self.refreshTokenSubscriber = self.authorizationService.refreshToken()?
                .sink { [weak self] completionResult in
                    switch completionResult {
                    case .failure(let error):
                        print(error)
                        chain.handleErrorAsync(error, request: request, response: response, completion: completion)
                        self?.authorizationService.signOut()

                    case .finished:
                        print("FINISHED")
                        break
                    }
                } receiveValue: { accessToken in
                    print(accessToken)
                    request.addHeader(name: "Authorization", value: "Bearer \(accessToken)")
                    chain.retry(request: request, completion: completion)
                }
        } else {
            chain.handleErrorAsync(MyError(title: "Error", message: "Sorry, you email or password is incorrect. Please try again."), request: request, response: response, completion: completion)
        }
    }

    // MARK: - ApolloInterceptor Methods

    func interceptAsync<Operation>(chain: RequestChain, request: HTTPRequest<Operation>, response: HTTPResponse<Operation>?, completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) where Operation: GraphQLOperation {
        if let errors = response?.parsedResponse?.errors {
            for error in errors {
                if let errorCode = error.extensions?[JSONKeys.status] as? Int, errorCode == 401 {
                    self.refreshToken(chain: chain, request: request, response: response, completion: completion)

                    return
                }
            }
        } else if let resultMap = response?.parsedResponse?.data?.resultMap {
            if resultMap.keys.contains(JSONKeys.profile) && !(resultMap[JSONKeys.profile] is ResultMap) {
                self.refreshToken(chain: chain, request: request, response: response, completion: completion)

                return
            }
        }

        chain.proceedAsync(request: request, response: response, completion: completion)
    }
}
