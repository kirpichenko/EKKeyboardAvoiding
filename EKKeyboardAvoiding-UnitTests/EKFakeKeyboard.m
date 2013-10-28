//
//  Keyboard.m
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 10/9/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "EKFakeKeyboard.h"

@implementation EKFakeKeyboard

+ (void)showFromBottom {
    CGRect keyboardFrame = CGRectMake(0, 264, 320, 216);
    [self showWithFrame:keyboardFrame];
}

+ (void)showFromTop {
    CGRect keyboardFrame = CGRectMake(0, 0, 320, 216);
    [self showWithFrame:keyboardFrame];
}

+ (void)showAtMiddle {
    CGRect keyboardFrame = CGRectMake(0, 132, 320, 216);
    [self showWithFrame:keyboardFrame];
}

+ (void)hide {
    CGRect keyboardFrame = CGRectMake(0, 480, 320, 216);
    [self showWithFrame:keyboardFrame];
}

+ (void)showWithFrame:(CGRect)keyboardFrame
{
    NSValue *keyboardFrameValue = [NSValue valueWithCGRect:keyboardFrame];
    NSDictionary *userInfo = @{UIKeyboardFrameEndUserInfoKey : keyboardFrameValue};
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter postNotificationName:UIKeyboardDidChangeFrameNotification object:nil
                                    userInfo:userInfo];
}

@end
