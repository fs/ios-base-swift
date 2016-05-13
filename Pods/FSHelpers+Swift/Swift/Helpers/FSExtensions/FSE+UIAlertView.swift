//
//  FSE+UIAlertView.swift
//  FSHelpers
//
//  Created by Sergey Nikolaev on 05.01.16.
//  Copyright © 2016 FlatStack. All rights reserved.
//

import UIKit

public extension UIAlertController {
    
    func fs_show () {
        guard let root = UIApplication.sharedApplication().delegate?.window??.rootViewController else {return}
        root.showViewController(self, sender: self)
    }
}
