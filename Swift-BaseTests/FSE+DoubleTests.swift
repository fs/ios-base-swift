//
//  FSE+DoubleTests.swift
//  Swift-Base
//
//  Created by Kruperfone on 24.09.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import XCTest
@testable import Swift_Base

class FSE_DoubleTests: XCTestCase {
    
    let value: Double = drand48()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDispatchTime () {
        for i in 0 ..< 3 {
            let delay: Double = Double(i)/10
            
            let expectation = expectationWithDescription("Expectation")
            
            let startDate = NSDate()
            var interval: NSTimeInterval = 0
            
            dispatch_after(delay.dispatchTime, dispatch_get_main_queue(), { () -> Void in
                interval = abs(NSDate().timeIntervalSinceDate(startDate))
                expectation.fulfill()
            })
            
            self.waitForExpectationsWithTimeout(delay+0.01, handler: { (error: NSError?) -> Void in
                if error == nil {
                    XCTAssertGreaterThanOrEqual(interval, delay, "Too fast")
                } else {
                    XCTAssertTrue(false, "Too long")
                }
            })
        }
    }
}