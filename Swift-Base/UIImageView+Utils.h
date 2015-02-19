
#import <UIKit/UIKit.h>
#ifdef SDWebImage
    #import "UIImageView+WebCache.h"
#endif
@interface UIImageView (Caching)

#ifdef SDWebImage
- (void)setImageWithCachingKey:(NSString *)key andPlaceholderImageName:(NSString *)placeholderName;

- (void)setImageWithCachingKey:(NSString *)key andPlaceholderImage:(UIImage *)placeholderImage;
#endif

-(void) enableCircleMaskWithMaskRect:(CGRect)maskRect;
- (void)makeImageRounded;

@end
