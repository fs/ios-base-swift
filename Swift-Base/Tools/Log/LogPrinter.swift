//
//  LogPrinter.swift
//  Tools
//
//  Created by Almaz Ibragimov on 15/04/2020.
//  Copyright © 2020 Flatstack. All rights reserved.
//

import Foundation

public protocol LogPrinter: AnyObject {

    // MARK: - Instance Methods

    func print(_ line: String)
}
