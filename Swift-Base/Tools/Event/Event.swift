//
//  Event.swift
//  Tools
//
//  Created by Almaz Ibragimov on 11.05.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation

public final class Event<T> {

    // MARK: - Nested Types

    public typealias Handler = ((T) -> Void)

    // MARK: - Instance Properties

    fileprivate(set) var listeners: [EventListener<T>] = []

    // MARK: - Instance Methods

    @discardableResult
    public func connect(_ receiver: AnyObject, handler: @escaping Handler) -> EventListener<T> {
        let listener = EventListener(receiver: receiver,
                                     event: self,
                                     handler: handler)

        self.listeners.append(listener)

        return listener
    }

    public func disconnect(_ receiver: AnyObject) {
        while let index = self.listeners.firstIndex(where: { $0.receiver === receiver }) {
            self.listeners.remove(at: index)
        }
    }

    public func dispose(connection: EventConnection) {
        if let index = self.listeners.firstIndex(where: { $0.connection === connection }) {
            self.listeners.remove(at: index)
        }
    }

    public func emit(data: T) {
        for listener in self.listeners {
            listener.emit(data: data)
        }
    }
}

// MARK: -

public extension Event where T == Void {

    // MARK: - Instance Methods

    func emit() {
        self.emit(data: Void())
    }
}
