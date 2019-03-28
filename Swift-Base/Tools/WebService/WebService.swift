//
//  WebService.swift
//  Tools
//
//  Created by Almaz Ibragimov on 08.03.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation

public protocol WebService {
    
    // MARK: - Instance Properties
    
    var serverBaseURL: URL { get }
    var requestAdapter: WebRequestAdapter? { get }
    
    var activityIndicator: WebActivityIndicator? { get set }
    
    // MARK: - Instance Methods
    
    func make(request: WebRequest) -> WebHandler
    
    func upload(multiPart: WebMultiPart, to path: String, encodingCompletion: @escaping (WebHandler?, WebError?) -> Void)
}
