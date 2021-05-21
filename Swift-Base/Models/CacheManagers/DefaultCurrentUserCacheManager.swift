//
//  DefaultCurrentIUserCacheManager.swift
//  Swift-Base
//
//  Created by mac-mini-137 on 20.05.2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation
import CoreData

struct DefaultCurrentUserCacheManager: CurrentUserCacheManager {

    // MARK: - Instance Properties

    var storageModel: StorageModel!

    // MARK: - Instance Methods

    @discardableResult
    func createOrUpdate(from me: UserFragment, context: StorageContext) -> CurrentUser {
        var currentUser: CurrentUser!
        let predicate = NSPredicate(format: "id == %@", me.id)
        currentUser = createOrUpdateUser(from: predicate, context: context)
        currentUser.id = me.id
        currentUser.firstName = me.firstName
        currentUser.lastName = me.lastName
        currentUser.profileNumber = "#\(me.profileNumber)"

        return currentUser
    }

    @discardableResult
    func createOrUpdate(from me: CurrentUserFragment, context: StorageContext) -> CurrentUser {
        var currentUser: CurrentUser!
        let predicate = NSPredicate(format: "id == %@", me.id)
        currentUser = createOrUpdateUser(from: predicate, context: context)
        currentUser.id = me.id
        currentUser.firstName = me.firstName
        currentUser.lastName = me.lastName
        currentUser.profileNumber = "#\(me.profileNumber)"

        return currentUser
    }

    func save() {
        self.storageModel.viewContext.save()
    }

    func save(context: StorageContext) {
        context.save()
    }

    func currentUser() -> CurrentUser? {
        return self.storageModel.viewContext.manager.fetch(CurrentUser.self, sortDescriptors: []).first
    }

    func remove() {
        self.storageModel.viewContext.manager.clear(CurrentUser.self, sortDescriptors: [])
    }

    private func createOrUpdateUser(from predicate: NSPredicate, context: StorageContext) -> CurrentUser {
        if let existingCurrentUser = context.manager.first(CurrentUser.self, sortDescriptors: [], predicate: predicate) {
            return existingCurrentUser
        } else {
            guard let newCurrentUser = context.manager.append(CurrentUser.self) else {
                fatalError("CurrentUser can't be initialized")
            }
            return newCurrentUser
        }
    }
}
