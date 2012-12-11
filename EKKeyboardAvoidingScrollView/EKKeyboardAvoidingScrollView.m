//
//  EKKeyboardAvoidingScrollView.m
//  EKKeyboardAvoidingScrollView
//
//  Created by Evgeniy Kirpichenko on 12/5/12.
//  Copyright (c) 2012 Evgeniy Kirpichenko. All rights reserved.
//

#import "EKKeyboardAvoidingScrollView.h"
#import "EKKeyboardAvoidingScrollViewManager.h"

@implementation EKKeyboardAvoidingScrollView

#pragma mark -
#pragma mark life cycle

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [[EKKeyboardAvoidingScrollViewManager sharedInstance] registerScrollViewForKeyboardAvoiding:self];
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [[EKKeyboardAvoidingScrollViewManager sharedInstance] registerScrollViewForKeyboardAvoiding:self];
    }
    return self;
}

- (id) init
{
    return [self initWithFrame:CGRectZero];
}

- (void) dealloc
{
    [[EKKeyboardAvoidingScrollViewManager sharedInstance] unregisterScrollViewFromKeyboardAvoiding:self];
    [super dealloc];
}

@end
