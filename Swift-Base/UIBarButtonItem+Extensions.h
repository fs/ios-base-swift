//
//  UIBarButtonItem+Extensions.h
//  Meloman
//
//  Created by vyacheslav artemev on 8/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extensions)

+ (UIBarButtonItem*)itemWithImage:(UIImage *)defaultImage
                           target:(id)target
                           action:(SEL)action;
+ (UIBarButtonItem*)itemWithImage:(UIImage *)defaultImage
                    disabledImage:(UIImage *)disabledImage
                           target:(id)target
                           action:(SEL)action;

+ (UIButton *)buttonWithNavigationItem:(UINavigationItem *)item
                                target:(id)target
                                action:(SEL)action
                          defaultImage:(UIImage *)deafultImage
                         disabledImage:(UIImage *)disabledImage;

+ (UIBarButtonItem*)itemWithImage:(NSString *)defaultImage
                    selectedImage:(NSString *)selectedImage
                             text:(NSString *)text
                           target:(id)target
                           action:(SEL)action;

+ (UIBarButtonItem*)itemWithImage:(NSString *)defaultImage
                    selectedImage:(NSString *)selectedImage
                             text:(NSString *)text
                        textColor:(UIColor *)textColor
                      shadowColor:(UIColor *)shadowColor
                           target:(id)target
                           action:(SEL)action;

@end
