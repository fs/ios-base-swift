//
//  FSExtensions+UITableView.swift
//  SwiftHelpers
//
//  Created by Kruperfone on 31.07.15.
//  Copyright (c) 2015 FlatStack. All rights reserved.
//

import UIKit

public extension UITableView {
    public func fs_deselectSelectedRow (_ animated:Bool) {
        if ((self.indexPathForSelectedRow) != nil) {
            self.deselectRow(at: self.indexPathForSelectedRow!, animated: animated)
        }
    }
}
