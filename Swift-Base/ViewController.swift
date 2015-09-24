//
//  ViewController.swift
//  Swift-Base
//
//  Created by Kruperfone on 13.02.15.
//  Copyright (c) 2015 Flatstack. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func tapShowAlert(sender: AnyObject) {
        UIAlertView(title: nil, message: "Press OK", delegate: nil, cancelButtonTitle: "OK").show()
    }
}
