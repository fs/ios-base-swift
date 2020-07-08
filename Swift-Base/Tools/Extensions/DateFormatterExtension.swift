//
//  DateFormatterExtension.swift
//  Tools
//
//  Created by Timur Shafigullin on 15/04/2020.
//  Copyright © 2020 Flatstack. All rights reserved.
//

import Foundation

extension DateFormatter {

    // MARK: - Initializers

    public convenience init(dateFormat: String) {
        self.init()

        self.dateFormat = dateFormat
    }
}
