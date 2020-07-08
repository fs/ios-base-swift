//
//  AlamofireWebHandler.swift
//  Tools
//
//  Created by Almaz Ibragimov on 08.03.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation
import Alamofire

public class AlamofireWebHandler: WebHandler {

    // MARK: - Instance Properties

    public fileprivate(set) var dataRequest: Alamofire.DataRequest?

    // MARK: - WebHandler

    public let service: WebService
    public let request: WebRequest

    public var isLoading: Bool {
        return (self.dataRequest != nil)
    }

    // MARK: - Initializers

    public required init(dataRequest: Alamofire.DataRequest, service: WebService, request: WebRequest) {
        self.dataRequest = dataRequest

        self.service = service
        self.request = request

        dataRequest.response(completionHandler: { [weak self] _ in
            self?.dataRequest = nil
        })
    }

    deinit {
        Log.i("[\(self.request.logDescription)]")

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

    // MARK: -

    public func responseJSON(queue: DispatchQueue?, options: JSONSerialization.ReadingOptions, completion: @escaping ((Any?, WebError?) -> Void)) {
        Log.i("[\(self.request.logDescription)]")

        self.dataRequest?.responseJSON(queue: queue, options: options, completionHandler: { response in
            if let error = self.validate(response: response) {
                Log.e("[\(self.request.logDescription)] --> Error: \(error.logDescription)")

                completion(nil, error)
            } else {
                Log.i("[\(self.request.logDescription)] --> Success")

                completion(response.result.value, nil)
            }
        })
    }

    public func responseData(queue: DispatchQueue?, completion: @escaping ((Data?, WebError?) -> Void)) {
        self.dataRequest?.responseData(queue: queue, completionHandler: { response in
            Log.i("[\(self.request.logDescription)]")

            if let error = self.validate(response: response) {
                Log.e("[\(self.request.logDescription)] --> Error: \(error.logDescription)")

                completion(nil, error)
            } else {
                Log.i("[\(self.request.logDescription)] --> Success")

                completion(response.result.value, nil)
            }
        })
    }

    public func responseString(queue: DispatchQueue?, encoding: String.Encoding?, completion: @escaping ((String?, WebError?) -> Void)) {
        Log.i("[\(self.request.logDescription)]")

        self.dataRequest?.responseString(queue: queue, encoding: encoding, completionHandler: { response in
            if let error = self.validate(response: response) {
                Log.e("[\(self.request.logDescription)] --> Error: \(error.logDescription)")

                completion(nil, error)
            } else {
                Log.i("[\(self.request.logDescription)] --> Success")

                completion(response.result.value, nil)
            }
        })
    }

    public func abort() {
         Log.w("[\(self.request.logDescription)]")

        self.dataRequest?.cancel()
        self.dataRequest = nil
    }
}
