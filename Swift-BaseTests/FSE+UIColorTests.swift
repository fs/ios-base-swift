//
//  FSE+UIColorTests.swift
//  Swift-Base
//
//  Created by Kruperfone on 24.09.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import XCTest
@testable import Swift_Base

class FSE_UIColorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitWithHexAndAlpha () {
        for _ in 0 ..< 5 {
            let red     = CGFloat(arc4random_uniform(255))/255.0
            let green   = CGFloat(arc4random_uniform(255))/255.0
            let blue    = CGFloat(arc4random_uniform(255))/255.0
            let alpha   = CGFloat(arc4random_uniform(255))/255.0
            
            let hexString = NSString(format: "%02x%02x%02x", (Int(red*255)), (Int(green*255)), (Int(blue*255))) as String
            
            let color           = UIColor(red: red, green: green, blue: blue, alpha: alpha)
            let defaultColor    = UIColor(red: red, green: green, blue: blue, alpha: 1)
            
            let result          = UIColor(hexString: hexString, alpha: alpha)!
            let defaultResult   = UIColor(hexString: hexString)!
            
            XCTAssertEqual(color.description, result.description, "Must be equal")
            XCTAssertEqual(defaultColor.description, defaultResult.description, "Must be equal")
        }
    }
    
    func testHexString() {
        for _ in 0 ..< 5 {
            let red     = CGFloat(arc4random_uniform(255))/255.0
            let green   = CGFloat(arc4random_uniform(255))/255.0
            let blue    = CGFloat(arc4random_uniform(255))/255.0
            
            let etalon = NSString(format: "%02x%02x%02x", (Int(red*255)), (Int(green*255)), (Int(blue*255))) as String
            let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
            
            XCTAssertEqual(etalon, color.hexString(), "Must be equal")
        }
    }
}
