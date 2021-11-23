//
//  StorageObject.swift
//  Tools
//
//  Created by Almaz Ibragimov on 24.02.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation

public protocol StorageObject: AnyObject {
    
    // MARK: - Instance Properties
    
    static var entityName: String { get }
}
