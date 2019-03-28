//
//  UIWebActivityIndicator.swift
//  Tools
//
//  Created by Almaz Ibragimov on 08.03.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import UIKit

public final class UIWebActivityIndicator: WebActivityIndicator {
    
    // MARK: - Type Properties
    
    public static let shared = UIWebActivityIndicator()
    
    // MARK: - Instance Properties
    
    public fileprivate(set) var activityCount: Int = 0 {
        didSet {
            if self.activityCount > 0 {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            } else {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }
    
    // MARK: - Initializers
    
    fileprivate init() { }
    
    // MARK: - Instance Methods
    
    public func incrementActivityCount() {
        self.activityCount += 1
    }
    
    public func decrementActivityCount() {
        if self.activityCount > 0 {
            self.activityCount -= 1
        }
    }
}
