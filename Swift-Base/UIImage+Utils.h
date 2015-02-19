#import <UIKit/UIKit.h>

typedef enum {
    TextPositionLeftTop,
    TextPositionCenterTop,
    TextPositionRigthTop,
    TextPositionLeftMiddle,
    TextPositionCenterMiddle,
    TextPositionRigthMiddle,
    TextPositionLeftBottom,
    TextPositionCenterBottom,
    TextPositionRigthBottom,
} TextPosition;

@interface UIImage (Utils)

//картинка из одного пикселя (1x1) указанного цвета
+ (UIImage *)imageWithColor:(UIColor *)color;

//заполняет прозрачные пиксели в картинке указанным цветом
- (UIImage *)imageFilledWithColor:(UIColor *)color;

//Подгоняет размер под картинку для UIImageView с указанным contentMode и размерами width и height
- (CGSize)imageViewSizeForContentMode:(UIViewContentMode)contentMode width:(CGFloat)width height:(CGFloat)height;


//изменение размеров изображения
- (UIImage *) scaleToSize: (CGSize)size;
- (UIImage *) scaleProportionalToSizeHigh: (CGSize)aSize;
- (UIImage *) scaleProportionalToSizeLow: (CGSize)aSize;

//получить пропорциональный размер
- (CGSize) sizeProportionalToSizeLow: (CGSize)aSize;
- (CGSize) sizeProportionalToSizeHigh: (CGSize)aSize;

//обрезание изображения по координатам
- (UIImage *)imageCroppingForRect:(CGRect)targetRect;

//проверка сигнатуры картинки
//возвращает в формате MIME
+ (NSString *)contentTypeForImageData:(NSData *)data;

//наложение на изображение цвет.
+ (UIImage *)imageNamed:(NSString *)name
              withColor:(UIColor *)color;

//совмещение картинок
/**Объединяет две картинки по указанным координатам.'\
 @param combinationFirstImage картинка для объединения UIImage'\
 @param firstAlpha алфа-канал для первой картинки double от 0.0f до 1.0f''\
 @param fRect область наложения картинки CGRect'\
 @param toSecondImage картинка для объединения UIImage'\
 @param secondAlpha алфа-канал для второй картинки double от 0.0f до 1.0f''\
 @param secondRect область наложения картинки CGRect'\
 @param resultSize размер возвращаемой картинки CGRect'\
 @return Возвращает UIImage*/
+ (UIImage *)combinationFirstImage:(UIImage *)fImage
                        firstAlpha:(double)fAlpha
                         firstRect:(CGRect)fRect
                     toSecondImage:(UIImage *)sImage
                       secondAlpha:(double)sAlpha
                        secondRect:(CGRect)sRect
                        resultSize:(CGSize)rSize;
+ (UIImage *)combinationFirstImage:(UIImage *)fImage
                        firstAlpha:(double)fAlpha
                     toSecondImage:(UIImage *)sImage
                       secondAlpha:(double)sAlpha
                        resultSize:(CGSize)rSize;
+ (UIImage *)combinationFirstImage:(UIImage *)fImage
                     toSecondImage:(UIImage *)sImage
                        resultSize:(CGSize)rSize;
/**Объединяет массив картинок по указанному массиву координат.'\
 @param images массив UIImage'\
 @param rect массив NSValue с CGRect'\
 @param alpha массив NSNumber с double от 0.0f до 1.0f'\
 @param resultSize размер возвращаемой картинки'\
 @return Возвращает UIImage в случае успеха или nil при передачи неверных и не полных параметров*/
+ (UIImage *)combinationImages:(NSArray *)images
                          rect:(NSArray *)rect
                         alpha:(NSArray *)alpha
                    resultSize:(CGSize)resSize;
+ (UIImage *)combinationImages:(NSArray *)images
                          rect:(NSArray *)rect
                    resultSize:(CGSize)resSize;

//добавление текста на картинку
- (UIImage *)addText:(NSString *)textStr
                font:(UIFont *)font
               color:(UIColor *)color
               point:(CGPoint)point;
- (UIImage *)addText:(NSString *)textStr
                font:(UIFont *)font
               color:(UIColor *)color
            position:(TextPosition)position;
- (UIImage *)addText:(NSString *)textStr
                font:(UIFont *)font
               color:(UIColor *)color
            position:(TextPosition)position
              offset:(CGPoint)offset;

@end
