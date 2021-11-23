//
//  Cache.swift
//  Swift-Base
//
//  Created by Maksim Kapitonov on 23/11/2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation
#warning("change to class when adding cache managers")
enum Cache {

    // MARK: - Type Properties

    static let storageModel: StorageModel = CoreDataStorageModel(identifier: "Swift-Base")
}
