//
//  EventListenerConnection.swift
//  Tools
//
//  Created by Almaz Ibragimov on 12.05.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation

final class EventListenerConnection<T>: EventConnection {

    // MARK: - Instance Properties

    let event: Event<T>

    // MARK: - EventConnection

    fileprivate(set) var isPaused = false

    // MARK: - Initializers

    init(event: Event<T>) {
        self.event = event
    }

    // MARK: - Instance Methods

    func unpause() {
        self.isPaused = false
    }

    func pause() {
        self.isPaused = true
    }

    func dispose() {
        self.event.dispose(connection: self)
    }
}
