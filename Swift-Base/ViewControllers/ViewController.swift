//
//  ViewController.swift
//  Swift-Base
//
//  Created by FS Flatstack on 13/02/2015.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Instance Properties

    @IBOutlet private weak var label: UILabel!

    // MARK: - Instance Methods

    @IBAction private func tapShowAlert(_ sender: AnyObject) {
        let alertController = UIAlertController(
            title: nil,
            message: R.string.localizable.press_ok(),
            preferredStyle: .alert
        )

        alertController.addAction(UIAlertAction(title: R.string.localizable.alert_ok(), style: .cancel))

        self.present(alertController, animated: true)
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
