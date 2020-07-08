//
//  RoundedImageView.swift
//  YouMakeUp
//
//  Created by Oleg Gorelov on 09/04/2019.
//  Copyright © 2019 Flatstack. All rights reserved.
//

import UIKit

@IBDesignable public class RoundedImageView: UIImageView {

    // MARK: - Instance Properties

    @IBInspectable public var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
            self.layer.masksToBounds = (self.cornerRadius > 0.0)
        }
    }
}
