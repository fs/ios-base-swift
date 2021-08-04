//
//  KeychainManager.swift
//  Swift-Base
//
//  Created by Анастасия Леонтьева on 20/05/2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation

protocol KeychainManager {

    // MARK: - Instance Properties

    @discardableResult
    func string(forKey key: String) -> String?

    @discardableResult
    func object(forKey key: String) -> NSCoding?

    @discardableResult
    func data(forKey key: String) -> Data?

    @discardableResult
    func save(string: String, forKey key: String) -> Bool

    @discardableResult
    func save(double: Double, forKey key: String) -> Bool

    @discardableResult
    func save(object: NSCoding, forKey key: String) -> Bool

    @discardableResult
    func save(data: Data, forKey key: String) -> Bool

    @discardableResult
    func removeObject(forKey key: String) -> Bool

    @discardableResult
    func removeAllData() -> Bool
}
