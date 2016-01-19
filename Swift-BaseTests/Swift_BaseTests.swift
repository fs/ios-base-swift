//
//  Swift_BaseTests.swift
//  Swift-BaseTests
//
//  Created by Kruperfone on 22.09.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import XCTest
@testable import Swift_Base

class Swift_BaseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    func testApiGetRequest() {
        let expect = self.expectationWithDescription("completion handler called")
        let manager = APIManager.sharedInstance
        manager.GET("get", params:["show_env":1], success: { (operation, responseObject) -> Void in
            print("Result: \(responseObject)")
            expect.fulfill()
            }) { (operation, error) -> Void in
                print("Error: \(error)")
        }
     waitForExpectationsWithTimeout(10, handler: nil)
    }
    
    func testApiPostRequest() {
        let expect = self.expectationWithDescription("completion handler called")
        let manager = APIManager.sharedInstance
        manager.POST("post", params: ["test":"request"], success: { (operation, responseObject) -> Void in
            print("Result: \(responseObject)")
            expect.fulfill()
            }) { (operation, error) -> Void in
                 print("Error: \(error)")
        }
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
}
