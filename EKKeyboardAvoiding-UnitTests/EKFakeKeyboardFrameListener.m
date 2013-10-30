//
//  EKFakeKeyboardFrameListener.m
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 10/28/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "EKFakeKeyboardFrameListener.h"

@implementation EKFakeKeyboardFrameListener

- (CGRect)convertedKeyboardFrameForView:(UIView *)view {
    return [self keyboardFrame];
}

@end
