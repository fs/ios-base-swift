//
//  AlamofireWebService.swift
//  Tools
//
//  Created by Almaz Ibragimov on 08.03.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation
import Alamofire

public final class AlamofireWebService<Handler: AlamofireWebHandler>: WebService {

    // MARK: - Instance Properties

    fileprivate let sessionManager: Alamofire.SessionManager

    // MARK: - WebService

    public let serverBaseURL: URL

    public let urlRequestAdapter: WebURLRequestAdapter?
    public let activityIndicator: WebActivityIndicator?

    // MARK: - Initializers

    public init(serverBaseURL: URL, urlRequestAdapter: WebURLRequestAdapter? = nil, activityIndicator: WebActivityIndicator? = nil) {
        self.serverBaseURL = serverBaseURL

        self.urlRequestAdapter = urlRequestAdapter
        self.activityIndicator = activityIndicator

        let configuration = URLSessionConfiguration.default.copy() as! URLSessionConfiguration

        configuration.timeoutIntervalForResource = 3600
        configuration.timeoutIntervalForRequest = 30

        self.sessionManager = Alamofire.SessionManager(configuration: configuration)

        if urlRequestAdapter != nil {
            self.sessionManager.adapter = self
        }
    }

    // MARK: - Instance Methods

    public func make(request: WebRequest) -> WebHandler {
        Log.i(request.logDescription)

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

        let encoding: ParameterEncoding

        switch request.encoding {
        case .url:
            encoding = URLEncoding.default

        case .json:
            encoding = JSONEncoding.default

        case .plist:
            encoding = PropertyListEncoding.default
        }

        let dataRequest = self.sessionManager.request(self.serverBaseURL.appendingPathComponent(request.path),
                                                      method: method,
                                                      parameters: request.parameters,
                                                      encoding: encoding,
                                                      headers: request.headers)

        if let activityIndicator = self.activityIndicator {
            activityIndicator.incrementActivityCount()

            dataRequest.response(completionHandler: { [weak activityIndicator] _ in
                activityIndicator?.decrementActivityCount()
            })
        }

        return Handler(dataRequest: dataRequest, service: self, request: request)
    }

    public func upload(multiPart: WebMultiPart, to path: String, encodingCompletion: @escaping (WebHandler?, WebError?) -> Void) {
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

                    dataRequest.response(completionHandler: { [weak activityIndicator] _ in
                        activityIndicator?.decrementActivityCount()
                    })
                }

                let request = WebRequest(method: .post, path: path)

                encodingCompletion(Handler(dataRequest: dataRequest, service: self, request: request), nil)

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

// MARK: - Alamofire.RequestAdapter

extension AlamofireWebService: Alamofire.RequestAdapter {

    // MARK: - Instance Methods

    public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        return try self.urlRequestAdapter?.adapt(urlRequest: urlRequest) ?? urlRequest
    }
}
