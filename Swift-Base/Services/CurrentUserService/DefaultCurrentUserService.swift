//
//  DefaultCurrentUserService.swift
//  Swift-Base
//
//  Created by Евгений Самарин on 24/05/2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation
import Combine
import Apollo

@available(iOS 13.0, *)
struct DefaultCurrentUserService: CurrentUserService {

    // MARK: - Instance Properties

    let apiClient: GraphQLAPIClient
    let currentUserCacheManager: CurrentUserCacheManager
    let userCacheManager: UserCacheManager

    // MARK: - Instance Methods

    func fetchCurrentUser() -> AnyPublisher<CurrentUser, Error>? {
       return nil
    }

    func storedCurrentUser() -> CurrentUser? {
        self.currentUserCacheManager.currentUser()
    }
}
