//
//  ExampleApiRouter.swift
//  Swift-Base
//
//  Created by Никита Асабин on 10/23/17.
//  Copyright © 2017 Flatstack. All rights reserved.
//
import Alamofire

enum UsageWebAPI: URLRequestConvertible, WebAPI {
    case ByMonth(Date)
    case Authentificate(login:String, password: String)
    
    private var method: Alamofire.HTTPMethod {
        switch self {
        case .ByMonth: return .get
        case .Authentificate: return .post
        }
    }
    
    private var path: String {
        switch self {
        case .ByMonth: return "get"
        case .Authentificate: return "post"
        }
    }
    
    private var parameters: Alamofire.Parameters {
        var params: Alamofire.Parameters = [:]
        switch self {
        case .ByMonth(let date):
            if #available(iOS 10.0, *) {
                params["date"] = ISO8601DateFormatter().string(from: date)
            } else {
                params["date"] = DefaultISO8601Formatter.string(from:date)
            }
            return params
            
        case .Authentificate(let login,let password):
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
