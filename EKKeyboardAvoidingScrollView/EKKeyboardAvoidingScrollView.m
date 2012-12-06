//
//  EKKeyboardAvoidingScrollView.m
//  EKKeyboardAvoidingScrollView
//
//  Created by Evgeniy Kirpichenko on 12/5/12.
//  Copyright (c) 2012 Evgeniy Kirpichenko. All rights reserved.
//

#import "EKKeyboardAvoidingScrollView.h"
#import "EKKeyboardAvoidingScrollViewManger.h"

@implementation EKKeyboardAvoidingScrollView

#pragma mark -
#pragma mark life cycle

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [[EKKeyboardAvoidingScrollViewManger sharedInstance] registerScrollViewForKeyboardAvoiding:self];
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [[EKKeyboardAvoidingScrollViewManger sharedInstance] registerScrollViewForKeyboardAvoiding:self];
    }
    return self;
}

- (id) init
{
    return [self initWithFrame:CGRectZero];
}

- (void) dealloc
{
    [[EKKeyboardAvoidingScrollViewManger sharedInstance] unregisterScrollViewFromKeyboardAvoiding:self];
    [super dealloc];
}

@end
