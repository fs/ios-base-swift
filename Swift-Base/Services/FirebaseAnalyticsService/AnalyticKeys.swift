//
//  AnalyticKeys.swift
//  Swift-Base
//
//  Created by Maksim Kapitonov on 12/01/2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation

enum AnalyticKeys {

    // MARK: - Default

    enum CurrentUser {
        static let failureFetchingUser = "FAILURE_FETCHING_USER"
        static let successFetchingUser = "SUCCESS_FETCHING_USER"
        static let failureUpdatinUser = "FAILURE_UPDATING_USER"
        static let successUpdatingUser = "SUCCESS_UPDATING_USER"
    }
}
