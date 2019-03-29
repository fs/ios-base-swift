//
//  DefaultExampleService.swift
//  Swift-Base
//
//  Created by Elina Batyrova on 28.03.2019.
//  Copyright © 2019 Flatstack. All rights reserved.
//

import Moya

struct DefaultExampleService: ExampleService {
    
    // MARK: - Instance Properties
    
    let provider = MoyaProvider<ExampleAPI>()
    
    // MARK: - Instance Methods
    
    func exampleFetch(phoneNumber: String, code: String, completion: @escaping (Bool?, Error?) -> Void) {
        provider.request(.exampleFetch(phoneNumber: phoneNumber, code: code)) { (result) in
            switch result {
            case .success(let response):
                //  Decode object like this:
                //  let object = try? response.mapObject(YourObject.self)
                print(response)
                
                completion(true, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
