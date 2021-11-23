//
//  User.swift
//  Swift-Base
//
//  Created by Maksim Kapitonov on 23/11/2021.
//  Copyright © 2021 Flatstack. All rights reserved.
//

import Foundation
import CoreData
import Apollo

class User: NSManagedObject {

    // MARK: - Instance Properties

    var avatarURL: URL? {
        if let avatarURLRaw = self.avatarURLRaw {
            return URL(string: avatarURLRaw)
        } else {
            return nil
        }
    }

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
