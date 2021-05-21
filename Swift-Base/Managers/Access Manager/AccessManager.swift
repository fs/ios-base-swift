//
//  AccessManager.swift
//  Swift-Base
//
//  Created by Анастасия Леонтьева on 20/05/2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation

protocol AccessManager {

    // MARK: - Instance Properties

    var token: String? { get set }
    var refreshToken: String? { get set }
    var expiryDate: Date? { get set }

    // MARK: - Instance Methods

    func resetAccess()
}
