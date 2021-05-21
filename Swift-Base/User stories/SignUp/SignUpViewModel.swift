//
//  SignUpViewModel.swift
//  Swift-Base
//
//  Created by Анастасия Леонтьева on 21/05/2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation
import Combine

@available(iOS 13.0, *)
final class SignUpViewModel {

    // MARK: - Instance Properties

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var isLoading = false
//    let validationResult = PassthroughSubject<CurrentUser, VehoError>()

    private(set) lazy var isValidFields = Publishers.CombineLatest4($email,
                                                                    $password,
                                                                    $firstName,
                                                                    $lastName)
        .map { email, password, firstName, lastName in
            return email.isValidEmail() && password.count > 5 && !firstName.isEmpty && !lastName.isEmpty
        }
        .eraseToAnyPublisher()

    // MARK: -

    lazy var authorizationService: AuthorizationService = Services.authorizationService()

    // MARK: -

    private var createAccountSubscriber: AnyCancellable?

    // MARK: - Instance Methods

    func createAccount() {
        self.isLoading = true
    }
}
