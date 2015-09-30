//
//  FSE+StringTests.swift
//  Swift-Base
//
//  Created by Kruperfone on 24.09.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import XCTest
@testable import Swift_Base

class FSE_StringTests: XCTestCase {
    
    func generateRandomString () -> String {
        
        var result = ""
        
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789\n\n\n"
        let lenght = 100 + arc4random_uniform(100)
        
        for _ in 0 ..< lenght {
            let index = Int(arc4random_uniform(UInt32(letters.characters.count)))
            let stringIndex = letters.startIndex.advancedBy(index)
            let char = letters[stringIndex]
            result.append(char)
        }
        
        return result
    }
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetRowHeight () {
        for _ in 0 ..< 5 {
            let string = self.generateRandomString()
            let font = UIFont.systemFontOfSize(UIFont.systemFontSize())
            
            let etalon = string.getStringHeight(font, width: CGFloat.max)
            
            XCTAssertEqual(etalon, string.getRowHeight(font), "Must be equal")
        }
    }
    
    func testGetLineCount () {
        for _ in 0 ..< 5 {
            let string = self.generateRandomString()
            let font = UIFont.systemFontOfSize(UIFont.systemFontSize())
            
            let rowHeight = string.getRowHeight(font)
            let etalon = Int(ceil(rowHeight / font.lineHeight))
            
            XCTAssertEqual(etalon, string.getLineCount(font), "Must be equal")
        }
    }
    
    func testURLEncodedString () {
        let test1 = "https://app.web/api/v1/people?name=flat&family=stack"
        let test2 = "HTTPS://APP.WEB/API/V1/PEOPLE?NAME=FLAT&FAMILY=STACK"
        let test3 = "https://app.web/api/v1/people?name=флэт&family=стэк"
        
        let etalonFunc = {(string: String) -> String? in
            let result = string.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
            return result
        }
        
        XCTAssertEqual(etalonFunc(test1), test1.URLEncodedString(), "Must convert equal")
        XCTAssertEqual(etalonFunc(test2), test2.URLEncodedString(), "Must convert equal")
        XCTAssertEqual(etalonFunc(test3), test3.URLEncodedString(), "Must convert equal")
    }
    
    func testURLDecodedString () {
        let test1 = "https://app.web/api/v1/people?name=flat&family=stack"
        let test2 = "HTTPS://APP.WEB/API/V1/PEOPLE?NAME=FLAT&FAMILY=STACK"
        let test3 = "https://app.web/api/v1/people?name=флэт&family=стэк"
        
        let etalonFunc = {(string: String) -> String? in
            let result = string.stringByRemovingPercentEncoding
            return result
        }
        
        XCTAssertEqual(etalonFunc(test1), test1.URLDecodedString(), "Must convert equal")
        XCTAssertEqual(etalonFunc(test2), test2.URLDecodedString(), "Must convert equal")
        XCTAssertEqual(etalonFunc(test3), test3.URLDecodedString(), "Must convert equal")
    }
    
    func testEmailValidate () {
        let valid = "address@mail.com"
        
        let invalid1 = "address%mail.com"
        let invalid2 = "address@mail,com"
        let invalid3 = "address@mail."
        let invalid4 = "@mail.com"
        let invalid5 = "адрес@mail.com"
        
        XCTAssertTrue(valid.emailValidate(), "Must be valid")
        
        XCTAssertFalse(invalid1.emailValidate(), "Must be invalid")
        XCTAssertFalse(invalid2.emailValidate(), "Must be invalid")
        XCTAssertFalse(invalid3.emailValidate(), "Must be invalid")
        XCTAssertFalse(invalid4.emailValidate(), "Must be invalid")
        XCTAssertFalse(invalid5.emailValidate(), "Must be invalid")
    }
    
    func testGetStringWidth () {
        
        let font = UIFont.systemFontOfSize(UIFont.systemFontSize())
        
        for _ in 0 ..< 5 {
            let height = CGFloat(50 + arc4random_uniform(200))
            let string = self.generateRandomString()
            
            let boundingSize:CGSize = CGSizeMake(CGFloat.max, height)
            
            let attributes = [NSFontAttributeName:font]
            
            let options : NSStringDrawingOptions = unsafeBitCast(
                NSStringDrawingOptions.UsesLineFragmentOrigin.rawValue |
                    NSStringDrawingOptions.UsesFontLeading.rawValue,
                NSStringDrawingOptions.self)
            
            let text = string as NSString
            
            let rect = text.boundingRectWithSize(boundingSize, options:options, attributes: attributes, context:nil)
            
            let width = ceil(rect.size.width)
            
            XCTAssertEqual(width, string.getStringWidth(font, height: height), "Width must be equal")
        }
    }
    
    func testGetStringHeight () {
        let font = UIFont.systemFontOfSize(UIFont.systemFontSize())
        
        for _ in 0 ..< 5 {
            let width = CGFloat(50 + arc4random_uniform(200))
            let string = self.generateRandomString()
            
            let boundingSize:CGSize = CGSizeMake(width, CGFloat.max)
            
            let attributes = [NSFontAttributeName:font]
            
            let options : NSStringDrawingOptions = unsafeBitCast(
                NSStringDrawingOptions.UsesLineFragmentOrigin.rawValue |
                    NSStringDrawingOptions.UsesFontLeading.rawValue,
                NSStringDrawingOptions.self)
            
            let text = string as NSString
            
            let rect = text.boundingRectWithSize(boundingSize, options:options, attributes: attributes, context:nil)

            
            let height = ceil(rect.size.height)
            
            XCTAssertEqual(height, string.getStringHeight(font, width: width), "Height must be equal")
        }
    }
}
