//
//  TextField.swift
//  Tools
//
//  Created by Almaz Ibragimov on 06.01.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import UIKit

@IBDesignable public class TextField: UITextField {

    // MARK: - Instance Properties

    @IBInspectable public var leftInset: CGFloat = 8.0 {
        didSet {
            self.setNeedsLayout()
        }
    }

    @IBInspectable public var rightInset: CGFloat = 0.0 {
        didSet {
            self.setNeedsLayout()
        }
    }

    @IBInspectable public var topInset: CGFloat = 2.0 {
        didSet {
            self.setNeedsLayout()
        }
    }

    @IBInspectable public var bottomInset: CGFloat = 0.0 {
        didSet {
            self.setNeedsLayout()
        }
    }

    // MARK: -

    public var isTextEmpty: Bool {
        return self.text?.isEmpty ?? true
    }

    // MARK: - Instance Methods

    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        let leftInset = (self.leftView?.frame.width ?? 0.0) + self.leftInset
        let rightInset = (self.rightView?.frame.width ?? 0.0) + self.rightInset

        return CGRect(x: leftInset,
                      y: self.topInset,
                      width: bounds.width - leftInset - rightInset,
                      height: bounds.height - self.topInset - self.bottomInset)
    }

    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return self.textRect(forBounds: bounds)
    }
}
