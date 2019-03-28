//
//  AlamofireWebService.swift
//  Tools
//
//  Created by Almaz Ibragimov on 08.03.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation
import Alamofire

public class AlamofireWebService: WebService {
    
    // MARK: - Instance Properties
    
    fileprivate final let sessionManager: Alamofire.SessionManager
    
    // MARK: - WebService
    
    public final let serverBaseURL: URL
    public final let requestAdapter: WebRequestAdapter?
    public final var activityIndicator: WebActivityIndicator?
    
    // MARK: - Initializers
    
    public init(serverBaseURL: URL, requestAdapter: WebRequestAdapter?, activityIndicator: WebActivityIndicator? = nil) {
        self.requestAdapter = requestAdapter
        self.serverBaseURL = serverBaseURL
        self.activityIndicator = activityIndicator
        
        guard let configuration = URLSessionConfiguration.default.copy() as? URLSessionConfiguration else {
            fatalError()
        }
        
        configuration.timeoutIntervalForResource = 3600
        configuration.timeoutIntervalForRequest = 30
        
        self.sessionManager = Alamofire.SessionManager(configuration: configuration)
        
        if let requestAdapter = requestAdapter {
            self.sessionManager.adapter = AlamofireWebRequestAdapter(adapter: requestAdapter)
        }
    }
    
    // MARK: - Instance Methods
    
    public final func make(request: WebRequest) -> WebHandler {
        Log.low("send(request: \(request.logDescription))", from: self)
        
        let method: HTTPMethod
        
        switch request.method {
        case .head:
            method = .head
            
        case .get:
            method = .get
            
        case .delete:
            method = .delete
            
        case .patch:
            method = .patch
            
        case .post:
            method = .post
            
        case .put:
            method = .put
        }
        
        let dataRequest = self.sessionManager.request(self.serverBaseURL.appendingPathComponent(request.path),
                                                      method: method,
                                                      parameters: request.params,
                                                      headers: request.headers)
        
        if let activityIndicator = self.activityIndicator {
            activityIndicator.incrementActivityCount()
            
            dataRequest.response(completionHandler: { [weak activityIndicator] response in
                activityIndicator?.decrementActivityCount()
            })
        }
        
        return AlamofireWebHandler(dataRequest: dataRequest, service: self, request: request)
    }
    
    public final func upload(multiPart: WebMultiPart, to path: String, encodingCompletion: @escaping (WebHandler?, WebError?) -> Void) {
        self.sessionManager.upload(multipartFormData: { multiPartData in
            for multiPartItem in multiPart {
                multiPartData.append(multiPartItem.stream,
                                     withLength: multiPartItem.streamLength,
                                     name: multiPartItem.name,
                                     fileName: multiPartItem.fileName,
                                     mimeType: multiPartItem.mimeType)
            }
        }, to: self.serverBaseURL.appendingPathComponent(path), encodingCompletion: { result in
            switch result {
            case .success(let dataRequest, _, _):
                if let activityIndicator = self.activityIndicator {
                    activityIndicator.incrementActivityCount()
                    
                    dataRequest.response(completionHandler: { [weak activityIndicator] response in
                        activityIndicator?.decrementActivityCount()
                    })
                }
                
                let request = WebRequest(method: .post, path: path)
                
                encodingCompletion(AlamofireWebHandler(dataRequest: dataRequest,
                                                       service: self,
                                                       request: request), nil)
                
            case .failure(let error):
                if let error = error as? URLError {
                    encodingCompletion(nil, AlamofireWebError(fromURLError: error, data: nil))
                } else if let error = error as? AFError {
                    encodingCompletion(nil, AlamofireWebError(fromAFError: error, data: nil))
                } else {
                    encodingCompletion(nil, AlamofireWebError(code: .unknown, data: nil))
                }
            }
        })
    }
}
