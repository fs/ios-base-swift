//
//  MessagePresenting.swift
//  YouMakeUp
//
//  Created by Timur Shafigullin on 21/01/2019.
//  Copyright © 2019 Flatstack. All rights reserved.
//

import UIKit

protocol MessagePresenting {

    // MARK: - Instance Properties

    var presenterController: UIViewController { get }

    // MARK: - Instance Methods

    func showMessage(withTitle title: String?, message: String?, okHandler: (() -> Void)?)
}

// MARK: -

extension MessagePresenting where Self: UIViewController {

    // MARK: - Instance Properties

    var presenterController: UIViewController {
        return self
    }

    // MARK: - Instance Methods

    func showMessage(withTitle title: String?, message: String?, okHandler: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "OK".localized(), style: .cancel, handler: { action in
            okHandler?()
        }))

        self.present(alertController, animated: true)
    }

    func showMessage(withTitle title: String?, message: String?) {
        self.showMessage(withTitle: title, message: message, okHandler: nil)
    }
}
