//
//  GVAligmentCollectionViewFlowLayout.h
//  Swift-Base
//
//  Created by Vladimir Goncharov on 05.12.14.
//  Copyright (c) 2014 Flatstack. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GVAligmentCollectionViewFlowLayoutAligmentVertical)
{
    GVAligmentCollectionViewFlowLayoutAligmentVerticalTop,
    GVAligmentCollectionViewFlowLayoutAligmentVerticalCenter,
    GVAligmentCollectionViewFlowLayoutAligmentVerticalBottom
};

typedef NS_ENUM(NSUInteger, GVAligmentCollectionViewFlowLayoutAligmentHorizontal)
{
    GVAligmentCollectionViewFlowLayoutAligmentHorizontalLeft,
    GVAligmentCollectionViewFlowLayoutAligmentHorizontalCenter,
    GVAligmentCollectionViewFlowLayoutAligmentHorizontalRight
};

@interface GVAligmentCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) GVAligmentCollectionViewFlowLayoutAligmentVertical verticalAligment;
@property (nonatomic, assign) GVAligmentCollectionViewFlowLayoutAligmentHorizontal horizontalAligment;

@end
