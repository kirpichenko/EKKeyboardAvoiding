//
//  EKFakeKeyboardFrameConverter.m
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 10/28/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "EKFakeKeyboardFrameConverter.h"

@implementation EKFakeKeyboardFrameConverter

- (CGRect)convertFrame:(CGRect)keyboardFrame forView:(UIView *)view {
    return keyboardFrame;
}

@end
