//
//  FSExtensions+UITableView.swift
//  SwiftHelpers
//
//  Created by Kruperfone on 31.07.15.
//  Copyright (c) 2015 FlatStack. All rights reserved.
//

import UIKit

public extension UITableView {
    public func fs_deselectSelectedRow (animated:Bool) {
        if ((self.indexPathForSelectedRow) != nil) {
            self.deselectRowAtIndexPath(self.indexPathForSelectedRow!, animated: animated)
        }
    }
}
