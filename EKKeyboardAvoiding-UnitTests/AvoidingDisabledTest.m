//
//  EKKeyboardAvoidingDisabledTest.m
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 10/9/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "EKKeyboard.h"
#import "UIScrollView+EKKeyboardAvoiding.h"

@interface AvoidingDisabledTest : XCTestCase {
    UIScrollView *scrollView;
    UIEdgeInsets defaultInsets;
    CGRect defaultFrame;
}

@end

@implementation AvoidingDisabledTest

- (void)setUp
{
    [super setUp];
    
    defaultFrame = CGRectMake(0, 0, 320, 480);
    defaultInsets = UIEdgeInsetsMake(10, 0, 20, 0);
    
    scrollView = [[UIScrollView alloc] init];

    [scrollView setFrame:defaultFrame];
    [scrollView setContentInset:defaultInsets];
}

- (void)testDefaultAvoidingState {
    XCTAssertFalse([scrollView keyboardAvoidingEnabled], @"keyboard avoiding should be disabled");
}

- (void)testDisableAvoiding {
    [scrollView setKeyboardAvoidingEnabled:YES];
    [scrollView setKeyboardAvoidingEnabled:NO];
    
    XCTAssertFalse([scrollView keyboardAvoidingEnabled], @"keyboard avoiding should be disabled");
}

- (void)testContentInsetWithKeyboardAtBottom {
    [EKKeyboard showFromBottom];
    
    UIEdgeInsets expectedInset = UIEdgeInsetsMake(10, 0, 216, 0);
    XCTAssertEqual([scrollView contentInset], expectedInset, @"content insets should be equal");
}

- (void)testContentInsetWithKeyboardAtTop {
    [EKKeyboard showFromTop];
    
    UIEdgeInsets expectedInset = UIEdgeInsetsMake(216, 0, 20, 0);
    XCTAssertEqual([scrollView contentInset], expectedInset, @"content insets should be equal");
}

- (void)testContentInsetWithKeyboardAtMiddle {
    [EKKeyboard showAtMiddle];
    
    XCTAssertEqual([scrollView contentInset], defaultInsets, @"content inset should be equal to default");
}

#pragma mark - content inset changes

- (void)testSetContentInsetWithoutKeyboardOnScreen {
    UIEdgeInsets customInset = UIEdgeInsetsMake(20, 0, 10, 0);
    [scrollView setContentInset:customInset];
    
    XCTAssertEqual([scrollView contentInset], customInset, @"content inset should be set without changes");
}

- (void)testSetLargeBottomContentInsetWithKeyboardOnScreen {
    [EKKeyboard showFromBottom];
    
    UIEdgeInsets customInset = UIEdgeInsetsMake(20, 0, 250, 0);
    [scrollView setContentInset:customInset];
    
    XCTAssertEqual([scrollView contentInset], customInset, @"bottom inset should be MAX");
}

- (void)testSetSmallBottomContentInsetWithKeyboardOnScreen {
    [EKKeyboard showFromBottom];
    
    UIEdgeInsets customInset = UIEdgeInsetsMake(20, 0, 200, 0);
    UIEdgeInsets expectedInset = UIEdgeInsetsMake(20, 0, 216, 0);
    [scrollView setContentInset:customInset];
    
    XCTAssertEqual([scrollView contentInset], expectedInset, @"bottom inset should be MAX");
}


@end
