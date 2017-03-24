//
//  FSE+UIButton.swift
//  FSHelpers
//
//  Created by Ildar Zalyalov on 27.07.16.
//  Copyright © 2016 FlatStack. All rights reserved.
//

import UIKit

public extension UIButton{
    var fs_title: String? {
        set (value) {self.setTitle(value, for: UIControlState())}
        get         {return self.title(for: UIControlState())}
    }
}
