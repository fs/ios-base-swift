//
//  ViewController.swift
//  Swift-Base
//
//  Created by Flatstack on 13.02.15.
//  Copyright (c) 2015 Flatstack. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Instance Properties
    
    @IBOutlet fileprivate weak var label: UILabel!
    
    // MARK: - Instance Methods
    
    @IBAction fileprivate func tapShowAlert(_ sender: AnyObject) {
        let alertController = UIAlertController(title: nil, message: "Press OK", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        self.present(alertController, animated: true)
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
