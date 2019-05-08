//
//  CacheContext.swift
//  Swift-Base
//
//  Created by Oleg Gorelov on 30/09/2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation

protocol CacheContext: AnyObject {

    // MARK: - Instance Properties

    var storageContext: StorageContext { get }

    var model: CacheModel! { get }
    var parent: CacheContext? { get }

    var type: CacheContextType { get }

    // MARK: - Instance Methods

    func createMainQueueChildContext() -> Self
    func createPrivateQueueChildContext() -> Self

    func performAndWait(block: @escaping () -> Void)
    func perform(block: @escaping () -> Void)

    func rollback()
    func save()

    func clear()
}

// MARK: -

extension CacheContext {

    // MARK: - Instance Methods

    func clear() {
        self.save()
    }
}
