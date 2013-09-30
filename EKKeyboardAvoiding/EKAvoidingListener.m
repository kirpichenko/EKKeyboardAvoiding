//
//  EKAvoidingListener.m
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 9/17/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "EKAvoidingListener.h"
#import "EKAvoidingInsetCalculator.h"

#import "NSObject+EKKeyboardAvoiding.h"

static NSString *const kContentInsetKey = @"contentInset";

@interface EKAvoidingListener ()
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) UIEdgeInsets initialContentInset;
@property (nonatomic, assign) CGRect keyboardFrame;
@end

@implementation EKAvoidingListener

@synthesize initialContentInset;

- (id)initWithScrollView:(UIScrollView *)scrollView {
    if (self = [super init]) {
        [self setScrollView:scrollView];
        [self setInitialContentInset:[scrollView contentInset]];

        [self startNotificationsObseving];
        [self startContentInsetsObserving];
    }
    return self;
}

- (void)dealloc {
    [self resetAvoidingContentInset];
    [self stopNotificationsObserving];
    [self stopContentInsetsObserving];
}

#pragma mark - track notifications

- (void)startNotificationsObseving {
    [self observeNotificationNamed:UIKeyboardDidChangeFrameNotification
                            action:@selector(keyboardDidChangeFrame:)];
}

- (void)keyboardDidChangeFrame:(NSNotification *)notification {
    NSValue *frameValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardFrame = [frameValue CGRectValue];
    if ([self.scrollView superview]) {
        keyboardFrame = [[self.scrollView superview] convertRect:keyboardFrame fromView:nil];
    }

    [self setKeyboardFrame:keyboardFrame];
    [self updateScrollViewsContentInset];
}

#pragma mark - update inset

- (void)updateScrollViewsContentInset {
    [self resetAvoidingContentInset];
    
    UIEdgeInsets avoidingInset = [self calculateAvoidingContentInset];
    [self applyAvoidingContentInset:avoidingInset];
}

- (void)applyAvoidingContentInset:(UIEdgeInsets)avoidingInset {
    [self setInitialContentInset:[[self scrollView] contentInset]];

    [[self scrollView] setContentInset:avoidingInset];
    [[self scrollView] setScrollIndicatorInsets:avoidingInset];
}

- (void)resetAvoidingContentInset {
    [[self scrollView] setContentInset:initialContentInset];
    [[self scrollView] setScrollIndicatorInsets:initialContentInset];
}

- (UIEdgeInsets)calculateAvoidingContentInset {
    EKAvoidingInsetCalculator *calculator = [[EKAvoidingInsetCalculator alloc] init];
    
    [calculator setScrollViewFrame:[[self scrollView] frame]];
    [calculator setScrollViewInitialInset:[[self scrollView] contentInset]];
    [calculator setKeyboardFrame:[self keyboardFrame]];
    
    return [calculator calculateAvoidingInset];
}

#pragma mark - content inset observing

- (void)startContentInsetsObserving {
    [[self scrollView] addObserver:self forKeyPath:kContentInsetKey
                           options:NSKeyValueObservingOptionNew context:(void *)self];
}

- (void)stopContentInsetsObserving {
    [[self scrollView] removeObserver:self forKeyPath:kContentInsetKey context:(void *)self];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context
{
    if (context == (__bridge void *)self) {
        NSLog(@"content changed %@",change);
    }
}

@end
