//
//  ExampleService.swift
//  Swift-Base
//
//  Created by Elina Batyrova on 28/03/2019.
//  Copyright © 2019 Flatstack. All rights reserved.
//

import Foundation

protocol ExampleService {

    // MARK: - Instance Properties

    func exampleFetch(phoneNumber: String, code: String, completion: @escaping (Bool?, Error?) -> Void)
}
