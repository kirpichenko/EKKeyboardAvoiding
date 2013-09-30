//
//  EKAvoidingListenerTest.m
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 9/26/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "EKAvoidingListener.h"

@interface EKAvoidingListenerTest : XCTestCase {
    UIScrollView *scrollView;
    EKAvoidingListener *listener;
}

@end

@implementation EKAvoidingListenerTest

- (void)setUp {
    [super setUp];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 20, 30, 40)];
    scrollView.contentInset = UIEdgeInsetsMake(10, 0, 20, 0);
    
    listener = [[EKAvoidingListener alloc] initWithScrollView:scrollView];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testKeyboardAppearanceListening {
    CGRect keyboardFrame = CGRectMake(0, 10, 50, 20);
    [self postKeyboardDidChangeFrameNotificationWithFrame:keyboardFrame];
    
    UIEdgeInsets expectedInset = UIEdgeInsetsMake(10, 0, 20, 0);
    UIEdgeInsets calculatedInset = [scrollView contentInset];
    
    XCTAssertEqual(expectedInset, calculatedInset, "insets should be equal");
}

- (void)testKeyboardDisappearanceListening {
    CGRect keyboardFrame = CGRectMake(0, 10, 50, 20);
    [self postKeyboardDidChangeFrameNotificationWithFrame:keyboardFrame];
    [self postKeyboardDidChangeFrameNotificationWithFrame:CGRectZero];
    
    UIEdgeInsets expectedInset = UIEdgeInsetsMake(10, 0, 20, 0);
    UIEdgeInsets currentInset = [scrollView contentInset];
    
    XCTAssertEqual(expectedInset, currentInset, "insets should be equal");
}

#pragma mark - helpers

- (void)postKeyboardDidChangeFrameNotificationWithFrame:(CGRect)keyboardFrame {
    NSValue *keyboardFrameValue = [NSValue valueWithCGRect:keyboardFrame];
    NSDictionary *userInfo = @{UIKeyboardFrameEndUserInfoKey : keyboardFrameValue};
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter postNotificationName:UIKeyboardDidChangeFrameNotification
                                      object:nil userInfo:userInfo];
}

@end
