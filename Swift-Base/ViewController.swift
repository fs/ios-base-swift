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
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let side = 150
        let squareSide = 30
        let bitmap = Bitmap(size: (side, side))
        
        for line in 0 ..< 5 {
            for square in 0 ..< 5 {
                let color = RandomColor()
                
                let yStart = line*squareSide
                let yEnd = yStart+squareSide
                
                let xStart = square*squareSide
                let xEnd = xStart+squareSide
                
                for y in yStart ..< yEnd {
                    for x in xStart ..< xEnd {
                        bitmap.setPixel(BitmapPixel(color: color), point: (x, y))
                    }
                }
            }
        }
        
        self.imageView.image = bitmap.image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func tapShowAlert(sender: AnyObject) {
        UIAlertView(title: nil, message: "Press OK", delegate: nil, cancelButtonTitle: "OK").show()
    }
}
