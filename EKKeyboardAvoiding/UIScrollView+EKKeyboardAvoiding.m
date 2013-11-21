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

- (BOOL)keyboardAvoidingEnabled
{
    return ([self keyboardAvoidingListener] != nil);
}

- (void)setKeyboardAvoidingEnabled:(BOOL)enabled
{
    if (enabled)
    {
        [self addKeyboardAvoidingListener];
    }
    else
    {
        [self removeKeyboardAvoidingListener];
    }
}

#pragma mark - associate avoiding listener

- (void)addKeyboardAvoidingListener
{
    EKKeyboardAvoidingProvider *listener = [[EKKeyboardAvoidingProvider alloc] initWithScrollView:self];
    [listener setKeyboardListener:[self keyboardFrameListener]];
    [listener startAvoiding];

    [self associateObject:listener forKey:kListenerKey];
}

- (void)removeKeyboardAvoidingListener
{
    EKKeyboardAvoidingProvider *listener = [self keyboardAvoidingListener];
    [listener stopAvoiding];

    [self associateObject:nil forKey:kListenerKey];
}

- (EKKeyboardAvoidingProvider *)keyboardAvoidingListener
{
    return [self associatedObjectForKey:kListenerKey];
}


- (EKKeyboardFrameListener *)keyboardFrameListener
{
    static EKKeyboardFrameListener *listener;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        listener = [[EKKeyboardFrameListener alloc] init];
    });
    return listener;
}

@end
