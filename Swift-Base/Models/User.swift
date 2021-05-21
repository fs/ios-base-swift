//
//  User.swift
//  Swift-Base
//
//  Created by Евгений Самарин on 21.05.2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation
import CoreData
import Apollo

class User: NSManagedObject {

    // MARK: - Instance Properties

    var username: String? {
        var fullName = self.firstName ?? ""

        if self.lastName?.isEmpty == false {
            if fullName.isEmpty == false {
                fullName = "\(fullName) \(self.lastName ?? "")"
            } else {
                fullName = self.lastName ?? ""
            }
        }

        return fullName
    }
}
