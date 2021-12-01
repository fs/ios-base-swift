//
//  FirebaseAnalyticsService.swift
//  Swift-Base
//
//  Created by Maksim Kapitonov on 12/01/2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation

protocol FirebaseAnalyticsService {

    // MARK: - Instance Methods

    func logEvent(with name: String)
    func logEvent(with name: String, parameters: [AnyHashable: Any])
}
