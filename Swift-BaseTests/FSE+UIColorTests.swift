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
    
    func testHexString() {
        let colorBlack = UIColor.blackColor()
        XCTAssertEqual(colorBlack.hexString(), "000000", "Must be equal")
        
        let colorRed = UIColor.redColor()
         XCTAssertEqual(colorRed.hexString(), "ff0000", "Must be equal")
        
        let colorBlue = UIColor.blueColor()
        XCTAssertEqual(colorBlue.hexString(), "0000ff", "Must be equal")
        
        let colorGreen = UIColor.greenColor()
        XCTAssertEqual(colorGreen.hexString(), "00ff00", "Must be equal")
        
        let colorWhite = UIColor.whiteColor()
        XCTAssertEqual(colorWhite.hexString(), "ffffff", "Must be equal")
    }
}
