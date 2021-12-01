//
//  DefaultCurrentUserService.swift
//  Swift-Base
//
//  Created by Maksim Kapitonov on 12/01/2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation
import Combine
import Apollo

@available(iOS 13.0, *)
final class DefaultCurrentUserService: CurrentUserService {

    // MARK: - Instance Properties

    let apiClient: GraphQLAPIClient
    let currentUserCacheManager: CurrentUserCacheManager
    let userCacheManager: UserCacheManager
    let userDefaultsManager: UserDefaultsManager
    let firebaseAnalyticsService: FirebaseAnalyticsService

    // MARK: -

    private var createDeviceSubscriber: AnyCancellable?

    // MARK: - Initializers

    init(apiClient: GraphQLAPIClient, currentUserCacheManager: CurrentUserCacheManager, userCacheManager: UserCacheManager, userDefaultsManager: UserDefaultsManager, firebaseAnalyticsService: FirebaseAnalyticsService) {
        self.apiClient = apiClient
        self.currentUserCacheManager = currentUserCacheManager
        self.userCacheManager = userCacheManager
        self.userDefaultsManager = userDefaultsManager
        self.firebaseAnalyticsService = firebaseAnalyticsService
    }

    // MARK: - Instance Methods

    func fetchCurrentUser() -> AnyPublisher<CurrentUser, MyError> {
        let fetchCurrentUserProfile = FetchCurrentUserQuery()
        let queue = DispatchQueue(label: "Fetch_CurrentUser_Query", qos: .utility)
        return self.apiClient.fetchPublisher(query: fetchCurrentUserProfile,
                                             cachePolicy: CachePolicy.fetchIgnoringCacheData,
                                             queue: queue,
                                             contextIdentifier: nil)
            .tryMap { result in
                guard let currentUserFragment = result.data?.me?.fragments.currentUserFragment else {
                    self.firebaseAnalyticsService.logEvent(with: AnalyticKeys.CurrentUser.failureFetchingUser)
                    throw MyError(title: "Error", message: "Can't fetch user.")
                }
                let context = Cache.storageModel.viewContext.createPrivateQueueChildContext()
                _ = self.currentUserCacheManager.createOrUpdate(from: currentUserFragment, context: context)
                self.currentUserCacheManager.save(context: context)
                guard let storedUser = self.currentUserCacheManager.currentUser() else {
                    throw MyError(title: "Error", message: "User was not stored")
                }
                self.firebaseAnalyticsService.logEvent(with: AnalyticKeys.CurrentUser.successFetchingUser)
                #warning("Implement registering device")
//                self.registerDevice()
                return storedUser
            }
            .mapError({ error in
                return error as? MyError ?? MyError(title: "Error", message: error.localizedDescription)
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func storedCurrentUser() -> CurrentUser? {
        self.currentUserCacheManager.currentUser()
    }

    func updateUser(input: UpdateUserInput) -> AnyPublisher<CurrentUser, MyError> {
        let updateUserMutation = UpdateUserMutation(input: input)
        let queue = DispatchQueue(label: "Update_User_Mutation", qos: .utility)
        return self.apiClient.performPublisher(mutation: updateUserMutation, queue: queue)
            .tryMap({ result in
                guard let updateData = result.data?.updateUser else {
                    self.firebaseAnalyticsService.logEvent(with: AnalyticKeys.CurrentUser.failureUpdatinUser)
                    throw MyError(title: "Error", message: "Can't update user.")
                }
                let userFragment = updateData.me.fragments.currentUserFragment
                let context = Cache.storageModel.viewContext.createPrivateQueueChildContext()
                _ = self.currentUserCacheManager.createOrUpdate(from: userFragment, context: context)
                self.currentUserCacheManager.save(context: context)
                guard let storedUser = self.currentUserCacheManager.currentUser() else {
                    throw MyError(title: "Error", message: "User was not stored")
                }
                self.firebaseAnalyticsService.logEvent(with: AnalyticKeys.CurrentUser.successUpdatingUser)
                return storedUser
            })
            .mapError({ error in
                return error as? MyError ?? MyError(title: "Error", message: error.localizedDescription)
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
