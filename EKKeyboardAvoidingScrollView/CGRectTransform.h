//
//  CGRectTransform.h
//  EKKeyboardAvoidingScrollView
//
//  Created by Evgeniy Kirpichenko on 12/7/12.
//  Copyright (c) 2012 Evgeniy Kirpichenko. All rights reserved.
//

//

#import <UIKit/UIKit.h>

typedef enum {
    CGRectTransformRotateLeft,
    CGRectTransformRotateRight,
    CGRectTransformExpand
} CGRectTransform;

CGRect CGRectTransformed(CGRect rect, CGSize viewSize, CGRectTransform transform)
{
    switch (transform) {
        case CGRectTransformRotateLeft:
            return CGRectMake(rect.origin.y,
                              viewSize.width - CGRectGetMaxX(rect),
                              rect.size.height,
                              rect.size.width);
        case CGRectTransformRotateRight:
            return CGRectMake(viewSize.height - CGRectGetMaxY(rect),
                              rect.origin.x,
                              rect.size.height,
                              rect.size.width);
        case CGRectTransformExpand:
            return CGRectMake(viewSize.width - CGRectGetMaxX(rect),
                              viewSize.height - CGRectGetMaxY(rect),
                              rect.size.width,
                              rect.size.height);
        default:
            return rect;
    }
}

