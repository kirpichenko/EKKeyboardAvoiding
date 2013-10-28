//
//  EKKeyboardFrameCalculator.m
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 10/28/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "EKKeyboardFrameConverter.h"

@implementation EKKeyboardFrameConverter

#pragma mark - public methods

- (CGRect)convertFrame:(CGRect)keyboardFrame forView:(UIView *)view {
    return [[view superview] convertRect:keyboardFrame fromView:nil];
}

@end
