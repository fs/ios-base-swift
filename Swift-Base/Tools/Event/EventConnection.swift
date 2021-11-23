//
//  EventConnection.swift
//  Tools
//
//  Created by Almaz Ibragimov on 12.05.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation

public protocol EventConnection: AnyObject {

    // MARK: - Instance Properties

    var isPaused: Bool { get }

    // MARK: - Instance Methods

    func unpause()
    func pause()

    func dispose()
}
