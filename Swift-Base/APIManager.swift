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
    
    class var hostURL: NSURL {
        
        let URL_HOST = NSBundle.mainBundle().infoDictionary!["URL_HOST"] as! String
        return NSURL(string: URL_HOST)!
    }
    
    class var currentAPIVersion: UInt {
        return 1
    }
    
    class var baseURL: NSURL {
        
        let version = "v\(self.currentAPIVersion)"
        let hostURLString = "\(APIManager.hostURL.absoluteString)/\(version)"
        
        return NSURL(string: hostURLString)!
    }
    
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
    
    //MARK: - Basic Methods
    
    func GET (endpoint:String,
        params:Dictionary<String, AnyObject>?,
        success:((operation: AFHTTPRequestOperation, responseObject: AnyObject?) -> Void)?,
        failure:((operation: AFHTTPRequestOperation?, error: NSError?) -> Void)?) -> AFHTTPRequestOperation? {
            
            let operation = manager.GET(endpoint, parameters: params, success: { (operation:AFHTTPRequestOperation!, responseObject:AnyObject!) -> Void in
                
                success?(operation: operation, responseObject: responseObject)
                
                }) { (operation: AFHTTPRequestOperation?, error: NSError) -> Void in
                    
                    var resultError = error
                    
                    guard let lOperation = operation else {
                        resultError = APIManagerError.connectionMissing.generateError()
                        return
                    }
                    
                    guard !lOperation.cancelled else {
                        resultError = APIManagerError.cancelled.generateError()
                        return
                    }
                    
                    defer {
                        failure?(operation: operation, error: resultError)
                    }
            }
            
            return operation
    }
    
    func POST (endpoint:String,
        params:Dictionary<String, AnyObject>?,
        success:((operation: AFHTTPRequestOperation, responseObject: AnyObject?) -> Void)?,
        failure:((operation: AFHTTPRequestOperation?, error: NSError?) -> Void)?) -> AFHTTPRequestOperation? {
            
            let operation = manager.POST(endpoint, parameters: params, success: { (operation:AFHTTPRequestOperation!, responseObject:AnyObject!) -> Void in
                
                success?(operation: operation, responseObject: responseObject)
                
                }) { (operation: AFHTTPRequestOperation?, error: NSError) -> Void in
                    
                    var resultError = error
                    
                    guard let lOperation = operation else {
                        resultError = APIManagerError.connectionMissing.generateError()
                        return
                    }
                    
                    guard !lOperation.cancelled else {
                        resultError = APIManagerError.cancelled.generateError()
                        return
                    }
                    
                    defer {
                        failure?(operation: operation, error: resultError)
                    }
            }
            
            return operation
    }
}
