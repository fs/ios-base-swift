//
//  EventListener.swift
//  Tools
//
//  Created by Almaz Ibragimov on 12.05.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation

public final class EventListener<T> {

    // MARK: - Instance Properties

    public fileprivate(set) weak var receiver: AnyObject?

    public let event: Event<T>
    public let handler: Event<T>.Handler

    public let connection: EventConnection

    // MARK: - Initializers

    init(receiver: AnyObject, event: Event<T>, handler: @escaping Event<T>.Handler) {
        self.receiver = receiver

        self.event = event
        self.handler = handler

        self.connection = EventListenerConnection(event: event)
    }

    // MARK: - Instance Methods

    public func emit(data: T) {
        if (self.receiver != nil) && (!self.connection.isPaused) {
            self.handler(data)
        }
    }
}
