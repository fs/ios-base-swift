#ifdef SDWebImage
#import "UIImageView+Caching.h"
#import "SDImageCache.h"
#endif
#import "Helpers.h"

@implementation UIImageView (Utils)

#pragma mark - Image caching

#ifdef SDWebImage
- (void)setImageWithCachingKey:(NSString *)key andPlaceholderImageName:(NSString *)placeholderName {
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    UIImage *imageFromMemory = [imageCache imageFromMemoryCacheForKey:key];
    if (!imageFromMemory) {
        [imageCache queryDiskCacheForKey:key done:^(UIImage *image, SDImageCacheType cacheType) {
            if (image)
                self.image = image;
            else
                [self setImageWithURL:[NSURL URLWithString:key]
                         placeholderImage:[UIImage imageNamed:placeholderName]
                                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                                     if (image)
                                         [imageCache storeImage:image forKey:key toDisk:YES];
                                    
                }];
        }];
    } else {
        self.image = imageFromMemory;
    }
}

- (void)setImageWithCachingKey:(NSString *)key andPlaceholderImage:(UIImage *)placeholderImage {
    SDImageCache *imageCache = [SDImageCache sharedImageCache];
    UIImage *imageFromMemory = [imageCache imageFromMemoryCacheForKey:key];
    if (!imageFromMemory) {
        [imageCache queryDiskCacheForKey:key done:^(UIImage *image, SDImageCacheType cacheType) {
            if (image)
                self.image = image;
            else
                [self setImageWithURL:[NSURL URLWithString:key]
                         placeholderImage:placeholderImage
                                completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                                    if (image)
                                        [imageCache storeImage:image forKey:key toDisk:YES];
                                    
                                }];
        }];
    } else {
        self.image = imageFromMemory;
    }
}
#endif

#pragma mark - Rounded images

-(void) enableCircleMaskWithMaskRect:(CGRect)maskRect {
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, nil, maskRect);
    maskLayer.path = path;
    CGPathRelease(path);
    self.layer.mask = maskLayer;
}

- (void)makeImageRounded {
    self.clipsToBounds = YES;
    self.layer.cornerRadius = self.frame.size.width/2;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 0.5f;
}


@end
