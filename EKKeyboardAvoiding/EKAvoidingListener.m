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
        [self startKeyPathsObserving];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"ekavoiding dealloc");

    [self resetAvoidingContentInset];
    [self stopNotificationsObserving];
    [self stopKeyPathsObserving];
}

#pragma mark - track notifications

- (void)startNotificationsObseving {
    [self observeNotificationNamed:UIKeyboardDidChangeFrameNotification
                            action:@selector(keyboardDidChangeFrame:)];
}

- (void)keyboardDidChangeFrame:(NSNotification *)notification {
    NSValue *frameValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardFrame = [frameValue CGRectValue];
    if ([self frameConverter]) {
        keyboardFrame = [[self frameConverter] convertFrame:keyboardFrame forView:[self scrollView]];
    }

    [self setKeyboardFrame:keyboardFrame];
    [self updateScrollViewsContentInset];
}

#pragma mark - track key paths

- (void)startKeyPathsObserving {
    [[self scrollView] addObserver:self forKeyPath:kContentInsetKey];
}

- (void)stopKeyPathsObserving {
    [[self scrollView] removeObserver:self forKeyPath:kContentInsetKey];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    NSLog(@"change to %@",change);
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
    [calculator setScrollViewInitialInset:[self initialContentInset]];
    [calculator setKeyboardFrame:[self keyboardFrame]];
    
    return [calculator calculateAvoidingInset];
}

@end
