//
//  ExampleApiRouter.swift
//  Swift-Base
//
//  Created by Никита Асабин on 10/23/17.
//  Copyright © 2017 Flatstack. All rights reserved.
//
import Alamofire

enum UsageWebAPI: URLRequestConvertible, WebAPI {
    case byMonth(Date)
    case authentificate(login:String, password: String)
    
    private var method: Alamofire.HTTPMethod {
        switch self {
        case .byMonth: return .get
        case .authentificate: return .post
        }
    }
    
    private var path: String {
        switch self {
        case .byMonth: return "get"
        case .authentificate: return "post"
        }
    }
    
    private var parameters: Alamofire.Parameters {
        var params: Alamofire.Parameters = [:]
        switch self {
        case .byMonth(let date):
            if #available(iOS 10.0, *) {
                params["date"] = ISO8601DateFormatter().string(from: date)
            } else {
                params["date"] = defaultISO8601Formatter.string(from: date)
            }
            return params
            
        case .authentificate(let login, let password):
            params["login"] = login
            params["password"] = password
            return params
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let request = ApiSessionManager.shared.request(forPath: path, method: method)
        return try Alamofire.JSONEncoding.default.encode(request, with: parameters)
    }
    
}
