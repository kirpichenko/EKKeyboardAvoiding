//
//  EKAvoidingInsetCalculator.m
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 9/25/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "EKAvoidingInsetCalculator.h"

@implementation EKAvoidingInsetCalculator

@synthesize keyboardFrame;
@synthesize scrollViewFrame;
@synthesize scrollViewInitialInset;

#pragma mark - public methods

- (UIEdgeInsets)calculateAvoidingInset {
    UIEdgeInsets contentInset = scrollViewInitialInset;
    if ([self intersectionExists]) {
        if ([self keyboardAtTheTop]) {
            CGFloat coverage = CGRectGetMaxY(keyboardFrame) - CGRectGetMinY(scrollViewFrame);
            contentInset.top = MAX(contentInset.top, coverage);
        }
        else if ([self keyboardAtTheBottom] ) {
            CGFloat coverage = CGRectGetMaxY(scrollViewFrame) - CGRectGetMinY(keyboardFrame);
            contentInset.bottom = MAX(contentInset.bottom, coverage);
        }
    }
    return contentInset;
}

#pragma mark - find intersection

- (BOOL)intersectionExists {
    BOOL intersect = CGRectIntersectsRect(keyboardFrame, scrollViewFrame);
    BOOL contain = CGRectContainsRect(keyboardFrame, scrollViewFrame);
    BOOL empty = CGRectEqualToRect(keyboardFrame, CGRectZero);
    
    return (intersect && !contain && !empty);
}

- (BOOL)keyboardAtTheTop {
    return keyboardFrame.origin.y <= scrollViewFrame.origin.y;
}

- (BOOL)keyboardAtTheBottom {
    return (keyboardFrame.origin.y <= CGRectGetMaxY(scrollViewFrame) &&
            CGRectGetMaxY(keyboardFrame) >= CGRectGetMaxY(scrollViewFrame));
}

@end
