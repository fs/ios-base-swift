//
//  CurrentUserService.swift
//  Swift-Base
//
//  Created by Евгений Самарин on 24/05/2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation
import Combine

@available(iOS 13.0, *)
protocol CurrentUserService {

    // MARK: - Instance Methods

    func fetchCurrentUser() -> AnyPublisher<CurrentUser, Error>?
    func storedCurrentUser() -> CurrentUser?
}
