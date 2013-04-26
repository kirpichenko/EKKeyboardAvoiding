//
//  EKKeyboardAvoidingScrollView.m
//  EKKeyboardAvoidingScrollView
//
//  Created by Evgeniy Kirpichenko on 12/5/12.
//  Copyright (c) 2012 Evgeniy Kirpichenko. All rights reserved.
//

#import "EKKeyboardAvoidingView.h"
#import "EKKeyboardAvoidingManager.h"

@implementation EKKeyboardAvoidingView

#pragma mark -
#pragma mark life cycle

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [[EKKeyboardAvoidingManager sharedInstance] registerScrollView:self];
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [[EKKeyboardAvoidingManager sharedInstance] registerScrollView:self];
    }
    return self;
}

- (id) init
{
    return [self initWithFrame:CGRectZero];
}

- (void)dealloc
{
    [self unregisterFromAvoiding];
}

#pragma mark -
#pragma mark public methods

- (void)unregisterFromAvoiding
{
    [[EKKeyboardAvoidingManager sharedInstance] unregisterScrollView:self];
}

@end
