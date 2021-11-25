//
//  CurrentUserCacheManager.swift
//  Swift-Base
//
//  Created by Maksim Kapitonov on 24/11/2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation

protocol CurrentUserCacheManager {

    // MARK: - Instance Methods

    @discardableResult
    func createOrUpdate(from me: UserFragment, context: StorageContext) -> CurrentUser
    func createOrUpdate(from me: CurrentUserFragment, context: StorageContext) -> CurrentUser
    func save()
    func save(context: StorageContext)
    func currentUser() -> CurrentUser?
    func remove()
}
