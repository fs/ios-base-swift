//
//  Error.swift
//  Swift-Base
//
//  Created by Анастасия Леонтьева on 20.05.2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation

struct MyError: Error {

    // MARK: - Instance Properties

    var title: String?
    var message: String
}

