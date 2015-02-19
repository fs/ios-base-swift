//
//  UIBarButtonItem+Extensions.m
//  Meloman
//
//  Created by vyacheslav artemev on 8/29/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIBarButtonItem+Extensions.h"

@implementation UIBarButtonItem (Extensions)

+ (UIBarButtonItem*)itemWithImage:(UIImage *)defaultImage
                           target:(id)target
                           action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:defaultImage forState:UIControlStateNormal];
    button.frame = CGRectMake(0.0, 0.0, defaultImage.size.width, defaultImage.size.height);
    [button addTarget:target
               action:action
     forControlEvents:UIControlEventTouchDown];
    
    UIView *buttonWrapper = [[UIView alloc] initWithFrame:button.frame];
    [buttonWrapper addSubview:button];
    
    UIBarButtonItem *toReturn = [[UIBarButtonItem alloc] initWithCustomView:buttonWrapper];

    return toReturn;
}

+ (UIBarButtonItem*)itemWithImage:(UIImage *)defaultImage
                    disabledImage:(UIImage *)disabledImage
                           target:(id)target
                           action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:defaultImage forState:UIControlStateNormal];
    [button setBackgroundImage:disabledImage forState:UIControlStateDisabled];
    button.frame = CGRectMake(0.0, 0.0, defaultImage.size.width, defaultImage.size.height);
    [button addTarget:target
               action:action
     forControlEvents:UIControlEventTouchDown];
    
    UIView *buttonWrapper = [[UIView alloc] initWithFrame:button.frame];
    [buttonWrapper addSubview:button];
    
    UIBarButtonItem *toReturn = [[UIBarButtonItem alloc] initWithCustomView:buttonWrapper];
    
    return toReturn;
}


+ (UIButton *)buttonWithNavigationItem:(UINavigationItem *)item
                                target:(id)target
                                action:(SEL)action
                          defaultImage:(UIImage *)deafultImage
                         disabledImage:(UIImage *)disabledImage {    
    UIImage *createButtonImage = deafultImage;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:createButtonImage forState:UIControlStateNormal];
    [button setBackgroundImage:disabledImage forState:UIControlStateDisabled];
    button.frame = CGRectMake(0.0, 0.0, createButtonImage.size.width, createButtonImage.size.height);
    [button addTarget:target
               action:action
     forControlEvents:UIControlEventTouchDown];
    UIView *buttonWrapper = [[UIView alloc] initWithFrame:button.frame];
    [buttonWrapper addSubview:button];
    item.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonWrapper];
    return button;
}
+ (UIBarButtonItem*)itemWithImage:(NSString *)defaultImage
                    selectedImage:(NSString *)selectedImage
                             text:(NSString *)text
                           target:(id)target
                           action:(SEL)action{
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *setImg = [UIImage imageNamed:defaultImage];
    UIImage *setImg2 = [UIImage imageNamed:selectedImage];
    
    [saveButton setBackgroundImage:setImg forState:UIControlStateNormal];
    if (setImg2) [saveButton setBackgroundImage:setImg2 forState:UIControlStateHighlighted];
    
    saveButton.frame = CGRectMake(0,0,setImg.size.width,setImg.size.height);
    [saveButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    if (text) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, saveButton.frame.size.width, saveButton.frame.size.height)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:13.0];
        label.minimumScaleFactor = 9.0;
        label.adjustsFontSizeToFitWidth = YES;
        label.textColor = [UIColor colorWithRed:247.f/255.f green:253.f/255.f blue:255/255.f alpha:1.f];
        label.shadowColor = [UIColor colorWithRed:50.f/255.f green:57.f/255.f blue:59.f/255.f alpha:1.f];
        label.shadowOffset = CGSizeMake(0, 1);
        label.text = text;
        [saveButton addSubview:label];
    }
    
    UIBarButtonItem *barButtonSettings = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    return barButtonSettings;
}
+ (UIBarButtonItem*)itemWithImage:(NSString *)defaultImage
                    selectedImage:(NSString *)selectedImage
                             text:(NSString *)text
                        textColor:(UIColor *)textColor
                      shadowColor:(UIColor *)shadowColor
                           target:(id)target
                           action:(SEL)action{
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *setImg = [UIImage imageNamed:defaultImage];
    UIImage *setImg2 = [UIImage imageNamed:selectedImage];
    
    [saveButton setBackgroundImage:setImg forState:UIControlStateNormal];
    if (setImg2) [saveButton setBackgroundImage:setImg2 forState:UIControlStateHighlighted];
    
    saveButton.frame = CGRectMake(0,0,setImg.size.width,setImg.size.height);
    [saveButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    if (text) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, saveButton.frame.size.width, saveButton.frame.size.height - 1)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:13.0];
        label.textColor = textColor;
        label.shadowColor = shadowColor;
        label.shadowOffset = CGSizeMake(0, 1);
        label.text = text;
        [saveButton addSubview:label];
    }
    
    UIBarButtonItem *barButtonSettings = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    return barButtonSettings;
}

@end
