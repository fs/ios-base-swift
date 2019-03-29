//
//  PannableViewController.swift
//  Nicely
//
//  Created by Nikita Asabin on 3/18/19.
//  Copyright © 2019 Decision Accelerator. All rights reserved.
//

import Foundation
import UIKit

public class PannableViewController: LoggedViewController {
    
    // MARK: - Instance Properties
    
    var panGestureRecognizer: UIPanGestureRecognizer?
    var originalPosition: CGPoint?
    var currentPositionTouched: CGPoint?
    
    // MARK: - Instance Methods
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
        
        guard let gesture = self.panGestureRecognizer else {
            fatalError()
        }
        
        self.view.addGestureRecognizer(gesture)
    }
    
    // MARK: -
    
    @objc
    fileprivate func panGestureAction(_ panGesture: UIPanGestureRecognizer) {
        let translation = panGesture.translation(in: view)
        
         if translation.y < 0 { return }
        
        if panGesture.state == .began {
            self.originalPosition = view.center
            self.currentPositionTouched = panGesture.location(in: view)
        } else if panGesture.state == .changed {
            self.view.frame.origin = CGPoint(
                x: self.view.frame.origin.x,
                y: translation.y
            )
        } else if panGesture.state == .ended {
            let velocity = panGesture.velocity(in: view)
            
            if velocity.y >= 1500 || self.view.frame.height/translation.y < 3 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.frame.origin = CGPoint(
                        x: self.view.frame.origin.x,
                        y: self.view.frame.size.height
                    )
                }, completion: { (isCompleted) in
                    if isCompleted {
                        self.dismiss(animated: false, completion: nil)
                    }
                })
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    guard let position = self.originalPosition else {
                        fatalError()
                    }
                    
                    self.view.center = position
                })
            }
        }
    }
}
