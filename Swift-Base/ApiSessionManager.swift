//
//  APIManager.swift
//  Swift-Base
//
//  Created by Kruperfone on 16.02.15.
//  Copyright (c) 2015 Flatstack. All rights reserved.
//

import Foundation
import Alamofire

class ApiSessionManager {

    static let shared = ApiSessionManager()
    
    fileprivate let manager: Alamofire.SessionManager
    fileprivate let baseURL: URL = {
         return  URL(string: "http://httpbin.org/")!
        #if TEST
            return  URL(string: "http://httpbin.org/")!
        #else
            guard let host = Bundle.main.infoDictionary!["URL_HOST"] as? String else {return URL(string: "http://httpbin.org/")!}
            return URL(string: host)!
        #endif
        
    }()
    
    fileprivate init() {
        var defaultHeaders = Alamofire.SessionManager.default.session.configuration.httpAdditionalHeaders ?? [:]

        if let dict = Bundle.main.infoDictionary {
            if let version = dict["CFBundleShortVersionString"] {
                defaultHeaders["X-App-iOS-Version"] = version
            }
            
            if let build = dict["CFBundleVersion"] {
                defaultHeaders["X-App-iOS-Build"] = build
            }
        }
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.httpAdditionalHeaders = defaultHeaders
        
        manager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func authorizationHeaders() ->[AnyHashable : Any]? {
        return [:]
    }
    
    func request(forPath path: String, method: Alamofire.HTTPMethod) -> URLRequest {
        let request = NSMutableURLRequest(url: baseURL.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Authorization", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request as URLRequest
    }
    
    func call(_ request: URLRequestConvertible) -> DataRequest {
        let req = manager.request(request)
        
        #if DEBUG
            debugPrint(req)
        #endif
        
        return req
    }
}

protocol WebAPI {
}

extension WebAPI where Self : URLRequestConvertible {
    func validate<S: Sequence>(statusCode acceptableStatusCode: S) -> Request where S.Iterator.Element == Int {
        return ApiSessionManager.shared.call(self).validate(statusCode: acceptableStatusCode)
    }
    
    func validate() -> DataRequest {
        return ApiSessionManager.shared.call(self).validate()
    }
    
    
    
}
