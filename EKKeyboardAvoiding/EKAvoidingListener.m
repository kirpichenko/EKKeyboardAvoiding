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
static NSString *const kKeyboardFrameKey = @"keyboardFrame";

@interface EKAvoidingListener ()
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) UIEdgeInsets initialContentInset;
@property (nonatomic, assign) BOOL avoidingStarted;
@end

@implementation EKAvoidingListener

@synthesize initialContentInset;

- (id)initWithScrollView:(UIScrollView *)scrollView {
    if (self = [super init]) {
        [self setScrollView:scrollView];
        [self setInitialContentInset:[scrollView contentInset]];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"ekavoiding dealloc");

    [self stopAvoiding];
}

#pragma mark - public methods

- (void)startAvoiding
{
    if (!self.avoidingStarted) {
        [self beginKeyboardFrameObserving];
        [self beginContentInsetObserving];
        [self setAvoidingStarted:YES];
    }
}

- (void)stopAvoiding
{
    if (self.avoidingStarted) {
        [self resetAvoidingContentInset];
        
        [self endKeyboardFrameObserving];
        [self endContentInsetObserving];
        [self setAvoidingStarted:NO];
    }
}

#pragma mark - update inset

- (void)updateContentInset {
    UIEdgeInsets avoidingInset = [self calculateAvoidingContentInset];
    [self applyAvoidingContentInset:avoidingInset];
}

- (void)resetAvoidingContentInset {
    [self applyAvoidingContentInset:initialContentInset];
}

- (void)applyAvoidingContentInset:(UIEdgeInsets)avoidingInset {
    [self endContentInsetObserving];

    [[self scrollView] setContentInset:avoidingInset];
    [[self scrollView] setScrollIndicatorInsets:avoidingInset];
    
    [self beginContentInsetObserving];
}

- (UIEdgeInsets)calculateAvoidingContentInset {
    EKAvoidingInsetCalculator *calculator = [[EKAvoidingInsetCalculator alloc] init];
    
    [calculator setScrollViewFrame:[self.scrollView frame]];
    [calculator setScrollViewInitialInset:[self initialContentInset]];
    [calculator setKeyboardFrame:[self.keyboardListener keyboardFrame]];
    
    return [calculator calculateAvoidingInset];
}

#pragma mark - private methods

- (void)beginKeyboardFrameObserving {
    [[self keyboardListener] addObserver:self forKeyPath:kKeyboardFrameKey];
}

- (void)endKeyboardFrameObserving {
    [[self keyboardListener] removeObserver:self forKeyPath:kKeyboardFrameKey];
}

- (void)beginContentInsetObserving {
    [[self scrollView] addObserver:self forKeyPath:kContentInsetKey];
}

- (void)endContentInsetObserving {
    [[self scrollView] removeObserver:self forKeyPath:kContentInsetKey];
}

#pragma mark - observe

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context
{
    if (object == [self scrollView]) {
        [self setInitialContentInset:[self.scrollView contentInset]];
    }
    [self updateContentInset];
}


@end
