//
//  ErrorHandlerInterseptor.swift
//  Swift-Base
//
//  Created by Анастасия Леонтьева on 20/05/2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation
import Apollo

class ErrorHandlerInterseptor: ApolloInterceptor {

    // MARK: - ApolloInterceptor Methods

    func interceptAsync<Operation>(chain: RequestChain,
                                   request: HTTPRequest<Operation>,
                                   response: HTTPResponse<Operation>?,
                                   completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) where Operation: GraphQLOperation {
        if let result = response?.parsedResponse {
            if result.data?.resultMap == nil {
                let error: NSError = {
                    if let errors = result.errors, !errors.isEmpty {
                        return NSError()
                    } else {
                        return NSError()
                    }
                }()
                chain.handleErrorAsync(error,
                                       request: request,
                                       response: response,
                                       completion: completion)
            } else {
                chain.proceedAsync(request: request,
                                   response: response,
                                   completion: completion)
            }
        } else {
            chain.proceedAsync(request: request,
                               response: response,
                               completion: completion)
        }
    }
}
