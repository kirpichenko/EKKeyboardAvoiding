//
//  UIScrollView+EKKeyboardAvoiding.m
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 9/17/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "UIScrollView+EKKeyboardAvoiding.h"
#import "NSObject+EKKeyboardAvoiding.h"

#import "EKKeyboardAvoidingProvider.h"
#import "EKKeyboardFrameListener.h"

static NSString *const kListenerKey = @"KeyboardAvoidingListener";

@implementation UIScrollView (EKKeyboardAvoiding)

#pragma mark - public methods

- (BOOL)ek_keyboardAvoidingEnabled
{
    return ([self ekp_keyboardAvoidingListener] != nil);
}

- (void)ek_setKeyboardAvoidingEnabled:(BOOL)enabled
{
    if (enabled)
    {
        [self ekp_addKeyboardAvoidingListener];
    }
    else
    {
        [self ekp_removeKeyboardAvoidingListener];
    }
}

#pragma mark - associate avoiding listener

- (void)ekp_addKeyboardAvoidingListener
{
    EKKeyboardAvoidingProvider *listener = [[EKKeyboardAvoidingProvider alloc] initWithScrollView:self];
    [listener setKeyboardListener:[self ekp_keyboardFrameListener]];
    [listener startAvoiding];

    [self ek_associateObject:listener forKey:kListenerKey];
}

- (void)ekp_removeKeyboardAvoidingListener
{
    EKKeyboardAvoidingProvider *listener = [self ekp_keyboardAvoidingListener];
    [listener stopAvoiding];

    [self ek_associateObject:nil forKey:kListenerKey];
}

- (EKKeyboardAvoidingProvider *)ekp_keyboardAvoidingListener
{
    return [self ek_associatedObjectForKey:kListenerKey];
}


- (EKKeyboardFrameListener *)ekp_keyboardFrameListener
{
    static EKKeyboardFrameListener *listener;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        listener = [[EKKeyboardFrameListener alloc] init];
    });
    return listener;
}

@end
