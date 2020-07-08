//
//  IconTextField.swift
//  Tools
//
//  Created by Almaz Ibragimov on 07.01.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import UIKit

@IBDesignable public class IconTextField: TextField {

    // MARK: - Instance Properties

    fileprivate let iconImageView: UIImageView = UIImageView()

    // MARK: -

    @IBInspectable public var icon: UIImage? {
        get {
            return self.iconImageView.image
        }

        set {
            self.iconImageView.image = newValue

            self.layoutLeftView()
        }
    }

    @IBInspectable public var iconLeftInset: CGFloat = 10.0 {
        didSet {
            self.layoutLeftView()
        }
    }

    @IBInspectable public var iconTintColor: UIColor {
        get {
            return self.iconImageView.tintColor
        }

        set {
            self.iconImageView.tintColor = newValue
        }
    }

    // MARK: - Initializers

    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        self.initialize()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.initialize()
    }

    // MARK: - Instance Methods

    fileprivate func initialize() {
        self.iconImageView.contentMode = .right

        self.leftView = self.iconImageView
        self.leftViewMode = .always
    }

    fileprivate func layoutLeftView() {
        if let imageWidth = self.iconImageView.image?.size.width {
            self.iconImageView.frame = CGRect(x: 0.0,
                                              y: 0.0,
                                              width: imageWidth + self.iconLeftInset,
                                              height: self.bounds.height)
        } else {
            self.iconImageView.frame = CGRect(x: 0.0,
                                              y: 0.0,
                                              width: self.iconLeftInset,
                                              height: self.bounds.height)
        }
    }

    // MARK: - UIView

    public override func layoutSubviews() {
        super.layoutSubviews()

        self.layoutLeftView()
    }
}
