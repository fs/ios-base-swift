//
//  APIManager.swift
//  Swift-Base
//
//  Created by Kruperfone on 16.02.15.
//  Copyright (c) 2015 Flatstack. All rights reserved.
//

import Foundation

class APIManager: NSObject {
    
    
    static let sharedInstance: APIManager = {
        let instance = APIManager()
        return instance
    }()
    
    fileprivate static let baseURL: URL = {
        #if TEST
            return  URL(string: "http://httpbin.org/")!
        #else
            let host = Bundle.main.infoDictionary!["URL_HOST"]
            let version = Bundle.main.infoDictionary!["API_VERSION"]
            return URL(string: "\(host)/\(version)")!
        #endif
    }()
    
    fileprivate(set) lazy var manager: AFHTTPSessionManager = {
        
        let manager = AFHTTPSessionManager(baseURL: APIManager.baseURL)
        
        manager.requestSerializer = AFJSONRequestSerializer(writingOptions: JSONSerialization.WritingOptions.prettyPrinted)
        manager.responseSerializer = AFJSONResponseSerializer(readingOptions: JSONSerialization.ReadingOptions.allowFragments)
        
        manager.responseSerializer.acceptableContentTypes = ["text/plain", "text/html", "application/json"]
        
        #if DEBUG
            manager.securityPolicy.allowInvalidCertificates = true
        #endif
        
        return manager
    }()
}

enum InitializationOperationError: Error {
    case operationNotCreated
    case queryIsAlreadyRunning
    case missingRequiredParameter
    case notImplemented
}

//MARK: - Basic methods

typealias APIManagerSuccessBlock    = (_ task: URLSessionDataTask, _ response: Dictionary<String, AnyObject>) -> Void
typealias APIManagerFailureBlock    = (_ task: URLSessionDataTask?, _ error: NSError?) -> Void
typealias APIManagerProgressBlock   = (_ progress: Progress) -> Void

extension AFHTTPSessionManager {
    
    func API_GET(_ URLString : String,
                 params   : AnyObject?,
                 success  : APIManagerSuccessBlock?,
                 failure  : APIManagerFailureBlock?,
                 progress : APIManagerProgressBlock? = nil) throws -> URLSessionDataTask {
        
        let task = self.get(URLString, parameters: params, progress: { (progressState) in
            DispatchQueue.main.async {
                 progress?(progressState)
            }

            }, success: { (task, response) in
                if let lResponse = response as? Dictionary<String, AnyObject> {
                   DispatchQueue.main.async {
                        success?(task, lResponse)
                    }
                } else {
                   DispatchQueue.main.async {
                        failure?(task, nil)
                    }
                }
            }) { (task, error) in
                DispatchQueue.main.async {
                   failure?(task, error as NSError?)
                }
        }
        
        guard let lTask = task else {
            throw InitializationOperationError.operationNotCreated
        }
        
        return lTask
    }

    func API_POST(_ URLString : String,
                  params   : AnyObject?,
                  success  : APIManagerSuccessBlock?,
                  failure  : APIManagerFailureBlock?,
                  progress : APIManagerProgressBlock? = nil) throws -> URLSessionDataTask {
        
        
        
        let task = self.post(URLString, parameters: params,
                             
                             progress: { (progressState) in
                                DispatchQueue.main.async {
                                    progress?(progressState)
                                }
                                
            }, success: { (task, response) in
                if let lResponse = response as? Dictionary<String, AnyObject> {
                    DispatchQueue.main.async {
                        success?(task, lResponse)
                    }
                } else {
                    DispatchQueue.main.async {
                        failure?(task, nil)
                    }
                }
        }) { (task, error) in
            DispatchQueue.main.async {
                failure?(task, error as NSError?)
            }
        }
        
        guard let lTask = task else {
            throw InitializationOperationError.operationNotCreated
        }
        
        return lTask
    }
    
    func API_PATCH(_ URLString : String,
                   params   : AnyObject?,
                   success  : APIManagerSuccessBlock?,
                   failure  : APIManagerFailureBlock?) throws -> URLSessionDataTask {
        
        let task = self.patch(URLString, parameters: params, success: { (task, response) in
            if let lResponse = response as? Dictionary<String, AnyObject> {
                DispatchQueue.main.async {
                    success?(task, lResponse)
                }
            } else {
                DispatchQueue.main.async {
                    success?(task, [:])
                }
            }
            }) { (task, error) in
                DispatchQueue.main.async {
                    failure?(task, error as NSError?)
                }
        }
        guard let lTask = task else {
            throw InitializationOperationError.operationNotCreated
        }
        
        return lTask
    }
    
    func API_DELETE(_ URLString : String,
                    params   : AnyObject?,
                    success  : APIManagerSuccessBlock?,
                    failure  : APIManagerFailureBlock?) throws -> URLSessionDataTask {
        let task = self.delete(URLString, parameters: params,
                               
                               success: { (task, response) in
                                if let lResponse = response as? Dictionary<String, AnyObject> {
                                    DispatchQueue.main.async {
                                        success?(task, lResponse)
                                    }
                                } else {
                                    DispatchQueue.main.async {
                                        success?(task, [:])
                                    }
                                }
        }) { (task, error) in
            DispatchQueue.main.async {
                failure?(task, error as NSError?)
            }
        }
        
        guard let lTask = task else {
            throw InitializationOperationError.operationNotCreated
        }
        
        return lTask
    }
    
}
