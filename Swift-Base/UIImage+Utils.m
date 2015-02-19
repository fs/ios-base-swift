#import <QuartzCore/QuartzCore.h>
#import "UIImage+Utils.h"

@implementation UIImage (Utils)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)imageFilledWithColor:(UIColor *)color {

    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, self.CGImage);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImage *flippedImage = [UIImage imageWithCGImage:img.CGImage
                                                scale:2 orientation: UIImageOrientationDownMirrored];
    return flippedImage;
}

- (CGSize)imageViewSizeForContentMode:(UIViewContentMode)contentMode width:(CGFloat)width height:(CGFloat)height {
    CGFloat sx = width / self.size.width;
    CGFloat sy = height / self.size.height;
    CGFloat s = 1.0;
    switch (contentMode) {
        case UIViewContentModeScaleAspectFit:
            s = fminf(sx, sy);
            return CGSizeMake(s * self.size.width, s * self.size.height);
            break;
            
        case UIViewContentModeScaleAspectFill:
            s = fmaxf(sx, sy);
            return CGSizeMake(s * self.size.width, s * self.size.height);
            break;
            
        case UIViewContentModeScaleToFill:
            return CGSizeMake(sx * self.size.width, sy * self.size.height);
            
        default:
            return CGSizeMake(s * self.size.width, s * self.size.height);
    }
}

#pragma mark - scale

+ (void)_createGraphicsBeginImageContextWithSize:(CGSize)size
{
    UIScreen *screen = [UIScreen mainScreen];
    if([screen respondsToSelector:@selector(scale)])
    {
        UIGraphicsBeginImageContextWithOptions(size, NO, screen.scale);
    }
    else
    {
        UIGraphicsBeginImageContext(size);
    }
}

+ (void)_clearGraphicsBeginImageContext
{
    UIGraphicsEndImageContext();
}

- (UIImage *) scaleToSize: (CGSize)size
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, size.width, size.height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    CGContextClearRect(context, CGRectMake(0, 0, size.width, size.height));
    
    switch (self.imageOrientation)
    {
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
        {
            CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), self.CGImage);
        }; break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        {
            ///!!!
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0.0f, -size.width);
            CGContextDrawImage(context, CGRectMake(0, 0, size.height, size.width), self.CGImage);
        }; break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
        {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -size.height, 0.0f);
            CGContextDrawImage(context, CGRectMake(0, 0, size.height, size.width), self.CGImage);
        }; break;
            
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
        {
            //!!!
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -size.width, -size.height);
            CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), self.CGImage);
        }; break;
            
        default:
            break;
    }
    
    CGImageRef scaledImage=CGBitmapContextCreateImage(context);
    
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    UIImage *image = [UIImage imageWithCGImage: scaledImage];
    
    CGImageRelease(scaledImage);
    
    return image;
}

- (UIImage *) scaleProportionalToSizeLow: (CGSize)aSize
{
    aSize = [self sizeProportionalToSizeLow:aSize];
    return [self scaleToSize:aSize];
}

- (UIImage *) scaleProportionalToSizeHigh: (CGSize)aSize
{
    aSize = [self sizeProportionalToSizeHigh:aSize];
    return [self scaleToSize:aSize];
}

#pragma mark - size

- (CGSize) sizeProportionalToSizeLow:(CGSize)aSize
{
    if (self.size.width > self.size.height)
    {
        aSize = CGSizeMake((self.size.width/self.size.height) * aSize.height, aSize.height);
    } else {
        aSize = CGSizeMake(aSize.width, (self.size.height/self.size.width) * aSize.width);
    }
    return aSize;
}

- (CGSize) sizeProportionalToSizeHigh: (CGSize)aSize
{
    if (self.size.width < self.size.height)
    {
        aSize = CGSizeMake((self.size.width/self.size.height) * aSize.height, aSize.height);
    } else {
        aSize = CGSizeMake(aSize.width, (self.size.height/self.size.width) * aSize.width);
    }
    return aSize;
}

#pragma mark - crop

- (UIImage *)imageCroppingForRect:(CGRect)targetRect
{
    [[self class] _createGraphicsBeginImageContextWithSize:targetRect.size];
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin.x = targetRect.origin.x * -1;
    thumbnailRect.origin.y = targetRect.origin.y * -1;
    thumbnailRect.size.width  = self.size.width;
    thumbnailRect.size.height = self.size.height;
    
    [self drawInRect:thumbnailRect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not crop image");
    
    [[self class] _clearGraphicsBeginImageContext];
    return newImage;
}

#pragma mark - type image

+ (NSString *)contentTypeForImageData:(NSData *)data
{
    uint8_t c;
    [data getBytes:&c length:1];
    
    switch (c) {
        case 0xFF:
            return @"image/jpg";
        case 0xD8:
            return @"image/jpeg";
        case 0x89:
            return @"image/png";
        case 0x47:
            return @"image/gif";
        case 0x49:
        case 0x4D:
            return @"image/tiff";
    }
    return nil;
}

#pragma mark - adding mask

+ (UIImage *)imageNamed:(NSString *)name withColor:(UIColor *)color
{
    UIImage *resultImage = [UIImage imageNamed:name];
    
    if (color)
    {
        [self _createGraphicsBeginImageContextWithSize:resultImage.size];
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGRect area = CGRectMake(0, 0, resultImage.size.width, resultImage.size.height);
        CGContextScaleCTM(ctx, 1, -1);
        CGContextTranslateCTM(ctx, 0, -area.size.height);
        CGContextSaveGState(ctx);
        CGContextClipToMask(ctx, area, resultImage.CGImage);
        [color set];
        CGContextFillRect(ctx, area);
        CGContextRestoreGState(ctx);
        CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
        CGContextDrawImage(ctx, area, resultImage.CGImage);
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        [self _clearGraphicsBeginImageContext];
    }
    
    return resultImage;
}

#pragma mark - the combination of two images

+ (UIImage *)combinationFirstImage:(UIImage *)fImage firstAlpha:(double)fAlpha firstRect:(CGRect)fRect toSecondImage:(UIImage *)sImage secondAlpha:(double)sAlpha secondRect:(CGRect)sRect resultSize:(CGSize)rSize
{
    [self _createGraphicsBeginImageContextWithSize:rSize];
    
    [sImage drawInRect:sRect blendMode:kCGBlendModeNormal alpha:sAlpha];
    [fImage drawInRect:fRect blendMode:kCGBlendModeNormal alpha:fAlpha];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    [self _clearGraphicsBeginImageContext];
    
    return result;
}

+ (UIImage *)combinationFirstImage:(UIImage *)fImage firstAlpha:(double)fAlpha toSecondImage:(UIImage *)sImage secondAlpha:(double)sAlpha resultSize:(CGSize)rSize
{
    return [self combinationFirstImage:fImage firstAlpha:fAlpha firstRect:CGRectMake(0.0f, 0.0f, fImage.size.width, fImage.size.height) toSecondImage:sImage secondAlpha:sAlpha secondRect:CGRectMake(0.0f, 0.0f, sImage.size.width, sImage.size.height) resultSize:rSize];
}

+ (UIImage *)combinationFirstImage:(UIImage *)fImage toSecondImage:(UIImage *)sImage resultSize:(CGSize)rSize
{
    return [self combinationFirstImage:fImage firstAlpha:1.0f toSecondImage:sImage secondAlpha:1.0f resultSize:rSize];
}

+ (UIImage *)combinationImages:(NSArray *)images rect:(NSArray *)rect alpha:(NSArray *)alpha resultSize:(CGSize)resSize
{
    UIImage *imageResult = nil;
    if (images.count && rect.count && alpha.count)
    {
        NSUInteger count = images.count;
        [self _createGraphicsBeginImageContextWithSize:resSize];
        for (int i = 0; i < count; i++)
        {
            UIImage *imageCurrent = [images objectAtIndex:i];
            
            CGRect rectCurrent = CGRectNull;
            NSValue *valueSecond = [rect objectAtIndex:i];
            [valueSecond getValue:&rectCurrent];
            
            CGFloat alphaCurrent = [[alpha objectAtIndex:i] doubleValue];
            
            [imageCurrent drawInRect:rectCurrent blendMode:kCGBlendModeNormal alpha:alphaCurrent];
        }
        imageResult = UIGraphicsGetImageFromCurrentImageContext();
        [self _clearGraphicsBeginImageContext];
    }
    return imageResult;
}

+ (UIImage *)combinationImages:(NSArray *)images rect:(NSArray *)rect resultSize:(CGSize)resSize
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:images.count];
    for (int i = 0; i < images.count; i++)
    {
        [array addObject:@1.0f];
    }
    return [UIImage combinationImages:images rect:rect alpha:[array copy] resultSize:resSize];
}

#pragma mark - add text

- (UIImage *)addText:(NSString *)textStr font:(UIFont *)font color:(UIColor *)color point:(CGPoint)point
{
    UIImage *result = nil;
    CGFloat red = 0.0f;
    CGFloat green = 0.0f;
    CGFloat blue = 0.0f;
    CGFloat alpha = 1.0f;
    
    BOOL isConverted = [color getRed:&red green:&green blue:&blue alpha:&alpha];
    if (!isConverted)
    {
        NSLog(@"Could not get the color scheme! Use [UIColor colorWithRed:green:blue:alpha:]");
    }
    else
    {
        [[self class] _createGraphicsBeginImageContextWithSize:self.size];
        [self drawAtPoint: CGPointZero];
        
        CGContextSetRGBFillColor(UIGraphicsGetCurrentContext(), red, green, blue, alpha);
        [textStr drawAtPoint:point withAttributes:@{NSFontAttributeName:font}];
        result = UIGraphicsGetImageFromCurrentImageContext();
        
        [[self class] _clearGraphicsBeginImageContext];
    }
    
    return result;
}

- (UIImage *)addText:(NSString *)textStr font:(UIFont *)font color:(UIColor *)color position:(TextPosition)position
{
    return [self addText:textStr font:font color:color position:position offset:CGPointZero];
}

- (UIImage *)addText:(NSString *)textStr font:(UIFont *)font color:(UIColor *)color position:(TextPosition)position offset:(CGPoint)offset
{
    CGSize sizeCountStr = [textStr boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                       options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                    attributes:@{NSFontAttributeName:font}
                       context:NULL].size;
    
    CGPoint point = CGPointZero;
    
    switch (position) {
        case TextPositionLeftTop:
        {
            point = CGPointMake(0.0f + offset.x, 0.0f + offset.y);
        }; break;
            
        case TextPositionCenterTop:
        {
            point = CGPointMake(((self.size.width - sizeCountStr.width) * 0.5f) + offset.x, 0.0f + offset.y);
        }; break;
            
        case TextPositionRigthTop:
        {
            point = CGPointMake((self.size.width - sizeCountStr.width) + offset.x, 0.0f + offset.y);
        }; break;
            
        case TextPositionLeftMiddle:
        {
            point = CGPointMake(0.0f + offset.x, ((self.size.width - sizeCountStr.width) * 0.5f) + offset.y);
        }; break;
            
        case TextPositionCenterMiddle:
        {
            point = CGPointMake(((self.size.width - sizeCountStr.width) * 0.5f) + offset.x, ((self.size.height - sizeCountStr.height) * 0.5f) + offset.y);
        }; break;
            
        case TextPositionRigthMiddle:
        {
            point = CGPointMake(0.0f + offset.x, (self.size.width - sizeCountStr.width) + offset.y);
        }; break;
            
        case TextPositionLeftBottom:
        {
            point = CGPointMake(0.0f + offset.x, (self.size.height - sizeCountStr.height) + offset.y);
        }; break;
            
        case TextPositionCenterBottom:
        {
            point = CGPointMake(((self.size.width - sizeCountStr.width) * 0.5f) + offset.x, (self.size.height - sizeCountStr.height) + offset.y);
        }; break;
            
        case TextPositionRigthBottom:
        {
            point = CGPointMake((self.size.width - sizeCountStr.width) + offset.x, (self.size.height - sizeCountStr.height) + offset.y);
        }; break;
            
        default:
            break;
    }
    
    return [self addText:textStr
                    font:font
                   color:color
                   point:point];
}

@end
