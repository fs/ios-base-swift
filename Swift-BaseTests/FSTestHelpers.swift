//
//  FSTestHelpers.swift
//  Adme
//
//  Created by Kruperfone on 21.09.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import Foundation

enum TestingMode: String {
    case Unit   = "Unit"
    case UI     = "UI"
    
    init () {
        let environments = NSProcessInfo.processInfo().environment
        guard let modeString = environments["Testing"] else {
            fatalError("Testing mode not defined")
        }
        
        switch modeString {
        case TestingMode.Unit.rawValue:
            self = .Unit
            
        case TestingMode.UI.rawValue:
            self = .UI
            
        default:
            fatalError("Testing mode is wrong")
        }
    }
}

func HasLaunchArgument (argument: String) -> Bool {
    let arguments = NSProcessInfo.processInfo().arguments
    return arguments.contains(argument)
}

func GetEnvironment (key: String) -> String? {
    let environments = NSProcessInfo.processInfo().environment
    return environments[key]
}
