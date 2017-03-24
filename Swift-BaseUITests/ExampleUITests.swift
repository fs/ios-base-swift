//
//  Swift_BaseUITests.swift
//  Swift-BaseUITests
//
//  Created by Nikita Asabin on 12.01.16.
//  Copyright © 2016 Flatstack. All rights reserved.
//


@testable import Swift_Base

import XCTest

class Swift_BaseUITests: XCTestCase {
    
    private var application: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        self.continueAfterFailure = false
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        self.application = XCUIApplication()
        self.application.launchWithTestEnvironment(settings: [
            ApplicationLaunchSettings.example("Some string")
        ])
        
        self.application.buttons["Tap to show alert"].tap()
        XCTAssertEqual(self.application.alerts.count, 1, "The alert view must be appeared")
        self.application.alerts.buttons["OK"].tap()
        XCTAssertEqual(self.application.alerts.count, 0, "The alert view must be dismissed")
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
