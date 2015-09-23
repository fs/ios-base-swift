//
//  FSE+UIImage.swift
//  Swift-Base
//
//  Created by Kruperfone on 23.09.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import UIKit

struct BitmapPixel {
    var r: UInt32
    var g: UInt32
    var b: UInt32
    var a: UInt32
    
    var color: UIColor {
        return UIColor( red:    CGFloat(self.r/255)/100,
                        green:  CGFloat(self.g/255)/100,
                        blue:   CGFloat(self.b/255)/100,
                        alpha:  CGFloat(self.a/255)/100)
    }
}

extension UIImage {
    
    func getBitmap () -> [[BitmapPixel]] {
        let imageRef: CGImageRef? = self.CGImage
        
        //Get image width, height
        let pixelsWide = CGImageGetWidth(imageRef)
        let pixelsHigh = CGImageGetHeight(imageRef)
        
        // Declare the number of bytes per row. Each pixel in the bitmap in this
        // example is represented by 4 bytes; 8 bits each of red, green, blue, and alpha.
        let bytesPerPixel = 4
        let bitsPerComponent = 8
        
        let bitmapBytesPerRow = Int(pixelsWide) * bytesPerPixel
        
        // Use the generic RGB color space.
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // Allocate memory for image data. This is the destination in memory
        // where any drawing to the bitmap context will be rendered.
        let bitmapData = UnsafeMutablePointer<UInt32>(calloc(pixelsWide*pixelsHigh, sizeof(UInt32)))
        
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue).rawValue | CGBitmapInfo.ByteOrder32Big.rawValue
        
        let context = CGBitmapContextCreate(bitmapData, pixelsWide, pixelsHigh, bitsPerComponent, bitmapBytesPerRow, colorSpace, bitmapInfo)
        CGContextDrawImage(context, CGRectMake(0, 0, CGFloat(pixelsWide), CGFloat(pixelsHigh)), imageRef)
        
        var currentPixel: UnsafeMutablePointer<UInt32> = bitmapData
        
        var bitmapArray: [[BitmapPixel]] = {
            var array: [[BitmapPixel]] = []
            for y in 0 ..< pixelsHigh {
                array.append([])
                for _ in 0 ..< pixelsWide {
                    array[y].append(BitmapPixel(r: 0, g: 0, b: 0, a: 0))
                }
            }
           return array
        }()
        
        for y in 0 ..< pixelsHigh {
            for x in 0 ..< pixelsWide {
                
                let currentColor: UInt32 = currentPixel[0]
                
                let red     = (currentColor >> 0)   & 0xFF
                let green   = (currentColor >> 8)   & 0xFF
                let blue    = (currentColor >> 16)  & 0xFF
                let alpha   = (currentColor >> 24)  & 0xFF
                
                let pixel = BitmapPixel(r: red, g: green, b: blue, a: alpha)
                bitmapArray[x][y] = pixel
                
                currentPixel++
            }
        }
        
        return bitmapArray
    }
}
