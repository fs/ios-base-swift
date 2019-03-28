//
//  AlamofireWebHandler.swift
//  Tools
//
//  Created by Almaz Ibragimov on 08.03.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation
import Alamofire

public final class AlamofireWebHandler: WebHandler {
    
    // MARK: - Instance Properties
    
    fileprivate var dataRequest: Alamofire.DataRequest?
    
    // MARK: -
    
    public let service: WebService
    public let request: WebRequest
    
    public var isLoading: Bool {
        return (self.dataRequest != nil)
    }
    
    // MARK: - Initializers
    
    init(dataRequest: Alamofire.DataRequest, service: WebService, request: WebRequest) {
        self.dataRequest = dataRequest
        
        self.service = service
        self.request = request
        
        dataRequest.response(completionHandler: { [weak self] response in
            self?.dataRequest = nil
        })
    }
    
    deinit {
        Log.low("[\(self.request.logDescription)] deinit", from: self)
        
        self.abort()
    }
    
    // MARK: - Instance Methods
    
    fileprivate func validate<Value>(response: DataResponse<Value>) -> WebError? {
        if let statusCode = response.response?.statusCode {
            return AlamofireWebError(fromStatusCode: statusCode, data: response.result.value)
        } else {
            if response.result.isSuccess {
                return AlamofireWebError(code: .badResponse, data: response.result.value)
            } else {
                if let error = response.result.error as? URLError {
                    return AlamofireWebError(fromURLError: error, data: response.result.value)
                } else if let error = response.result.error as? AFError {
                    return AlamofireWebError(fromAFError: error, data: response.result.value)
                } else {
                    return AlamofireWebError(code: .unknown, data: response.result.value)
                }
            }
        }
    }
    
    public func responseJSON(queue: DispatchQueue?, options: JSONSerialization.ReadingOptions, completion: @escaping ((Any?, WebError?) -> Void)) {
        Log.low("[\(self.request.logDescription)] responseJSON()", from: self)
        
        self.dataRequest?.responseJSON(queue: queue, options: options, completionHandler: { response in
            if let error = self.validate(response: response) {
                Log.low("[\(self.request.logDescription)] responseJSON() --> Error: \(error.logDescription)", from: self)
                
                completion(nil, error)
            } else {
                Log.low("[\(self.request.logDescription)] responseJSON() --> Success", from: self)
                
                completion(response.result.value, nil)
            }
        })
    }
    
    public func responseData(queue: DispatchQueue?, completion: @escaping ((Data?, WebError?) -> Void)) {
        self.dataRequest?.responseData(queue: queue, completionHandler: { response in
            Log.low("[\(self.request.logDescription)] responseData()", from: self)
            
            if let error = self.validate(response: response) {
                Log.low("[\(self.request.logDescription)] responseData() --> Error: \(error.logDescription)", from: self)
                
                completion(nil, error)
            } else {
                Log.low("[\(self.request.logDescription)] responseData() --> Success", from: self)
                
                completion(response.result.value , nil)
            }
        })
    }
    
    public func responseString(queue: DispatchQueue?, encoding: String.Encoding?, completion: @escaping ((String?, WebError?) -> Void)) {
        Log.low("[\(self.request.logDescription)] responseString()", from: self)
        
        self.dataRequest?.responseString(queue: queue, encoding: encoding, completionHandler: { response in
            if let error = self.validate(response: response) {
                Log.low("[\(self.request.logDescription)] responseString() --> Error: \(error.logDescription)", from: self)
                
                completion(nil, error)
            } else {
                Log.low("[\(self.request.logDescription)] responseString() --> Success", from: self)
                
                completion(response.result.value , nil)
            }
        })
    }
    
    public func abort() {
        Log.low("[\(self.request.logDescription)] abort()", from: self)
        
        self.dataRequest?.cancel()
        self.dataRequest = nil
    }
}
