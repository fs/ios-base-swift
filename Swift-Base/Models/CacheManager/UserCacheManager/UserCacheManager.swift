//
//  UserCacheManager.swift
//  Swift-Base
//
//  Created by Евгений Самарин on 24/05/2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation

protocol UserCacheManager {

    // MARK: - Instance Methods

    func createOrUpdate(from fragment: UserFragment, context: StorageContext) -> User
    func fetch(with id: String?) -> User?
    func save(context: StorageContext)
    func remove()
    func remove(with id: String)
}
