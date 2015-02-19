//
//  GVAligmentCollectionViewFlowLayout.m
//  Swift-Base
//
//  Created by Vladimir Goncharov on 05.12.14.
//  Copyright (c) 2014 Flatstack. All rights reserved.
//

#import "GVAligmentCollectionViewFlowLayout.h"

@implementation GVAligmentCollectionViewFlowLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray* attributesToReturn = [super layoutAttributesForElementsInRect:rect];
    for (UICollectionViewLayoutAttributes* attributes in attributesToReturn) {
        if (nil == attributes.representedElementKind) {
            NSIndexPath* indexPath = attributes.indexPath;
            attributes.frame = [self layoutAttributesForItemAtIndexPath:indexPath].frame;
        }
    }
    return attributesToReturn;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *currentItemAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    
//    switch (self.horizontalAligment)
//    {
//        case GVAligmentCollectionViewFlowLayoutAligmentHorizontalLeft:
//        {
//            return 
//        }; break;
//            
//        case GVAligmentCollectionViewFlowLayoutAligmentHorizontalCenter:
//        {
//            
//        }; break;
//            
//        case GVAligmentCollectionViewFlowLayoutAligmentHorizontalRight:
//        {
//            
//        }; break;
//            
//        default:
//            break;
//    }
    currentItemAttributes.frame = CGRectOffset(currentItemAttributes.frame, 0, 0.5 * CGRectGetHeight(currentItemAttributes.frame));
    
    return currentItemAttributes;
}


@end
