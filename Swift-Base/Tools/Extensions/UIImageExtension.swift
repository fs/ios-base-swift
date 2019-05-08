//
//  UIImageExtension.swift
//  Tools
//
//  Created by Almaz Ibragimov on 01.01.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import UIKit

public extension UIImage {

    // MARK: - Instance Methods

    final func scaled(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)

        self.draw(in: CGRect(x: 0.0,
                             y: 0.0,
                             size: size))

        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return scaledImage
    }

    final func scaled(to width: CGFloat) -> UIImage? {
        let scaleFactor = width / self.size.width

        let scaledSize: CGSize = CGSize(width: self.size.width * scaleFactor, height: self.size.height * scaleFactor)

        UIGraphicsBeginImageContext(scaledSize)

        self.draw(in: CGRect(x: 0.0,
                             y: 0.0,
                             size: scaledSize))

        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return scaledImage
    }
}
