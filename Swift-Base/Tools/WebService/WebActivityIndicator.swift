//
//  WebActivityIndicator.swift
//  Tools
//
//  Created by Almaz Ibragimov on 08.03.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation

public protocol WebActivityIndicator: class {

    // MARK: - Instance Properties

    var activityCount: Int { get }

    // MARK: - Instance Methods

    func incrementActivityCount()
    func decrementActivityCount()
}
