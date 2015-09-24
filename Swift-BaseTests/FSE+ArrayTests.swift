//
//  FSE+ArrayTests.swift
//  Swift-Base
//
//  Created by Kruperfone on 24.09.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import XCTest
@testable import Swift_Base

class FSE_ArrayTests: XCTestCase {
    
    private let array: [Int] = {
        var arr: [Int] = []
        for i in 0 ..< 1000 {
            let random = Int(arc4random_uniform(100))
            arr.append(random)
        }
        return arr
    }()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testObjectAtIndexOrNil () {
        let array = self.array
        
        for i in 0 ..< array.count*2 {
            if i < array.count {
                XCTAssertNotNil(array.objectAtIndexOrNil(i), "Must not be nil")
            } else {
                XCTAssertNil(array.objectAtIndexOrNil(i), "Must be nil")
            }
        }
    }
    
    func testShuffle () {
        let array = self.array
        let shuffleArray = array.shuffle()
        let doubleShuffleArray = shuffleArray.shuffle()
        
        XCTAssertNotEqual(array,                shuffleArray,           "Must not be equal")
        XCTAssertNotEqual(shuffleArray,         doubleShuffleArray,     "Must not be equal")
        XCTAssertNotEqual(doubleShuffleArray,   array,                  "Must not be equal")
    }
    
}
