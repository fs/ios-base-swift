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

    func fetchCurrentUser() -> AnyPublisher<CurrentUser, Error> {
        let fetchCurrentUserProfile = FetchCurrentUserProfileQuery()
        let queue = DispatchQueue(label: "Fetch_CurrentUser_Query", qos: .utility)
        return self.apiClient.fetchPublisher(query: fetchCurrentUserProfile,
                                             cachePolicy: CachePolicy.fetchIgnoringCacheData,
                                             queue: queue,
                                             contextIdentifier: nil)
            .tryMap { result in
                guard let currentUserFragment = result.data?.me?.fragments.currentUserFragment else {
                    throw VehoError(title: "Error", message: "Can't fetch profile.")
                }
                let context = Cache.storageModel.viewContext.createPrivateQueueChildContext()
                _ = self.currentUserCacheManager.createOrUpdate(from: currentUserFragment, context: context)
                self.currentUserCacheManager.save(context: context)
                guard let storedUser = self.currentUserCacheManager.currentUser() else {
                    throw VehoError(title: "Error", message: "User was not stored")
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

    func updateUser(firstName: String?, lastName: String?) -> AnyPublisher<CurrentUser, Error> {
        let updateUserMutation = UpdateUserMutation(firstName: firstName, lastName: lastName)
        let queue = DispatchQueue(label: "Update_User_Mutation", qos: .utility)
        return self.apiClient.performPublisher(mutation: updateUserMutation, queue: queue)
            .tryMap({ result in
                guard let updateData = result.data?.updateUser else {
                    throw VehoError(title: "Error", message: "User with this email is not exist")
                }
                let userFragment = updateData.fragments.userFragment
                let context = Cache.storageModel.viewContext.createPrivateQueueChildContext()
                _ = self.currentUserCacheManager.createOrUpdate(from: userFragment, context: context)
                self.currentUserCacheManager.save(context: context)
                guard let storedUser = self.currentUserCacheManager.currentUser() else {
                    throw VehoError(title: "Error", message: "User was not stored")
                }

                return storedUser
            })
            .mapError({ error in
                return error
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    func updatePassword(currentPassword: String?, newPassword: String) -> AnyPublisher<Void, Error> {
        let updatePasswordMutation = UpdatePasswordMutation(currentPassword: currentPassword, password: newPassword)
        let queue = DispatchQueue(label: "Update_Password_Mutation", qos: .utility)
        return self.apiClient.performPublisher(mutation: updatePasswordMutation, queue: queue)
            .tryMap({ result in
                return ()
            })
            .mapError({ error in
                return error
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
