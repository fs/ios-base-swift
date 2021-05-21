//
//  DefaultManagersModule.swift
//  Swift-Base
//
//  Created by Анастасия Леонтьева on 20/05/2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation

class DefaultManagersModule: ManagersModule {

    // MARK: - Type Properties

    lazy var accessManager: AccessManager = DefaultAccessManager(keychainManager: self.keyhainManager)
    lazy var keyhainManager: KeychainManager = DefaultKeychainManager(serviceName: Bundle.main.bundleIdentifier!)
    lazy var userDefaultsManager: UserDefaultsManager = DefaultUserDefaultsManager()
}
