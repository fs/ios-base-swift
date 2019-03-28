//
//  WebMultiPartItem.swift
//  Tools
//
//  Created by Almaz Ibragimov on 22.03.2018.
//  Copyright © 2018 Flastack. All rights reserved.
//

import Foundation

public protocol WebMultiPartItem {
    
    // MARK: - Instance Properties
    
    var name: String { get }
    var fileName: String { get }
    var mimeType: String { get }
    
    var stream: InputStream { get }
    var streamLength: UInt64 { get }
}
