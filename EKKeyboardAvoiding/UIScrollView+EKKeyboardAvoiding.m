//
//  UIScrollView+EKKeyboardAvoiding.m
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 9/17/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "UIScrollView+EKKeyboardAvoiding.h"
#import "NSObject+EKKeyboardAvoiding.h"

#import "EKAvoidingListener.h"

static NSString *const kListenerKey = @"KeyboardAvoidingListener";

@implementation UIScrollView (EKKeyboardAvoiding)

#pragma mark - public methods

- (BOOL)keyboardAvoidingEnabled {
    return ([self keyboardAvoidingListener] != nil);
}

- (void)setKeyboardAvoidingEnabled:(BOOL)enabled {
    if (enabled) {
        [self addKeyboardAvoidingListener];
    }
    else {
        [self removeKeyboardAvoidingListener];
    }
}

#pragma mark - associate avoiding listener

- (void)addKeyboardAvoidingListener {
    EKAvoidingListener *listener = [[EKAvoidingListener alloc] initWithScrollView:self];
    [self associateObject:listener forKey:kListenerKey];
}

- (void)removeKeyboardAvoidingListener {
    [self associateObject:nil forKey:kListenerKey];
}

- (EKAvoidingListener *)keyboardAvoidingListener {
    return [self associatedObjectForKey:kListenerKey];
}

@end
