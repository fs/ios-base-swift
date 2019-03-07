//
//  Fonts.swift
//  Swift-Base
//
//  Created by Timur Shafigullin on 07/03/2019.
//  Copyright © 2019 Flatstack. All rights reserved.
//

import UIKit

enum Fonts {

    // MARK: - Type Methods

    static func regular(ofSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .regular)
    }

    static func medium(ofSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .medium)
    }

    static func bold(ofSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }

    static func semibold(ofSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .semibold)
    }

    static func light(ofSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .light)
    }

    static func thin(ofSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .thin)
    }

    static func heavy(ofSize size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .heavy)
    }
}
