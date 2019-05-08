//
//  KeyboardScrollableHandler.swift
//  Tools
//
//  Created by Almaz Ibragimov on 06.06.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import UIKit

public protocol KeyboardScrollableHandler: KeyboardHandler {

    // MARK: - Nested Types

    associatedtype ScrollableView: UIScrollView

    // MARK: - Instance Properties

    var scrollableView: ScrollableView { get }
}

// MARK: -

public extension KeyboardScrollableHandler {

    // MARK: - Instance Methods

    func handle(keyboardHeight: CGFloat, view: UIView) {
        let viewHeight = self.scrollableView.convert(CGPoint(x: 0.0, y: view.bounds.height), from: view).y

        let keyboardHeight = max((keyboardHeight - (viewHeight - self.scrollableView.bounds.height)), 0.0)

        self.scrollableView.contentInset = UIEdgeInsets(top: self.scrollableView.contentInset.top,
                                                        left: self.scrollableView.contentInset.left,
                                                        bottom: keyboardHeight,
                                                        right: self.scrollableView.contentInset.right)

        self.scrollableView.scrollIndicatorInsets = UIEdgeInsets(top: self.scrollableView.scrollIndicatorInsets.top,
                                                                 left: self.scrollableView.scrollIndicatorInsets.left,
                                                                 bottom: keyboardHeight,
                                                                 right: self.scrollableView.scrollIndicatorInsets.right)
    }
}
