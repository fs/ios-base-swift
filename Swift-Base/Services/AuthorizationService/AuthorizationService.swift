//
//  AuthorizationService.swift
//  Swift-Base
//
//  Created by Анастасия Леонтьева on 20/05/2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation
import Combine

@available(iOS 13.0, *)
protocol AuthorizationService {

    // MARK: - Instance Methods

    func refreshToken() -> AnyPublisher<String, Error>?
//    func signIn(with email: String, password: String) -> AnyPublisher<CurrentUser, MyError>?
    func signOut()
}
