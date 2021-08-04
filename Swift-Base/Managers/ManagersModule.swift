//
//  ManagersModule.swift
//  Swift-Base
//
//  Created by Анастасия Леонтьева on 20/05/2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation

protocol ManagersModule {

    // MARK: - Type Properties

    var accessManager: AccessManager { get }
    var keyhainManager: KeychainManager { get }
    var userDefaultsManager: UserDefaultsManager { get }
}
