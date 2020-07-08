//
//  TransparentNavigationController.swift
//  YouMakeUp
//
//  Created by Oleg Gorelov on 08/04/2019.
//  Copyright © 2019 Flatstack. All rights reserved.
//

import UIKit

class TransparentNavigationController: LoggedNavigationController {

    // MARK: - Instance Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
    }
}
