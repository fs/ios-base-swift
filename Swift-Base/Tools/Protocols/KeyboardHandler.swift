//
//  KeyboardHandler.swift
//  Tools
//
//  Created by Almaz Ibragimov on 06.06.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import UIKit

public protocol KeyboardHandler {

    // MARK: - Instance Methods

    func handle(keyboardHeight: CGFloat, view: UIView)

    func subscribeToKeyboardNotifications()
    func unsubscribeFromKeyboardNotifications()
}

// MARK: -

public extension KeyboardHandler where Self: AnyObject {

    // MARK: - Instance Methods

    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: -

public extension KeyboardHandler where Self: UIViewController {

    // MARK: - Instance Methods

    fileprivate func onKeyboardWillShow(with notification: NSNotification) {
        guard let userInfo = notification.userInfo else {
            return
        }

        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }

        self.handle(keyboardHeight: self.view.frame.bottom - self.view.convert(keyboardFrame.origin, from: nil).y,
                    view: self.view)
    }

    fileprivate func onKeyboardWillHide(with notification: NSNotification) {
        self.handle(keyboardHeight: 0.0, view: self.view)
    }

    // MARK: -

    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification,
                                               object: nil,
                                               queue: nil,
                                               using: { [weak self] notification in
            self?.onKeyboardWillShow(with: notification as NSNotification)
        })

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                               object: nil,
                                               queue: nil,
                                               using: { [weak self] notification in
            self?.onKeyboardWillHide(with: notification as NSNotification)
        })
    }
}
