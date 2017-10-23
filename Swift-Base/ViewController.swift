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
        
        //Check if deep link is present. Must be in initial view controller
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        appDelegate.triggerDeepLinkIfPresent()
        
        // Usage API
          let _ = try! UsageWebAPI.ByMonth(Date()).validate().responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let result):
                    debugPrint(result)
                    break
                    
                case.failure(let error):
                    debugPrint(error)
                    break
                }
            })
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func tapShowAlert(_ sender: AnyObject) {
        UIAlertView(title: nil, message: "Press OK", delegate: nil, cancelButtonTitle: "OK").show()
    }
}
