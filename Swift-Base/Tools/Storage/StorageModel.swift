//
//  StorageModel.swift
//  Tools
//
//  Created by Almaz Ibragimov on 25.08.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import Foundation

public protocol StorageModel: AnyObject {
    
    // MARK: - Instance Properties
    
    var identifier: String { get }
    
    var viewContext: StorageContext { get }
    
    // MARK: - Initializers
    
    init(identifier: String)
}
