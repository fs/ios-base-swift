//
//  CurrentUserCacheManager.swift
//  Swift-Base
//
//  Created by mac-mini-137 on 20.05.2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation
import Apollo

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
