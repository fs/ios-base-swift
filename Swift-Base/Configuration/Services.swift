//
//  Services.swift
//  Swift-Base
//
//  Created by Elina Batyrova on 28/03/2019.
//  Copyright © 2019 Flatstack. All rights reserved.
//

import Foundation

@available(iOS 13.0, *)
enum Services {

    // MARK: - Type Properties

    static func authorizationService() -> AuthorizationService {
        return DefaultAuthorizationService()
    }

    static func currentUserService() -> CurrentUserService {
        return DefaultCurrentUserService(apiClient: DefaultGraphQLAPIClient.shared,
                                         currentUserCacheManager: Cache().currentUserCacheManager,
                                         userCacheManager: Cache().userCacheManager)
    }
}
