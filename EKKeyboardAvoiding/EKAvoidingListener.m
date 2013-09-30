//
//  EKAvoidingListener.m
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 9/17/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "EKAvoidingListener.h"
#import "EKAvoidingInsetCalculator.h"

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
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self resetAvoidingContentInset];
}

#pragma mark - track notifications

- (void)startNotificationsObseving {
    [self observeNotificationNamed:UIKeyboardDidChangeFrameNotification
                            action:@selector(keyboardDidChangeFrame:)];
    [self observeNotificationNamed:UITextFieldTextDidBeginEditingNotification
                            action:@selector(textFieldDidBecomeFirstResponder:)];
//    [self registerForNotificationNamed:kMoveToWindowNotification
//                                action:@selector(scrollViewDidMoveToWindow:)];
}

- (void)observeNotificationNamed:(NSString *)name action:(SEL)action {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:action name:name object:nil];
}

#pragma mark - receive notifications

- (void)keyboardDidChangeFrame:(NSNotification *)notification {
    NSValue *frameValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardFrame = [frameValue CGRectValue];
    if ([self.scrollView superview]) {
        keyboardFrame = [[self.scrollView superview] convertRect:keyboardFrame fromView:nil];
    }

    [self setKeyboardFrame:keyboardFrame];
    [self updateScrollViewsContentInset];
}

- (void)textFieldDidBecomeFirstResponder:(NSNotification *)notification {
//    NSLog(@"n = %@",notification);
}

#pragma mark - update inset

- (void)updateScrollViewsContentInset {
    [self resetAvoidingContentInset];
    
    EKAvoidingInsetCalculator *calculator = [[EKAvoidingInsetCalculator alloc] init];
    [calculator setScrollViewFrame:[[self scrollView] frame]];
    [calculator setScrollViewInitialInset:[[self scrollView] contentInset]];
    [calculator setKeyboardFrame:[self keyboardFrame]];
    
    [self applyAvoidingContentInset:[calculator calculateAvoidingInset]];
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

@end
