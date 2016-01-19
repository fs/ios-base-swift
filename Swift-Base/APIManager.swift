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
    
    private lazy var manager:AFHTTPRequestOperationManager = {
        
        let manager = AFHTTPRequestOperationManager(baseURL: APIManager.baseURL)
        
        manager.requestSerializer = AFJSONRequestSerializer(writingOptions: NSJSONWritingOptions.PrettyPrinted)
        manager.responseSerializer = AFJSONResponseSerializer(readingOptions: NSJSONReadingOptions.AllowFragments)
        
        manager.responseSerializer.acceptableContentTypes = NSSet(objects: "text/plain", "text/html", "application/json") as Set<NSObject>
        
        #if DEBUG
            manager.securityPolicy.allowInvalidCertificates = true
        #endif
        
        return manager
        }()
}

//MARK: - Basic methods
extension APIManager {
    
    func failureErrorRecognizer (operation: AFHTTPRequestOperation?, error: NSError) -> NSError {
        
        guard let lOperation = operation else {
            return APIManagerError.connectionMissing.generateError()
        }
        
        guard !lOperation.cancelled else {
            return APIManagerError.cancelled.generateError()
        }
        
        return error
    }
    
    //MARK: - Basic Methods
    func GET (endpoint:String,
        params:Dictionary<String, AnyObject>?,
        success:((operation: AFHTTPRequestOperation, responseObject: AnyObject?) -> Void)?,
        failure:((operation: AFHTTPRequestOperation?, error: NSError) -> Void)?) -> AFHTTPRequestOperation? {
            
            let operation = manager.GET(endpoint, parameters: params, success: { (operation:AFHTTPRequestOperation!, responseObject:AnyObject!) -> Void in
                
                success?(operation: operation, responseObject: responseObject)
                
                }) { (operation: AFHTTPRequestOperation?, error: NSError) -> Void in
                    
                    var resultError = self.failureErrorRecognizer(operation, error: error)
                    
                    defer {
                        failure?(operation: operation, error: resultError)
                    }
            }
            
            return operation
    }
    
    func POST (endpoint:String,
        params:Dictionary<String, AnyObject>?,
        success:((operation: AFHTTPRequestOperation, responseObject: AnyObject?) -> Void)?,
        failure:((operation: AFHTTPRequestOperation?, error: NSError) -> Void)?) -> AFHTTPRequestOperation? {
            
            let operation = manager.POST(endpoint, parameters: params, success: { (operation:AFHTTPRequestOperation!, responseObject:AnyObject!) -> Void in
                
                success?(operation: operation, responseObject: responseObject)
                
                }) { (operation: AFHTTPRequestOperation?, error: NSError) -> Void in
                    
                    var resultError = self.failureErrorRecognizer(operation, error: error)
                    
                    defer {
                        failure?(operation: operation, error: resultError)
                    }
            }
            
            return operation
    }
}
