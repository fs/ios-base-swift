//
//  LoggedPageViewController.swift
//  Tools
//
//  Created by Almaz Ibragimov on 01.01.2018.
//  Copyright © 2018 Flatstack. All rights reserved.
//

import UIKit

public class LoggedPageViewController: UIPageViewController {

    // MARK: - Instance Properties

    public fileprivate(set) final var isViewAppeared = false

    // MARK: - Initializers

    deinit {
        Log.i("deinit", sender: self)
    }

    // MARK: - Instance Methods

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        Log.i("didReceiveMemoryWarning()", sender: self)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        Log.i("viewDidLoad()", sender: self)

        self.isViewAppeared = false
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        Log.i("viewWillAppear()", sender: self)

        self.isViewAppeared = false
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        Log.i("viewDidAppear()", sender: self)

        self.isViewAppeared = true
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        Log.i("viewWillDisappear()", sender: self)
    }

    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        Log.i("viewDidDisappear()", sender: self)

        self.isViewAppeared = false
    }

    // MARK: -

    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        Log.i("prepare(for: \(String(describing: segue.identifier)))", sender: self)
    }
}
