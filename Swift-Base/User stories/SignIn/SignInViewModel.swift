//
//  SignInViewModel.swift
//  Swift-Base
//
//  Created by Анастасия Леонтьева on 21/05/2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation
import Combine

@available(iOS 13.0, *)
final class SignInViewModel {

    // MARK: - Instance Properties

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading = false
//    let validationResult = PassthroughSubject<CurrentUser, VehoError>()

    private(set) lazy var isValidFields = Publishers.CombineLatest($email, $password)
        .map { $0.isValidEmail() && $1.count > 5 }
        .eraseToAnyPublisher()

    // MARK: -

    lazy var authorizationService: AuthorizationService = Services.authorizationService()

    // MARK: -

    private var signInSubscriber: AnyCancellable?

    // MARK: - Instance Methods

    func signIn() {
        self.isLoading = true
    }
}
