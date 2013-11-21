//
//  EKKeyboardAvoidingProviderTest.m
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 9/26/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "EKKeyboardAvoidingProvider.h"

#import "EKFakeKeyboard.h"
#import "EKFakeKeyboardFrameListener.h"

@interface EKKeyboardAvoidingProviderTest : XCTestCase
{
    UIScrollView *scrollView;
    EKKeyboardAvoidingProvider *avoidingProvider;
}

@end

@implementation EKKeyboardAvoidingProviderTest

- (void)setUp
{
    [super setUp];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 160, 320, 200)];
    scrollView.contentInset = UIEdgeInsetsMake(40, 0, 100, 0);
    
    avoidingProvider = [[EKKeyboardAvoidingProvider alloc] initWithScrollView:scrollView];
    avoidingProvider.keyboardListener = [EKFakeKeyboardFrameListener new];
    
    [avoidingProvider startAvoiding];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testBottomIntersectionWithoutCoverage
{
    [EKFakeKeyboard showFromBottom];
    
    UIEdgeInsets expectedInset = UIEdgeInsetsMake(40, 0, 100, 0);
    UIEdgeInsets calculatedInset = [scrollView contentInset];
    
    //Expected bottom inset should be maximum of initial bottom inset and height of intersection
    XCTAssertEqual(expectedInset, calculatedInset);
}

- (void)testBottomIntersectionWithCoverage
{
    [EKFakeKeyboard showWithFrame:CGRectMake(0, 240, 320, 216)];
    
    UIEdgeInsets expectedInset = UIEdgeInsetsMake(40, 0, 120, 0);
    UIEdgeInsets calculatedInset = [scrollView contentInset];
    
    //Expected bottom inset should be maximum of initial bottom inset and height of intersection
    XCTAssertEqual(expectedInset, calculatedInset);
}

- (void)testTopIntersectionWithoutCoverage
{
    [EKFakeKeyboard showWithFrame:CGRectMake(0, -40, 320, 216)];
    
    UIEdgeInsets expectedInset = UIEdgeInsetsMake(40, 0, 100, 0);
    UIEdgeInsets calculatedInset = [scrollView contentInset];
    
    //Expected top inset should be maximum of initial top inset and height of intersection
    XCTAssertEqual(expectedInset, calculatedInset);
}

- (void)testTopIntersectionWithCoverage
{
    [EKFakeKeyboard showFromTop];
    
    UIEdgeInsets expectedInset = UIEdgeInsetsMake(56, 0, 100, 0);
    UIEdgeInsets calculatedInset = [scrollView contentInset];
    
    //Expected top inset should be maximum of initial top inset and height of intersection
    XCTAssertEqual(expectedInset, calculatedInset);
}

- (void)testMiddleIntersection
{
    [EKFakeKeyboard showWithFrame:CGRectMake(0, 200, 320, 100)];
    
    UIEdgeInsets expectedInset = UIEdgeInsetsMake(40, 0, 100, 0);
    UIEdgeInsets calculatedInset = [scrollView contentInset];
    
    //Scroll view should contain initial content inset
    XCTAssertEqual(expectedInset, calculatedInset);
}

- (void)testAppearanceWithoutIntersection
{
    [EKFakeKeyboard showWithFrame:CGRectMake(0, 480, 320, 216)];
    
    UIEdgeInsets expectedInset = UIEdgeInsetsMake(40, 0, 100, 0);
    UIEdgeInsets calculatedInset = [scrollView contentInset];
    
    //Scroll view should contain initial content inset
    XCTAssertEqual(expectedInset, calculatedInset);
}

@end
