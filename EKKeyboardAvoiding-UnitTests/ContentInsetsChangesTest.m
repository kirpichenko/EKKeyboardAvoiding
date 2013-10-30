//
//  ContentInsetsChangesTest.m
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 10/28/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "EKAvoidingListener.h"

#import "EKFakeKeyboard.h"
#import "EKFakeKeyboardFrameListener.h"

@interface ContentInsetsChangesTest : XCTestCase {
    UIScrollView *scrollView;
    EKAvoidingListener *listener;
}
@end

@implementation ContentInsetsChangesTest

- (void)setUp
{
    [super setUp];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 160, 320, 200)];
    scrollView.contentInset = UIEdgeInsetsMake(40, 0, 100, 0);
    
    listener = [[EKAvoidingListener alloc] initWithScrollView:scrollView];
    listener.keyboardListener = [EKFakeKeyboardFrameListener new];
    
    [listener startAvoiding];
}

- (void)tearDown
{
    [listener stopAvoiding];
    
    [super tearDown];
}

- (void)testBottomIntersection
{
    [EKFakeKeyboard showFromBottom];
    
    UIEdgeInsets newInitialInset = UIEdgeInsetsMake(40, 0, 80, 0);
    [scrollView setContentInset:newInitialInset];

    UIEdgeInsets expectedInset = UIEdgeInsetsMake(40, 0, 96, 0);
    UIEdgeInsets calculatedInset = [scrollView contentInset];
    
    //New initial content inset should be recalculated with current keyboard frame
    XCTAssertEqual(expectedInset, calculatedInset);
}

- (void)testTopIntersection
{
    [EKFakeKeyboard showFromTop];
    
    UIEdgeInsets newInitialInset = UIEdgeInsetsMake(80, 0, 100, 0);
    [scrollView setContentInset:newInitialInset];
    
    UIEdgeInsets expectedInset = UIEdgeInsetsMake(80, 0, 100, 0);
    UIEdgeInsets calculatedInset = [scrollView contentInset];
    
    //New initial content inset should be recalculated with current keyboard frame
    XCTAssertEqual(expectedInset, calculatedInset);
}

@end
