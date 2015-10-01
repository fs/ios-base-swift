//
//  FSE+UIImageTests.swift
//  Swift-Base
//
//  Created by Kruperfone on 24.09.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import XCTest
@testable import Swift_Base

class FSE_UIImageTests: XCTestCase {
    
    /*
    */
    ///Using image 5x5 where in first row R, G and B from 0 to 255, in second only R, in third only G, in fourth B and in last Alpha. 
    ///Changing with rule: 0-64-128-191-255
    let imageData = NSData(base64EncodedString: "iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAAXNSR0IArs4c6QAAAAlwSFlzAAAWJQAAFiUBSVIk8AAAABxpRE9UAAAAAgAAAAAAAAADAAAAKAAAAAMAAAACAAAAYGZo4mwAAAAsSURBVBgZJMiBCQAwDAJBR3M0N3M0+6EJB/KSNNtLsra7oxERFJQfZUZQ8A8AAP//A9dvYgAAACFJREFUY2BgYPjPwOAAxA1AvB+I/wMxBDgAqQYg3g/E/wHtXSVfd7sjBgAAAABJRU5ErkJggg==", options: NSDataBase64DecodingOptions(rawValue: 0))!
    
    let smallValue: CGFloat      = 64
    let mediumValue: CGFloat     = 128
    let largeValue: CGFloat      = 191
    
    //Create etalon colors
    var etalonColors: [[UIColor]] {
        return [
            [
                RGBA(0, 0, 0, 1),
                RGBA(self.smallValue,   self.smallValue,    self.smallValue,    1),
                RGBA(self.mediumValue,  self.mediumValue,   self.mediumValue,   1),
                RGBA(self.largeValue,   self.largeValue,    self.largeValue,    1),
                RGBA(255, 255, 255, 1)
            ],
            [
                RGBA(0, 0, 0, 1),
                RGBA(self.smallValue,   0, 0, 1),
                RGBA(self.mediumValue,  0, 0, 1),
                RGBA(self.largeValue,   0, 0, 1),
                RGBA(255, 0, 0, 1)
            ],
            [
                RGBA(0, 0, 0, 1),
                RGBA(0, self.smallValue,  0, 1),
                RGBA(0, self.mediumValue, 0, 1),
                RGBA(0, self.largeValue,  0, 1),
                RGBA(0, 255, 0, 1)
            ],
            [
                RGBA(0, 0, 0, 1),
                RGBA(0, 0, self.smallValue,  1),
                RGBA(0, 0, self.mediumValue, 1),
                RGBA(0, 0, self.largeValue,  1),
                RGBA(0, 0, 255, 1)
            ],
            [
                RGBA(0, 0, 0, 0),
                RGBA(0, 0, 0, 0.25098),
                RGBA(0, 0, 0, 0.501961),
                RGBA(0, 0, 0, 0.74902),
                RGBA(0, 0, 0, 1)
            ]
        ]
    }
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //MARK: - Bitmap Pixel
    func testInitValue () {
        for _ in 0 ..< 5 {
            let value: UInt32 = arc4random()
            
            let red     = UInt8((value >> 0)   & 0xFF)
            let green   = UInt8((value >> 8)   & 0xFF)
            let blue    = UInt8((value >> 16)  & 0xFF)
            let alpha   = UInt8((value >> 24)  & 0xFF)
            
            let pixel = BitmapPixel(value: value)
            
            XCTAssertEqual(red,     pixel.r, "Red is wrong")
            XCTAssertEqual(green,   pixel.g, "Green is wrong")
            XCTAssertEqual(blue,    pixel.b, "Blue is wrong")
            XCTAssertEqual(alpha,   pixel.a, "Alpha is wrong")
        }
    }
    
    func testInitColor () {
        for _ in 0 ..< 5 {
            let red     = UInt8(arc4random_uniform(255))
            let green   = UInt8(arc4random_uniform(255))
            let blue    = UInt8(arc4random_uniform(255))
            let alpha   = UInt8(arc4random_uniform(255))
            
            let color = UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: CGFloat(alpha)/255)
            let pixel = BitmapPixel(color: color)
            
            XCTAssertEqual(red,     pixel.r, "Red is wrong")
            XCTAssertEqual(green,   pixel.g, "Green is wrong")
            XCTAssertEqual(blue,    pixel.b, "Blue is wrong")
            XCTAssertEqual(alpha,   pixel.a, "Alpha is wrong")
        }
    }
    
    func testValue () {
        for _ in 0 ..< 5 {
            let value: UInt32 = arc4random()
            
            let pixel = BitmapPixel(value: value)
            
            XCTAssertEqual(value, pixel.value, "Value is wrong")
        }
    }
    
    func testColor () {
        for _ in 0 ..< 5 {
            let red     = UInt8(arc4random_uniform(255))
            let green   = UInt8(arc4random_uniform(255))
            let blue    = UInt8(arc4random_uniform(255))
            let alpha   = UInt8(arc4random_uniform(255))
            
            let color = UIColor(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: CGFloat(alpha)/255)
            let pixel = BitmapPixel(color: color)
            
            XCTAssertEqual(color.description, pixel.color.description, "Color is wrong")
        }
    }
    
    func testDescription () {
        for _ in 0 ..< 5 {
            let value: UInt32 = arc4random()
            
            let pixel = BitmapPixel(value: value)
            let etalon = "\(pixel.r)|\(pixel.g)|\(pixel.b)|\(pixel.a)"
            
            XCTAssertEqual(etalon, pixel.description, "Description is wrong")
        }
    }
    
    func testBrightness () {
        for _ in 0 ..< 5 {
            let value: UInt32 = arc4random()
            
            let pixel = BitmapPixel(value: value)
            let etalon = UInt8((CGFloat(UInt32(pixel.r) + UInt32(pixel.g) + UInt32(pixel.b))/(255*3))*255)
            
            XCTAssertEqual(etalon, pixel.brightness, "Brightness is wrong")
        }
    }
    
    //MARK: - Bitmap
    func testInitWithDataAndSize () {
        let width   = 10
        let height  = 20
        let data    = UnsafeMutablePointer<UInt32>(calloc(width*height, sizeof(UInt32)))
        
        for y in 0 ..< height {
            for x in 0 ..< width {
                data[y*width + x] = arc4random()
            }
        }
        
        let bitmap = Bitmap(data: data, size: (width, height))
        
        XCTAssertEqual(width,   bitmap.size.width, "Width is wrong")
        XCTAssertEqual(height,  bitmap.size.height, "Height is wrong")
        
        for y in 0 ..< height {
            for x in 0 ..< width {
                let etalon = data[y*width + x]
                let value = bitmap.data[y*bitmap.size.width + x]
                XCTAssertEqual(etalon, value, "Value is wrong (\(x)\(y))")
            }
        }
    }
    
    func testInitWithSize () {
        let width   = 10
        let height  = 20
        
        let bitmap = Bitmap(size: (width, height))
        
        XCTAssertEqual(width, bitmap.size.width, "Width is wrong")
        XCTAssertEqual(height, bitmap.size.height, "Height is wrong")
    }
    
    func testInitWithCGSize () {
        let width   = 10
        let height  = 20
        
        let bitmap = Bitmap(size: CGSizeMake(CGFloat(width), CGFloat(height)))
        
        XCTAssertEqual(width,   bitmap.size.width, "Width is wrong")
        XCTAssertEqual(height,  bitmap.size.height, "Height is wrong")
    }
    
    func testGetCGImage () {
        let etalon = Bitmap(size: (5, 5))
        for y in 0 ..< 5 {
            for x in 0 ..< 5 {
                etalon.setPixel(BitmapPixel(color: self.etalonColors[y][x]), point: (x, y))
            }
        }
        let image = UIImage(CGImage: etalon.getCGImage())
        
        let bitmap = image.getBitmap()
        
        XCTAssertEqual(5, bitmap.size.width,     "Width is wrong")
        XCTAssertEqual(5, bitmap.size.height,    "Height is wrong")
        
        for i in 0 ..< 5*5 {
            XCTAssertEqual(etalon.data[i], bitmap.data[i], "Data is wrong")
        }
    }
    
    func testGetUIImage () {
        let bitmap = Bitmap(size: (5, 5))
        for y in 0 ..< 5 {
            for x in 0 ..< 5 {
                bitmap.setPixel(BitmapPixel(color: self.etalonColors[y][x]), point: (x, y))
            }
        }
        
        let defaultImage    = bitmap.getUIImage()
        let scale1Image     = bitmap.getUIImage(1)
        let scale2Image     = bitmap.getUIImage(2)
        let scale3Image     = bitmap.getUIImage(3)
        let downImage       = bitmap.getUIImage(orientation: .Down)
        
        XCTAssertEqual(UIScreen.mainScreen().scale, defaultImage.scale, "Scale is wrong")
        XCTAssertEqual(UIImageOrientation.Up, defaultImage.imageOrientation, "Orientation is wrong")
        
        XCTAssertEqual(1, scale1Image.scale, "Scale is wrong")
        XCTAssertEqual(2, scale2Image.scale, "Scale is wrong")
        XCTAssertEqual(3, scale3Image.scale, "Scale is wrong")
        
        XCTAssertEqual(UIImageOrientation.Down, downImage.imageOrientation, "Image orientaion is wrong")
    }
    
    func testGetPixel () {
        let width   = 10
        let height  = 20
        let data    = UnsafeMutablePointer<UInt32>(calloc(width*height, sizeof(UInt32)))
        
        for y in 0 ..< height {
            for x in 0 ..< width {
                data[y*width + x] = arc4random()
            }
        }
        
        let bitmap = Bitmap(data: data, size: (width, height))
        
        for y in 0 ..< height {
            for x in 0 ..< width {
                let etalon  = BitmapPixel(value: data[width*y + x])
                let pixel   = bitmap.getPixel(x, y)
                
                XCTAssertEqual(etalon.value, pixel.value, "Pixel is wrong")
            }
        }
    }
    
    func testSetPixel () {
        let width   = 10
        let height  = 20
        
        let bitmap = Bitmap(size: (width, height))
        
        for y in 0 ..< height {
            for x in 0 ..< width {
                let etalon = arc4random()
                bitmap.setPixel(BitmapPixel(value: etalon), point: (x, y))
                
                XCTAssertEqual(etalon, bitmap.data[y*width + x], "Pixel is wrong")
            }
        }
    }
    
    //MARK: - UIImage Extensions
    func testGetBitmap () {
        let image = UIImage(data: self.imageData)!
        
        let bitmap = image.getBitmap()
        
        //Check size
        XCTAssertEqual(5, bitmap.size.height, "Wrong height")
        XCTAssertEqual(5, bitmap.size.width, "Wrong width")
        
        for y in 0 ..< bitmap.size.height {
            for x in 0 ..< bitmap.size.width {
                
                let color   = bitmap.getPixel(x, y).color
                let etalon  = self.etalonColors[y][x]
                
                XCTAssertEqual(etalon.description, color.description, "Wrong color at (\(x):\(y))")
            }
        }
        
    }
    
    func testBase64 () {
        let image = UIImage(data: self.imageData)!
        
        let imageData = UIImagePNGRepresentation(image)!
        let etalon = imageData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
        XCTAssertEqual(etalon, image.base64, "Must be equal")
    }
}
