//
//  EKKeyboardAvoidingProvider.m
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 9/17/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "EKKeyboardAvoidingProvider.h"
#import "EKAvoidingInsetCalculator.h"

#import "NSObject+EKKeyboardAvoiding.h"

static NSString *const kKeyboardFrameKey = @"keyboardFrame";

@interface EKKeyboardAvoidingProvider ()
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) UIEdgeInsets extraContentInset;
@property (nonatomic, assign) BOOL avoidingStarted;
@end

@implementation EKKeyboardAvoidingProvider

- (id)initWithScrollView:(UIScrollView *)scrollView
{
    if (self = [super init])
    {
        [self setScrollView:scrollView];
    }
    return self;
}

- (void)dealloc
{
    [self stopAvoiding];
}

#pragma mark - public methods

- (void)startAvoiding
{
    if (!self.avoidingStarted)
    {
        [self beginKeyboardFrameObserving];
        [self setAvoidingStarted:YES];
    }
}

- (void)stopAvoiding
{
    if (self.avoidingStarted)
    {
        [self resetAvoidingContentInset];
        [self endKeyboardFrameObserving];
        [self setAvoidingStarted:NO];
    }
}

#pragma mark - private methods

- (void)beginKeyboardFrameObserving
{
    [[self keyboardListener] addObserver:self forKeyPath:kKeyboardFrameKey];
}

- (void)endKeyboardFrameObserving
{
    [[self keyboardListener] removeObserver:self forKeyPath:kKeyboardFrameKey];
}

#pragma mark - update inset

- (void)addExtraContentInset:(UIEdgeInsets)extraContentInset
{
    UIEdgeInsets currentInset = [self.scrollView contentInset];
    currentInset.top += extraContentInset.top;
    currentInset.bottom += extraContentInset.bottom;
    
    [self applyAvoidingContentInset:currentInset];
}

- (void)resetAvoidingContentInset
{
    UIEdgeInsets currentInset = [self.scrollView contentInset];
    currentInset.top -= self.extraContentInset.top;
    currentInset.bottom -= self.extraContentInset.bottom;
    
    [self applyAvoidingContentInset:currentInset];
}

- (void)applyAvoidingContentInset:(UIEdgeInsets)avoidingInset
{
    [[self scrollView] setContentInset:avoidingInset];
    [[self scrollView] setScrollIndicatorInsets:avoidingInset];
}

- (UIEdgeInsets)calculateExtraContentInset
{
    EKAvoidingInsetCalculator *calculator = [[EKAvoidingInsetCalculator alloc] init];

    CGRect keyboardFrame = [self.keyboardListener convertedKeyboardFrameForView:self.scrollView];
    [calculator setKeyboardFrame:keyboardFrame];
    [calculator setScrollViewFrame:[self.scrollView frame]];
    [calculator setScrollViewInset:[self.scrollView contentInset]];
    
    return [calculator calculateAvoidingInset];
}

#pragma mark - observe

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context
{
    if (keyPath == kKeyboardFrameKey)
    {
        [self resetAvoidingContentInset];

        UIEdgeInsets newInset = [self calculateExtraContentInset];
        [self addExtraContentInset:newInset];
        [self setExtraContentInset:newInset];
    }
}

@end
