//
//  FSE+UIImage.swift
//  Swift-Base
//
//  Created by Kruperfone on 23.09.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import UIKit

struct BitmapPixel {
    var r: UInt8
    var g: UInt8
    var b: UInt8
    var a: UInt8
    
    init (value: UInt32) {
        self.r  = UInt8((value >> 0)   & 0xFF)
        self.g  = UInt8((value >> 8)   & 0xFF)
        self.b  = UInt8((value >> 16)  & 0xFF)
        self.a  = UInt8((value >> 24)  & 0xFF)
    }
    
    init (color: UIColor) {
        var red:    CGFloat = -1
        var green:  CGFloat = -1
        var blue:   CGFloat = -1
        var alpha:  CGFloat = -1
        
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        self.r  = UInt8(red*255)
        self.g  = UInt8(green*255)
        self.b  = UInt8(blue*255)
        self.a  = UInt8(alpha*255)
    }
    
    var value: UInt32 {
        let red     = UInt32(self.r) << 0
        let green   = UInt32(self.g) << 8
        let blue    = UInt32(self.b) << 16
        let alpha   = UInt32(self.a) << 24
        
        let result = red+green+blue+alpha
        
        return result
    }
    
    var color: UIColor {
        return UIColor( red:    CGFloat(self.r/255)/100,
            green:  CGFloat(self.g/255)/100,
            blue:   CGFloat(self.b/255)/100,
            alpha:  CGFloat(self.a/255)/100)
    }
    
    private var brightness32: UInt32 {
        return UInt32(self.r) + UInt32(self.g) + UInt32(self.b)
    }
    
    var brightness: UInt8 {
        return UInt8((CGFloat(self.brightness32)/(255*3))*255)
    }
}

class Bitmap: NSObject {
    
    private var bytesPerRow: Int {
        return Int(self.size.width)
    }
    
    var data: UnsafeMutablePointer<UInt32>
    var size: (width: Int, height: Int)
    
    init (data: UnsafeMutablePointer<UInt32>, size: (Int, Int)) {
        self.size = size
        self.data = data
        super.init()
    }
    
    init (size: (width: Int, height: Int)) {
        self.size = size
        self.data = UnsafeMutablePointer<UInt32>(calloc(self.size.width*self.size.height, sizeof(UInt32)))
        super.init()
    }
    
    convenience init (size: CGSize) {
        self.init(size: (width: Int(size.width), height: Int(size.height)))
    }
    
    func getCGImage () -> CGImage {
        let image = UIImage.imageFromBitmap(self)
        return image
    }
    
    func getUIImage (scale: CGFloat = UIScreen.mainScreen().scale, orientation: UIImageOrientation = UIImageOrientation.Up) -> UIImage {
        let image = self.getCGImage()
        return UIImage(CGImage: image, scale: scale, orientation: orientation)
    }
    
    func getPixel (x: Int, _ y: Int) -> BitmapPixel {
        return BitmapPixel(value: self.data[self.index(x, y)])
    }
    
    func setPixel (pixel: BitmapPixel, point: (x: Int, y: Int)) {
        self.data[self.index(point.x, point.y)] = pixel.value
    }
    
    private func index (x: Int, _ y: Int) -> Int {
        return self.bytesPerRow*y + x
    }
}

extension UIImage {
    
    func getBitmap () -> Bitmap {
        let imageRef: CGImageRef? = self.CGImage
        
        //Get image width, height
        let pixelsWide = CGImageGetWidth(imageRef)
        let pixelsHigh = CGImageGetHeight(imageRef)
        
        // Declare the number of bytes per row. Each pixel in the bitmap in this
        // example is represented by 4 bytes; 8 bits each of red, green, blue, and alpha.
        let bytesPerPixel       = 4
        let bitsPerComponent    = 8
        
        let bitmapBytesPerRow = Int(pixelsWide) * bytesPerPixel
        
        // Use the generic RGB color space.
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // Allocate memory for image data. This is the destination in memory
        // where any drawing to the bitmap context will be rendered.
        let bitmapData = UnsafeMutablePointer<UInt32>(calloc(pixelsWide*pixelsHigh, sizeof(UInt32)))
        
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue).rawValue | CGBitmapInfo.ByteOrder32Big.rawValue
        
        let context = CGBitmapContextCreate(bitmapData, pixelsWide, pixelsHigh, bitsPerComponent, bitmapBytesPerRow, colorSpace, bitmapInfo)
        CGContextDrawImage(context, CGRectMake(0, 0, CGFloat(pixelsWide), CGFloat(pixelsHigh)), imageRef)
        
        return Bitmap(data: bitmapData, size: (pixelsWide, pixelsHigh))
    }
    
    class func imageFromBitmap (bitmap: Bitmap) -> CGImageRef {
        
        let width   = bitmap.size.width
        let height  = bitmap.size.height
        
        let bitsPerComponent    = 8
        let bytesPerPixel       = 4
        let bitsPerPixel        = bytesPerPixel * 8
        let bytesPerRow         = width * bytesPerPixel
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let renderingIntent = CGColorRenderingIntent.RenderingIntentDefault
        
        let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue).rawValue | CGBitmapInfo.ByteOrder32Big.rawValue)
        
        let bitmapData = bitmap.data
        
        let bufferLength = width * height * bytesPerPixel
        let provider = CGDataProviderCreateWithData(nil, bitmapData, bufferLength, nil)
        
        let image = CGImageCreate(width, height, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpace, bitmapInfo, provider, nil, true, renderingIntent)
        
        return image!
    }
}
