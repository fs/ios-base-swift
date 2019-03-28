//
//  LoggedNavigationController.swift
//  Tools
//
//  Created by Almaz Ibragimov on 01.01.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import UIKit

public class LoggedNavigationController: UINavigationController {

    // MARK: - Instance Properties
    
    public fileprivate(set) final var isViewAppeared = false
    
    // MARK: - Initializers

    deinit {
        Log.high("deinit", from: self)
    }

    // MARK: - Instance Methods

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        Log.high("didReceiveMemoryWarning()", from: self)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        Log.high("viewDidLoad()", from: self)
        
        self.isViewAppeared = false
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        Log.high("viewWillAppear()", from: self)
        
        self.isViewAppeared = false
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        Log.high("viewDidAppear()", from: self)
        
        self.isViewAppeared = true
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        Log.high("viewWillDisappear()", from: self)
    }

    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        Log.high("viewDidDisappear()", from: self)
        
        self.isViewAppeared = false
    }
    
    // MARK: -
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        Log.high("prepare(for: \(String(describing: segue.identifier)))", from: self)
    }
}
