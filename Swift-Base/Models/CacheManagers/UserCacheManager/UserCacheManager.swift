//
//  UserCacheManager.swift
//  Swift-Base
//
//  Created by Maksim Kapitonov on 24/11/2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation

protocol UserCacheManager {

    // MARK: - Instance Methods

    func createOrUpdate(from fragment: UserFragment, context: StorageContext) -> User
    func fetch(with id: String?) -> User?
    func fetch(with ids: [String?]) -> [User]
    func save(context: StorageContext)
    func remove()
    func remove(with id: String)
}
