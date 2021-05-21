//
//  DefaultCurrentUserService.swift
//  Swift-Base
//
//  Created by Евгений Самарин on 21.05.2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation
import Combine
import Apollo

struct DefaultCurrentUserService: CurrentUserService {

    // MARK: - Instance Properties

    let apiClient: GraphQLAPIClient
    let currentUserCacheManager: CurrentUserCacheManager
    let userCacheManager: UserCacheManager

    // MARK: - Instance Methods

    func fetchCurrentUser() -> AnyPublisher<CurrentUser, Error> {
        let fetchCurrentUserProfile = FetchCurrentUserProfileQuery()
        let queue = DispatchQueue(label: "Fetch_CurrentUser_Query", qos: .utility)
        return self.apiClient.fetchPublisher(query: fetchCurrentUserProfile,
                                             cachePolicy: CachePolicy.fetchIgnoringCacheData,
                                             queue: queue,
                                             contextIdentifier: nil)
            .tryMap { result in
                guard let currentUserFragment = result.data?.me?.fragments.currentUserFragment else {
                    throw Error
                }
                let context = Cache.storageModel.viewContext.createPrivateQueueChildContext()
                _ = self.currentUserCacheManager.createOrUpdate(from: currentUserFragment, context: context)
                self.currentUserCacheManager.save(context: context)
                guard let storedUser = self.currentUserCacheManager.currentUser() else {
                    throw Error
                }

                return storedUser
            }
            .mapError({ error in
                return error
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func storedCurrentUser() -> CurrentUser? {
        self.currentUserCacheManager.currentUser()
    }
}
