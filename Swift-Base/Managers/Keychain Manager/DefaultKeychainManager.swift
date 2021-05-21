//
//  DefaultKeychainManager.swift
//  Swift-Base
//
//  Created by Анастасия Леонтьева on 20/05/2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation

struct DefaultKeychainManager: KeychainManager {

    // MARK: - Instance Properties

    let serviceName: String

    // MARK: - KeychainManager Methods

    @discardableResult
    func string(forKey key: String) -> String? {
        guard let data = self.data(forKey: key) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    @discardableResult
    func object(forKey key: String) -> NSCoding? {
        guard let data = data(forKey: key) else {
            return nil
        }

        return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? NSCoding
    }

    @discardableResult
    func data(forKey key: String) -> Data? {
        var queryDictionary: [String: Any] = [:]
        var result: AnyObject?

        self.configure(queryDictionary: &queryDictionary, for: key)

        queryDictionary[kSecMatchLimit as String] = kSecMatchLimitOne
        queryDictionary[kSecReturnData as String] = kCFBooleanTrue

        let status = withUnsafeMutablePointer(to: &result, { pointer in
            SecItemCopyMatching(queryDictionary as CFDictionary, UnsafeMutablePointer(pointer))
        })

        return status == noErr ? result as? Data : nil
    }

    @discardableResult
    func save(string: String, forKey key: String) -> Bool {
        if let data = string.data(using: .utf8) {
            return self.save(data: data, forKey: key)
        } else {
            return false
        }
    }

    @discardableResult
    func save(double: Double, forKey key: String) -> Bool {
        return self.save(object: NSNumber(value: double), forKey: key)
    }

    @discardableResult
    func save(object: NSCoding, forKey key: String) -> Bool {
        guard let data = try? NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false) else {
            fatalError()
        }

        return self.save(data: data, forKey: key)
    }

    @discardableResult
    func save(data: Data, forKey key: String) -> Bool {
        var queryDictionary: [String: Any] = [:]

        self.configure(queryDictionary: &queryDictionary, for: key)

        queryDictionary[kSecValueData as String] = data

        let status = SecItemAdd(queryDictionary as CFDictionary, nil)

        switch status {
        case errSecSuccess:
            return true

        case errSecDuplicateItem:
            return self.update(data, for: key)

        default:
            return true
        }
    }

    @discardableResult
    func removeObject(forKey key: String) -> Bool {
        var queryDictionary: [String: Any] = [:]

        self.configure(queryDictionary: &queryDictionary, for: key)

        let status = SecItemDelete(queryDictionary as CFDictionary)

        return status == errSecSuccess
    }

    @discardableResult
    func removeAllData() -> Bool {
        var queryDictionary: [String: Any] = [:]

        self.configure(queryDictionary: &queryDictionary)

        let status = SecItemDelete(queryDictionary as CFDictionary)

        return status == errSecSuccess
    }

    // MARK: - Instance Properties

    private func update(_ value: Data, for key: String) -> Bool {
        var queryDictionary: [String: Any] = [:]

        self.configure(queryDictionary: &queryDictionary, for: key)

        let updateDictionary = [(kSecValueData as String): value]

        let status = SecItemUpdate(queryDictionary as CFDictionary, updateDictionary as CFDictionary)

        return status == errSecSuccess
    }

    private func configure(queryDictionary: inout [String: Any], for key: String? = nil) {
        queryDictionary[kSecClass as String] = kSecClassGenericPassword
        queryDictionary[kSecAttrService as String] = self.serviceName as AnyObject?

        if let key = key {
            queryDictionary[kSecAttrAccount as String] = key as AnyObject?
        }
    }
}
