//
//  Constants.swift
//  Swift-Base
//
//  Created by Kruperfone on 02.10.14.
//  Copyright (c) 2014 Flatstack. All rights reserved.
//

import UIKit

/*--------------User Defaults keys-------------*/
enum FSUserDefaultsKey {
    
    enum DeviceToken {
        private static let Prefix = "FSDeviceToken"
        
        static let Data    = GenerateKey(Prefix, key: "Data")
        static let String  = GenerateKey(Prefix, key: "String")
    }
}

/*----------Notifications---------*/
enum FSNotificationKey {
    
    enum Example {
        private static let Prefix = "Example"
        
        static let Key = GenerateKey(Prefix, key: "Key")
    }
}

/*----------Colors----------*/
enum FSColors {
    static let AppColor = UIColor.clear
}

/*----------Helpers----------*/
private func GenerateKey (_ prefix: String, key: String) -> String {
    return "__\(prefix)-\(key)__"
}
