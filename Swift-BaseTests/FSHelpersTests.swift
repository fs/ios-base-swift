//
//  FSHelpersTest.swift
//  Swift-Base
//
//  Created by Kruperfone on 22.09.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import XCTest
@testable import Swift_Base

class FSHelperTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //MARK: - Application Directory
    
    func testApplicationDirectoryPath () {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first!
        let cashesPath = NSSearchPathForDirectoriesInDomains(.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).first!
        
        XCTAssertEqual(documentsPath, ApplicationDirectoryPath(.DocumentDirectory), "Must be equal")
        XCTAssertEqual(cashesPath, ApplicationDirectoryPath(.CachesDirectory), "Must be equal")
    }
    
    func testApplicationDirectoryURL () {
        let documentsPathURL = NSURL(string: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first!)
        let cashesPathURL = NSURL(string: NSSearchPathForDirectoriesInDomains(.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).first!)!
        
        XCTAssertEqual(documentsPathURL, ApplicationDirectoryURL(.DocumentDirectory), "Must be equal")
        XCTAssertEqual(cashesPathURL, ApplicationDirectoryURL(.CachesDirectory), "Must be equal")
    }
    
    //MARK: - Interface
    
    func testScreenBounds () {
        XCTAssertEqual(UIScreen.mainScreen().bounds, ScreenBounds, "Must be equal")
    }
    
    func testIsIPad () {
        let etalon = UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad
        XCTAssertEqual(etalon, IsIPad(), "Must be equal")
    }
    
    func testIsIPhone () {
        let etalon = UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone
        XCTAssertEqual(etalon, IsIPhone(), "Must be equal")
    }
    
    func testScaleFactor () {
        let etalon = UIScreen.mainScreen().scale
        XCTAssertEqual(etalon, ScaleFactor(), "Must be equal")
    }
    
    func testIsRetina () {
        let etalon = ScaleFactor() == 2
        XCTAssertEqual(etalon, IsRetina(), "Must be equal")
    }
    
    func testDeviceOrientation () {
        let etalon = UIDevice.currentDevice().orientation
        XCTAssertEqual(etalon, DeviceOrientation(), "Must be equal")
    }
    
    //MARK: - System Version
    
    func testSystemVersionEqualTo() {
        for i in 7 ... 9 {
            let version = "\(i)"
            let etalon = UIDevice.currentDevice().systemVersion.compare(version, options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedSame
            XCTAssertEqual(etalon, SystemVersionEqualTo(version), "Must be equal")
        }
    }
    
    func testSystemVersionGreatherThan() {
        for i in 7 ... 9 {
            let version = "\(i)"
            let etalon = UIDevice.currentDevice().systemVersion.compare(version, options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedDescending
            XCTAssertEqual(etalon, SystemVersionGreatherThan(version), "Must be equal")
        }
    }
    
    func testSystemVersionGreatherThanOrEqualTo() {
        for i in 7 ... 9 {
            let version = "\(i)"
            let etalon = UIDevice.currentDevice().systemVersion.compare(version, options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedAscending
            XCTAssertEqual(etalon, SystemVersionGreatherThanOrEqualTo(version), "Must be equal")
        }
    }
    
    func testSystemVersionLessThan() {
        for i in 7 ... 9 {
            let version = "\(i)"
            let etalon = UIDevice.currentDevice().systemVersion.compare(version, options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedAscending
            XCTAssertEqual(etalon, SystemVersionLessThan(version), "Must be equal")
        }
    }
    
    func testSystemVersionLessThanOrEqualTo() {
        for i in 7 ... 9 {
            let version = "\(i)"
            let etalon = UIDevice.currentDevice().systemVersion.compare(version, options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedDescending
            XCTAssertEqual(etalon, SystemVersionLessThanOrEqualTo(version), "Must be equal")
        }
    }
    
    //MARK: - Images and colors
    
    func testRGBA () {
        let count = 5
        
        for r in 0 ... count {
            for g in 0 ... count {
                for b in 0 ... count {
                    for a in 0 ... count {
                        let red     = CGFloat(r*255/count)
                        let green   = CGFloat(g*255/count)
                        let blue    = CGFloat(b*255/count)
                        let alpha   = CGFloat(a*100/count)
                        
                        let etalon = UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha/100)
                        let value = RGBA(red, g: green, b: blue, a: alpha/100)
                        
                        var eRedPointer:    CGFloat = -1
                        var eGreenPointer:  CGFloat = -1
                        var eBluePointer:   CGFloat = -1
                        var eAlphaPointer:  CGFloat = -1
                        
                        var vRedPointer:    CGFloat = -1
                        var vGreenPointer:  CGFloat = -1
                        var vBluePointer:   CGFloat = -1
                        var vAlphaPointer:  CGFloat = -1
                        
                        etalon.getRed(&eRedPointer, green: &eGreenPointer, blue: &eBluePointer, alpha: &eAlphaPointer)
                        value.getRed(&vRedPointer, green: &vGreenPointer, blue: &vBluePointer, alpha: &vAlphaPointer)
                        
                        XCTAssertTrue(eRedPointer       >= 0, "Must be greather or equal to zero")
                        XCTAssertTrue(eGreenPointer     >= 0, "Must be greather or equal to zero")
                        XCTAssertTrue(eBluePointer      >= 0, "Must be greather or equal to zero")
                        XCTAssertTrue(eAlphaPointer     >= 0, "Must be greather or equal to zero")
                        
                        XCTAssertTrue(vRedPointer       >= 0, "Must be greather or equal to zero")
                        XCTAssertTrue(vGreenPointer     >= 0, "Must be greather or equal to zero")
                        XCTAssertTrue(vBluePointer      >= 0, "Must be greather or equal to zero")
                        XCTAssertTrue(vAlphaPointer     >= 0, "Must be greather or equal to zero")
                        
                        XCTAssertEqual(Int(eRedPointer),    Int(vRedPointer),       "Red chanel must be equal")
                        XCTAssertEqual(Int(eGreenPointer),  Int(vGreenPointer),     "Green chanel must be equal")
                        XCTAssertEqual(Int(eBluePointer),   Int(vBluePointer),      "Blue chanel must be equal")
                        XCTAssertEqual(Int(eAlphaPointer),  Int(vAlphaPointer),     "Alpha chanel must be equal")
                    }
                }
            }
        }
    }
    
    func testImageFromColor () {
        let count = 5
        
        for r in 0 ... count {
            for g in 0 ... count {
                for b in 0 ... count {
                    let imageRed     = CGFloat(r*255/count)
                    let imageGreen   = CGFloat(g*255/count)
                    let imageBlue    = CGFloat(b*255/count)
                    
                    let color = UIColor(red: imageRed/255, green: imageGreen/255, blue: imageBlue/255, alpha: 1)
                    
                    let value = ImageFromColor(color)
                    
                    let imageRef: CGImageRef? = value.CGImage
                    
                    var bitmapBytesPerRow = 0
                    
                    //Get image width, height
                    let pixelsWide = CGImageGetWidth(imageRef)
                    let pixelsHigh = CGImageGetHeight(imageRef)
                    
                    // Declare the number of bytes per row. Each pixel in the bitmap in this
                    // example is represented by 4 bytes; 8 bits each of red, green, blue, and
                    // alpha.
                    let bytesPerPixel = 4
                    let bitsPerComponent = 8
                    
                    bitmapBytesPerRow = Int(pixelsWide) * bytesPerPixel
                    
                    // Use the generic RGB color space.
                    let colorSpace = CGColorSpaceCreateDeviceRGB()
                    
                    // Allocate memory for image data. This is the destination in memory
                    // where any drawing to the bitmap context will be rendered.
                    let bitmapData = UnsafeMutablePointer<UInt32>(calloc(pixelsWide*pixelsHigh, sizeof(UInt32)))
                    
                    
                    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue).rawValue | CGBitmapInfo.ByteOrder32Big.rawValue
                    
                    let context = CGBitmapContextCreate(bitmapData, pixelsWide, pixelsHigh, bitsPerComponent, bitmapBytesPerRow, colorSpace, bitmapInfo)
                    CGContextDrawImage(context, CGRectMake(0, 0, CGFloat(pixelsWide), CGFloat(pixelsHigh)), imageRef)
                    
                    XCTAssertEqual(1, pixelsHigh, "Height must 1 pixel")
                    XCTAssertEqual(1, pixelsHigh, "Width must 1 pixel")
                    
                    var currentPixel: UnsafeMutablePointer<UInt32> = bitmapData
                    
                    for _ in 0 ..< pixelsHigh {
                        for _ in 0 ..< pixelsWide {
                            
                            let currentColor: UInt32 = currentPixel[0]
                            
                            let red     = currentColor & 0xFF
                            let green   = (currentColor >> 8) & 0xFF
                            let blue    = (currentColor >> 16) & 0xFF
                            let _       = (currentColor >> 24) & 0xFF
                            
                            XCTAssertEqual(UInt32(imageRed),    red,    "Red must be equal")
                            XCTAssertEqual(UInt32(imageGreen),  green,  "Green must be equal")
                            XCTAssertEqual(UInt32(imageBlue),   blue,   "Blue must be equal")
                            
                            currentPixel++
                        }
                    }
                }
            }
        }
        
    }
    
    func testRandomColor () {
        let color: UIColor = RandomColor()
        XCTAssertNotNil(color, "Must not be nil")
    }
    
    //MARK: - GCD
    func testDispatch_after_short () {
        for i in 0 ..< 3 {
            let delay: Double = Double(i)/10
            
            let expectation = expectationWithDescription("Expectation")
            
            let startDate = NSDate()
            var interval: NSTimeInterval = 0
            
            dispatch_after_short(delay) { () -> Void in
                interval = abs(NSDate().timeIntervalSinceDate(startDate))
                expectation.fulfill()
            }
            
            self.waitForExpectationsWithTimeout(delay+0.01, handler: { (error: NSError?) -> Void in
                if error == nil {
                    XCTAssertGreaterThanOrEqual(interval, delay, "Too fast")
                } else {
                    XCTAssertTrue(false, "Too long")
                }
            })
        }
    }
    
    func testDLog () {
        DLog("It's a test")
    }
    
    //MARK: - ScreenTypeInch
    func testScreenTypeInchInit () {
        let size = UIScreen.mainScreen().bounds.size
        let type = ScreenTypeInch()
        
        XCTAssertEqual(type.size, size, "Sizes must be equal")
    }
    
    func testScreenTypeInchInitWithSize () {
        
        let size3_5 = CGSizeMake(320, 480)
        let size4   = CGSizeMake(320, 568)
        let size4_7 = CGSizeMake(375, 667)
        let size5_5 = CGSizeMake(414, 736)
        
        let type3_5     = ScreenTypeInch(size: size3_5)
        let type4       = ScreenTypeInch(size: size4)
        let type4_7     = ScreenTypeInch(size: size4_7)
        let type5_5     = ScreenTypeInch(size: size5_5)
        
        XCTAssertEqual(ScreenTypeInch._3_5,     type3_5,    "Must be 3.5 inch type")
        XCTAssertEqual(ScreenTypeInch._4,       type4,      "Must be 4 inch type")
        XCTAssertEqual(ScreenTypeInch._4_7,     type4_7,    "Must be 4.7 inch type")
        XCTAssertEqual(ScreenTypeInch._5_5,     type5_5,    "Must be 5.5 inch type")
        
        //Test default
        let defaultType = ScreenTypeInch(size: CGSizeZero)
        XCTAssertEqual(ScreenTypeInch._4, defaultType, "Default type must be 4 inch type")
    }
    
    func testGetScreenValue () {
        let value3_5:   CGFloat = 0
        let value4:     CGFloat = 1
        let value4_7:   CGFloat = 2
        let value5_5:   CGFloat = 3
        
        let result3_5     = ScreenTypeInch._3_5 .getScreenValue(value3_5: value3_5, value4: value4, value4_7: value4_7, value5_5: value5_5) as! CGFloat
        let result4       = ScreenTypeInch._4   .getScreenValue(value3_5: value3_5, value4: value4, value4_7: value4_7, value5_5: value5_5) as! CGFloat
        let result4_7     = ScreenTypeInch._4_7 .getScreenValue(value3_5: value3_5, value4: value4, value4_7: value4_7, value5_5: value5_5) as! CGFloat
        let result5_5     = ScreenTypeInch._5_5 .getScreenValue(value3_5: value3_5, value4: value4, value4_7: value4_7, value5_5: value5_5) as! CGFloat
        
        XCTAssertEqual(value3_5,    result3_5,  "Must be equal")
        XCTAssertEqual(value4,      result4,    "Must be equal")
        XCTAssertEqual(value4_7,    result4_7,  "Must be equal")
        XCTAssertEqual(value5_5,    result5_5,  "Must be equal")
    }
    
    func testGetScreenCGFloat () {
        let value3_5:   CGFloat = 0
        let value4:     CGFloat = 1
        let value4_7:   CGFloat = 2
        let value5_5:   CGFloat = 3
        
        let result3_5     = ScreenTypeInch._3_5 .getScreenCGFloat(value3_5: value3_5, value4: value4, value4_7: value4_7, value5_5: value5_5)
        let result4       = ScreenTypeInch._4   .getScreenCGFloat(value3_5: value3_5, value4: value4, value4_7: value4_7, value5_5: value5_5)
        let result4_7     = ScreenTypeInch._4_7 .getScreenCGFloat(value3_5: value3_5, value4: value4, value4_7: value4_7, value5_5: value5_5)
        let result5_5     = ScreenTypeInch._5_5 .getScreenCGFloat(value3_5: value3_5, value4: value4, value4_7: value4_7, value5_5: value5_5)
        
        XCTAssertEqual(value3_5,    result3_5,  "Must be equal")
        XCTAssertEqual(value4,      result4,    "Must be equal")
        XCTAssertEqual(value4_7,    result4_7,  "Must be equal")
        XCTAssertEqual(value5_5,    result5_5,  "Must be equal")
    }
    
    func testGetScreenCGFloatWithout3_5 () {
        let value4:     CGFloat = 1
        let value4_7:   CGFloat = 2
        let value5_5:   CGFloat = 3
        
        let result4       = ScreenTypeInch._4   .getScreenCGFloat(value4: value4, value4_7: value4_7, value5_5: value5_5)
        let result4_7     = ScreenTypeInch._4_7 .getScreenCGFloat(value4: value4, value4_7: value4_7, value5_5: value5_5)
        let result5_5     = ScreenTypeInch._5_5 .getScreenCGFloat(value4: value4, value4_7: value4_7, value5_5: value5_5)
        
        XCTAssertEqual(value4,      result4,    "Must be equal")
        XCTAssertEqual(value4_7,    result4_7,  "Must be equal")
        XCTAssertEqual(value5_5,    result5_5,  "Must be equal")
    }
}
