//
//  APIManager.swift
//  Swift-Base
//
//  Created by Kruperfone on 16.02.15.
//  Copyright (c) 2015 Flatstack. All rights reserved.
//

import Foundation

class APIManager: NSObject {
    
    class var sharedInstance: APIManager {
        struct Static {
            static var instance: APIManager?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = APIManager()
        }
        
        return Static.instance!
    }
    
    private static let baseURL: NSURL = {
        
        #if TEST
            return  NSURL(string: "http://httpbin.org/")!
        #else
            let host = NSBundle.mainBundle().infoDictionary!["URL_HOST"]
            let version = NSBundle.mainBundle().infoDictionary!["API_VERSION"]
            return NSURL(string: "\(host)/\(version)")!
        #endif
        
    }()
    
    private(set) lazy var manager: AFHTTPSessionManager = {
        
        let manager = AFHTTPSessionManager(baseURL: APIManager.baseURL)
        
        manager.requestSerializer = AFJSONRequestSerializer(writingOptions: NSJSONWritingOptions.PrettyPrinted)
        manager.responseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions.AllowFragments)
        
        manager.responseSerializer.acceptableContentTypes = ["text/plain", "text/html", "application/json"]
        
        #if DEBUG
            manager.securityPolicy.allowInvalidCertificates = true
        #endif
        
        return manager
    }()
}

enum InitializationOperationError: ErrorType {
    case operationNotCreated
    case queryIsAlreadyRunning
    case missingRequiredParameter
    case notImplemented
}

//MARK: - Basic methods

typealias APIManagerSuccessBlock    = (task: NSURLSessionDataTask, response: Dictionary<String, AnyObject>) -> Void
typealias APIManagerFailureBlock    = (task: NSURLSessionDataTask?, error: NSError?) -> Void
typealias APIManagerProgressBlock   = (progress: NSProgress) -> Void

extension AFHTTPSessionManager {
    
    func API_GET(URLString : String,
                 params   : AnyObject?,
                 success  : APIManagerSuccessBlock?,
                 failure  : APIManagerFailureBlock?,
                 progress : APIManagerProgressBlock? = nil) throws -> NSURLSessionDataTask {
        
        let task = self.GET(URLString, parameters: params,
                            
                            progress: { (progressState: NSProgress) in
                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                    progress?(progress: progressState)
                                })
            },
                            
                            success: { (task: NSURLSessionDataTask, response: AnyObject?)  in
                                
                                if let lResponse = response as? Dictionary<String, AnyObject> {
                                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                        success?(task: task, response: lResponse)
                                    })
                                } else {
                                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                        failure?(task: task, error: nil)
                                    })
                                }
            },
                            
                            failure: { (task: NSURLSessionDataTask?, error: NSError) in
                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                    failure?(task: task, error: error)
                                })
        })
        
        guard let lTask = task else {
            throw InitializationOperationError.operationNotCreated
        }
        
        return lTask
    }
    
    func API_POST(URLString : String,
                  params   : AnyObject?,
                  success  : APIManagerSuccessBlock?,
                  failure  : APIManagerFailureBlock?,
                  progress : APIManagerProgressBlock? = nil) throws -> NSURLSessionDataTask {
        
        
        
        let task = self.POST(URLString, parameters: params,
                             
                             progress: { (progressState: NSProgress) in
                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                    progress?(progress: progressState)
                                })
            },
                             
                             success: { (task: NSURLSessionDataTask, response: AnyObject?)  in
                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                    success?(task: task, response: (response as? [String : AnyObject]) ?? [:])
                                })
            },
                             
                             failure: { (task: NSURLSessionDataTask?, error: NSError) in
                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                    failure?(task: task, error: error)
                                })
        })
        
        guard let lTask = task else {
            throw InitializationOperationError.operationNotCreated
        }
        
        return lTask
    }
    
    func API_PATCH(URLString : String,
                   params   : AnyObject?,
                   success  : APIManagerSuccessBlock?,
                   failure  : APIManagerFailureBlock?) throws -> NSURLSessionDataTask {
        
        let task = self.PATCH(URLString, parameters: params,
                              success: { (task: NSURLSessionDataTask, response: AnyObject?)  in
                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                    success?(task: task, response: (response as? [String : AnyObject]) ?? [:])
                                })
            },
                              
                              failure: { (task: NSURLSessionDataTask?, error: NSError) in
                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                    failure?(task: task, error: error)
                                })
        })
        
        guard let lTask = task else {
            throw InitializationOperationError.operationNotCreated
        }
        
        return lTask
    }
    
    func API_DELETE(URLString : String,
                    params   : AnyObject?,
                    success  : APIManagerSuccessBlock?,
                    failure  : APIManagerFailureBlock?) throws -> NSURLSessionDataTask {
        let task = self.DELETE(URLString, parameters: params,
                               
                               success: { (task: NSURLSessionDataTask, response: AnyObject?)  in
                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                    success?(task: task, response: (response as? [String : AnyObject]) ?? [:])
                                })
            },
                               
                               failure: { (task: NSURLSessionDataTask?, error: NSError) in
                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                    failure?(task: task, error: error)
                                })
        })
        
        guard let lTask = task else {
            throw InitializationOperationError.operationNotCreated
        }
        
        return lTask
    }
    
}
