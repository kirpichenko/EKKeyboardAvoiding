//
//  EKKeyboardAvoidingScrollView.m
//  EKKeyboardAvoidingScrollView
//
//  Created by Evgeniy Kirpichenko on 12/5/12.
//  Copyright (c) 2012 Evgeniy Kirpichenko. All rights reserved.
//

#import "EKKeyboardAvoidingScrollView.h"
#import "EKKeyboardAvoidingManager.h"

@implementation EKKeyboardAvoidingScrollView

#pragma mark -
#pragma mark life cycle

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [[EKKeyboardAvoidingManager sharedInstance] registerForKeyboardAvoiding:self];
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [[EKKeyboardAvoidingManager sharedInstance] registerForKeyboardAvoiding:self];
    }
    return self;
}

- (id) init
{
    return [self initWithFrame:CGRectZero];
}

- (void) dealloc
{
    [[EKKeyboardAvoidingManager sharedInstance] unregisterFromKeyboardAvoiding:self];
    [super dealloc];
}

@end
