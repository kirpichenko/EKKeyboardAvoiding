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
@synthesize scrollViewInset;

#pragma mark - public methods

- (UIEdgeInsets)calculateAvoidingInset
{
    UIEdgeInsets contentInset = UIEdgeInsetsZero;
    if ([self intersectionExists])
    {
        if ([self keyboardAtTheTop])
        {
            CGFloat coverage = CGRectGetMaxY(keyboardFrame) - CGRectGetMinY(scrollViewFrame);
            contentInset.top = MAX(coverage - scrollViewInset.top, 0);
        }
        else if ([self keyboardAtTheBottom])
        {
            CGFloat coverage = CGRectGetMaxY(scrollViewFrame) - CGRectGetMinY(keyboardFrame);
            contentInset.bottom = MAX(coverage - scrollViewInset.bottom, 0);
        }
    }
    return contentInset;
}

#pragma mark - find intersection

- (BOOL)intersectionExists
{
    BOOL intersect = CGRectIntersectsRect(keyboardFrame, scrollViewFrame);
    BOOL keyboardContains = CGRectContainsRect(keyboardFrame, scrollViewFrame);
    BOOL sameHeight =  scrollViewFrame.size.height == keyboardFrame.size.height;
    BOOL empty = CGRectEqualToRect(keyboardFrame, CGRectZero);
    
    return (intersect && !keyboardContains && !sameHeight && !empty);
}

- (BOOL)keyboardAtTheTop
{
    return keyboardFrame.origin.y <= scrollViewFrame.origin.y;
}

- (BOOL)keyboardAtTheBottom
{
    return (keyboardFrame.origin.y <= CGRectGetMaxY(scrollViewFrame) &&
            CGRectGetMaxY(keyboardFrame) >= CGRectGetMaxY(scrollViewFrame));
}

@end
