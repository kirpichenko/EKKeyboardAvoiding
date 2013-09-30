//
//  UIScrollViewAvoidingTest.m
//  EKKeyboardAvoiding-UnitTests
//
//  Created by Evgeniy Kirpichenko on 9/25/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <objc/objc-runtime.h>

#import "UIScrollView+EKKeyboardAvoiding.h"

@interface UIScrollViewAvoidingTest : XCTestCase {
    UIScrollView *scrollView;
}

@end

@implementation UIScrollViewAvoidingTest

- (void)setUp {
    [super setUp];

    scrollView = [[UIScrollView alloc] init];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testEnableKeyboardAvoiding {
    [scrollView setKeyboardAvoidingEnabled:YES];
    
    XCTAssertTrue([scrollView keyboardAvoidingEnabled], @"keyboard avoiding should be enabled");
}

- (void)testDisableKeyboardAvoiding {
    [scrollView setKeyboardAvoidingEnabled:YES];
    [scrollView setKeyboardAvoidingEnabled:NO];
    
    XCTAssertFalse([scrollView keyboardAvoidingEnabled], @"keyboard avoiding should be disabled");
}

@end
