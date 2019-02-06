//
//  FSE+UITextField.swift
//  FSHelpers
//
//  Created by Sergey Nikolaev on 04.05.16.
//  Copyright © 2016 FlatStack. All rights reserved.
//

import UIKit

extension UITextField {
    
    @available(*, deprecated, message: "Deprecated. Use text?.isEmpty")
    var fs_isEmpty: Bool {
        return self.text?.isEmpty ?? true
    }
}
