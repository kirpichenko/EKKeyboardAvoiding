//
//  EKKeyboardAvoidingEnabled.m
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 10/9/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "UIScrollView+EKKeyboardAvoiding.h"

@interface AvoidingEnabledTest : XCTestCase {
    UIScrollView *scrollView;
    UIEdgeInsets defaultInsets;
    CGRect defaultFrame;
}
@end

@implementation AvoidingEnabledTest

- (void)setUp
{
    [super setUp];
    
    defaultFrame = CGRectMake(0, 0, 320, 480);
    defaultInsets = UIEdgeInsetsMake(10, 0, 20, 0);
    
    scrollView = [[UIScrollView alloc] init];
    
    [scrollView setFrame:defaultFrame];
    [scrollView setContentInset:defaultInsets];
    [scrollView setKeyboardAvoidingEnabled:YES];
}

- (void)testEnableAvoiding {
    XCTAssertTrue([scrollView keyboardAvoidingEnabled], @"keyboard avoiding should be enabled");
}

- (void)testSetContentInsetWithoutKeyboardOnScreen {
    UIEdgeInsets customInset = UIEdgeInsetsMake(20, 0, 10, 0);
    [scrollView setContentInset:customInset];
    
    XCTAssertEqual([scrollView contentInset], customInset, @"content inset should be set without changes");
}


@end
