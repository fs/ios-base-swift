//
//  CurrentUserService.swift
//  Swift-Base
//
//  Created by Maksim Kapitonov on 12/01/2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation
import Combine

@available(iOS 13.0, *)
protocol CurrentUserService {

    // MARK: - Instance Methods

    func fetchCurrentUser() -> AnyPublisher<CurrentUser, MyError>
    func storedCurrentUser() -> CurrentUser?
    func updateUser(input: UpdateUserInput) -> AnyPublisher<CurrentUser, MyError>
}
