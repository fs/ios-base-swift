//
//  DefaultUserDefaultsManager.swift
//  Swift-Base
//
//  Created by Анастасия Леонтьева on 20/05/2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation

struct DefaultUserDefaultsManager: UserDefaultsManager {

    // MARK: - Nested Types

    private enum Constants {

        // MARK: - Type Properties

        static let deviceTokenKey = "DeviceToken"
    }

    // MARK: - Instance Properties

    let userDefaults = UserDefaults.standard

    // MARK: -

    var deviceToken: String? {
        get {
            return self.userDefaults.string(forKey: Constants.deviceTokenKey)
        }

        set {
            if let token = newValue {
                self.userDefaults.set(token, forKey: Constants.deviceTokenKey)
            } else {
                self.userDefaults.removeObject(forKey: Constants.deviceTokenKey)
            }
        }
    }
}
