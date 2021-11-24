//
//  DefaultUserCacheManager.swift
//  Swift-Base
//
//  Created by Maksim Kapitonov on 24/11/2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation

struct DefaultUserCacheManager: UserCacheManager {

    // MARK: - Instance Properties

    let storageModel: StorageModel

    // MARK: - Instance Methods

    func createOrUpdate(from fragment: UserFragment, context: StorageContext) -> User {
        var user: User!
        let predicate = NSPredicate(format: "id ==  %@", fragment.id)

        if let existingUser = context.manager.first(User.self, sortDescriptors: [], predicate: predicate) {
            user = existingUser
        } else {
            guard let newUser = context.manager.append(User.self) else {
                fatalError("User can't be initialized")
            }
            user = newUser
        }

        user.id = fragment.id
        user.firstName = fragment.firstName
        user.lastName = fragment.lastName
        user.avatarURLRaw = fragment.avatarUrl

        return user
    }

    func fetch(with id: String?) -> User? {
        if let id = id {
            let predicate = NSPredicate(format: "id == %@", id)
            let user = self.storageModel.viewContext.manager.first(User.self, sortDescriptors: [], predicate: predicate)
            return user
        } else {
            return nil
        }
    }

    func fetch(with ids: [String?]) -> [User] {
        var users: [User] = []
        for id in ids {
            if let user = self.fetch(with: id) {
                users.append(user)
            }
        }
        return users
    }

    func save(context: StorageContext) {
        context.save()
    }

    func remove() {
        self.storageModel.viewContext.manager.clear(User.self, sortDescriptors: [])
    }

    func remove(with id: String) {
        let predicate = NSPredicate(format: "id == %@", id)
        self.storageModel.viewContext.manager.clear(User.self, sortDescriptors: [], predicate: predicate)
    }
}
