//
//  InterfaceTests.swift
//  Swift-Base
//
//  Created by Никита Фомин on 10.03.15.
//  Copyright (c) 2015 Flatstack. All rights reserved.
//

import UIKit
import XCTest
import KIF

class InterfaceTests: KIFTestCase {
    
    override func beforeAll() {
        super.beforeAll()
    }
    
    override func afterAll() {
        super.afterAll()
    }
    
    override func beforeEach() {
        super.beforeEach()
    }
    
    override func afterEach() {
        super.afterEach()
    }
    
    func testExample() {
        tester().waitForViewWithAccessibilityLabel("Hello World!")
        tester().tapViewWithAccessibilityLabel("Tap to show alert")
        tester().tapViewWithAccessibilityLabel("OK")
        //tester().waitForTimeInterval(1)
    }
    
}
