//
//  WebHandler.swift
//  Tools
//
//  Created by Almaz Ibragimov on 08.03.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation

public protocol WebHandler {
    
    // MARK: - Instance Properties
    
    var service: WebService { get }
    var request: WebRequest { get }
    
    var isLoading: Bool { get }
    
    // MARK: - Instance Methods
    
    func responseData(queue: DispatchQueue?, completion: @escaping ((Data?, WebError?) -> Void))
    func responseString(queue: DispatchQueue?, encoding: String.Encoding?, completion: @escaping ((String?, WebError?) -> Void))
    func responseJSON(queue: DispatchQueue?, options: JSONSerialization.ReadingOptions, completion: @escaping ((Any?, WebError?) -> Void))
    
    func abort()
}

public extension WebHandler {
    
    // MARK: - Instance Methods
    
    public func responseData(completion: @escaping ((Data?, WebError?) -> Void)) {
        self.responseData(queue: nil, completion: completion)
    }
    
    public func responseString(encoding: String.Encoding?, completion: @escaping ((String?, WebError?) -> Void)) {
        self.responseString(queue: nil, encoding: encoding, completion: completion)
    }
    
    public func responseString(queue: DispatchQueue? = nil, completion: @escaping ((String?, WebError?) -> Void)) {
        self.responseString(queue: queue, encoding: nil, completion: completion)
    }
    
    public func responseJSON(options: JSONSerialization.ReadingOptions, completion: @escaping ((Any?, WebError?) -> Void)) {
        self.responseJSON(queue: nil, options: options, completion: completion)
    }
    
    public func responseJSON(queue: DispatchQueue? = nil, completion: @escaping ((Any?, WebError?) -> Void)) {
        self.responseJSON(queue: queue, options: .allowFragments, completion: completion)
    }
    
    public func keepAlive() { }
}
