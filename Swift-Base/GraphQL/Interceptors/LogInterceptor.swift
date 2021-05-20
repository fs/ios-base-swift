//
//  LogInterceptor.swift
//  Swift-Base
//
//  Created by Анастасия Леонтьева on 20/05/2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation
import Apollo

class LogInterceptor: ApolloInterceptor {

    // MARK: - ApolloInterceptor Methods

    func interceptAsync<Operation>(chain: RequestChain, request: HTTPRequest<Operation>, response: HTTPResponse<Operation>?, completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) where Operation: GraphQLOperation {
        Log.i(request)

        if let response = response {
            if let parsedResponseData = response.parsedResponse?.data {
                Log.i(parsedResponseData)
            } else {
                Log.e("No response data")
            }
        } else {
            Log.e("No response")
        }

        chain.proceedAsync(request: request, response: response, completion: completion)
    }
}
