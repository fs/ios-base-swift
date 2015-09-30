//
//  FSE+UIViewTests.swift
//  Swift-Base
//
//  Created by Kruperfone on 24.09.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import XCTest
@testable import Swift_Base

class FSE_UIViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //MARK: - Set size
    
    func testSize () {
        let view = UIView(frame: CGRectMake(100, 200, 300, 400))
        XCTAssertEqual(view.frame.size, view.size, "Must be equal")
        
        let newSize = CGSizeMake(350, 450)
        view.size = CGSizeMake(350, 450)
        
        XCTAssertEqual(view.frame.size, newSize, "Must be equal")
    }
    
    func testWidth () {
        let view = UIView(frame: CGRectMake(100, 200, 300, 400))
        XCTAssertEqual(view.frame.size.width, view.width, "Must be equal")
        
        let newWidth: CGFloat = 350
        view.width = newWidth
        
        XCTAssertEqual(view.frame.size.width, newWidth, "Must be equal")
    }
    
    func testHeight () {
        let view = UIView(frame: CGRectMake(100, 200, 300, 400))
        XCTAssertEqual(view.frame.size.height, view.height, "Must be equal")
        
        let newHeight: CGFloat = 450
        view.height = newHeight
        
        XCTAssertEqual(view.frame.size.height, newHeight, "Must be equal")
    }
    
    //MARK: - Set origin
    
    func testOrigin () {
        let view = UIView(frame: CGRectMake(100, 200, 300, 400))
        XCTAssertEqual(view.frame.origin, view.origin, "Must be equal")
        
        let newOrigin = CGPoint(x: 150, y: 250)
        view.origin = newOrigin
        
        XCTAssertEqual(view.frame.origin, newOrigin, "Must be equal")
    }
    
    func testX () {
        let view = UIView(frame: CGRectMake(100, 200, 300, 400))
        XCTAssertEqual(view.frame.origin.x, view.x, "Must be equal")
        
        let newX: CGFloat = 150
        view.x = newX
        
        XCTAssertEqual(view.frame.origin.x, newX, "Must be equal")
    }
    
    func testY () {
        let view = UIView(frame: CGRectMake(100, 200, 300, 400))
        XCTAssertEqual(view.frame.origin.y, view.y, "Must be equal")
        
        let newY: CGFloat = 250
        view.y = newY
        
        XCTAssertEqual(view.frame.origin.y, newY, "Must be equal")
    }
}
