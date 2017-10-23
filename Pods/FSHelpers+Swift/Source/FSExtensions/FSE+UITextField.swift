//
//  FSE+UITextField.swift
//  FSHelpers
//
//  Created by Sergey Nikolaev on 04.05.16.
//  Copyright © 2016 FlatStack. All rights reserved.
//

import UIKit

extension UITextField {
    var fs_isEmpty: Bool {
        return self.text?.characters.count == 0
    }
}
