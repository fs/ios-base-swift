//
//  DefaultAuthorizationService.swift
//  Swift-Base
//
//  Created by Анастасия Леонтьева on 20/05/2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation
import Apollo
import Combine

@available(iOS 13.0, *)
final class DefaultAuthorizationService: AuthorizationService {

    // MARK: - Instance Properties

    var apiClient: GraphQLAPIClient = DefaultGraphQLAPIClient.shared
    var refreshTokenApiClient = UpdateTokenGraphQLAPIClient.shared
    var accessManager: AccessManager = DefaultManagersModule().accessManager

    // MARK: - Instance Methods

    func refreshToken() -> AnyPublisher<String, Error>? {
        return nil
    }

    func signOut() {
        self.accessManager.resetAccess()
    }
}
