//
//  DefaultAccessManager.swift
//  Swift-Base
//
//  Created by Анастасия Леонтьева on 20/05/2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation
import CommonCrypto

struct DefaultAccessManager: AccessManager {

    // MARK: - Nested Types

    private enum Constants {

        // MARK: - Type Properties

        static let tokenKey = "AccessToken"
        static let refreshTokenKey = "RefreshToken"
        static let expiryDateKey = "AccessExpiryDate"
    }

    // MARK: - Instance Properties

    let keychainManager: KeychainManager

    // MARK: -

    var token: String? {
        get {
            return self.keychainManager.string(forKey: Constants.tokenKey)
        }

        set {
            if let token = newValue {
                self.keychainManager.save(string: token, forKey: Constants.tokenKey)
            } else {
                self.keychainManager.removeObject(forKey: Constants.tokenKey)
            }
        }
    }

    var refreshToken: String? {
        get {
            return self.keychainManager.string(forKey: Constants.refreshTokenKey)
        }

        set {
            if let token = newValue {
                self.keychainManager.save(string: token, forKey: Constants.refreshTokenKey)
            } else {
                self.keychainManager.removeObject(forKey: Constants.refreshTokenKey)
            }
        }
    }

    var expiryDate: Date? {
        get {
            if let expiryTimeInterval = self.keychainManager.object(forKey: Constants.expiryDateKey) as? NSNumber {
                return Date(timeIntervalSinceReferenceDate: expiryTimeInterval.doubleValue)
            } else {
                return nil
            }
        }

        set {
            if let expiryTimeInterval = newValue?.timeIntervalSinceReferenceDate {
                self.keychainManager.save(double: expiryTimeInterval, forKey: Constants.expiryDateKey)
            } else {
                self.keychainManager.removeObject(forKey: Constants.expiryDateKey)
            }
        }
    }

    // MARK: - Instance Methods

    func resetAccess() {
        self.keychainManager.removeObject(forKey: Constants.refreshTokenKey)
        self.keychainManager.removeObject(forKey: Constants.tokenKey)
        self.keychainManager.removeObject(forKey: Constants.expiryDateKey)
    }
}
