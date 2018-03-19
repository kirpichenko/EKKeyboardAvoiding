//
//  EKKeyboardAvoidingProviderTest.m
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 9/26/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <UIKit/UIKit.h>

#import "EKKeyboardAvoidingProvider.h"

#import "EKFakeKeyboard.h"
#import "EKFakeKeyboardFrameListener.h"

@interface EKKeyboardAvoidingProviderTest : XCTestCase
{
    UIScrollView *scrollView;
    EKKeyboardAvoidingProvider *avoidingProvider;
}

@end


@interface EKKeyboardAvoidingProviderTest (Private)

- (void)checkContentInsetsWithExpectedInsets:(UIEdgeInsets)expectedInsets;
- (void)checkIndicatorsInsetsWithExpectedInsets:(UIEdgeInsets)expectedInsets;

@end


@implementation EKKeyboardAvoidingProviderTest

- (void)setUp
{
    [super setUp];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 160, 320, 200)];
    scrollView.contentInset = UIEdgeInsetsMake(40, 0, 100, 0);
	scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(20, 0, 80, 0);
    
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
   
	//Expected bottom inset should be maximum of initial bottom inset and height of intersection
	[self checkContentInsetsWithExpectedInsets:UIEdgeInsetsMake(40, 0, 100, 0)];
	[self checkIndicatorsInsetsWithExpectedInsets:UIEdgeInsetsMake(20, 0, 96, 0)];
}

- (void)testBottomIntersectionWithCoverage
{
    [EKFakeKeyboard showWithFrame:CGRectMake(0, 240, 320, 216)];
   
	//Expected bottom inset should be maximum of initial bottom inset and height of intersection
	[self checkContentInsetsWithExpectedInsets:UIEdgeInsetsMake(40, 0, 120, 0)];
	[self checkIndicatorsInsetsWithExpectedInsets:UIEdgeInsetsMake(20, 0, 120, 0)];
}

- (void)testTopIntersectionWithoutCoverage
{
    [EKFakeKeyboard showWithFrame:CGRectMake(0, -40, 320, 216)];
   
	//Expected top inset should be maximum of initial top inset and height of intersection
	[self checkContentInsetsWithExpectedInsets:UIEdgeInsetsMake(40, 0, 100, 0)];
	[self checkIndicatorsInsetsWithExpectedInsets:UIEdgeInsetsMake(20, 0, 80, 0)];
}

- (void)testTopIntersectionWithCoverage
{
    [EKFakeKeyboard showFromTop];
   
	//Expected top inset should be maximum of initial top inset and height of intersection
	[self checkContentInsetsWithExpectedInsets:UIEdgeInsetsMake(56, 0, 100, 0)];
	[self checkIndicatorsInsetsWithExpectedInsets:UIEdgeInsetsMake(56, 0, 80, 0)];
}

- (void)testMiddleIntersection
{
    [EKFakeKeyboard showWithFrame:CGRectMake(0, 200, 320, 100)];
   
	 //Scroll view should contain initial content inset
	[self checkContentInsetsWithExpectedInsets:UIEdgeInsetsMake(40, 0, 100, 0)];
	[self checkIndicatorsInsetsWithExpectedInsets:UIEdgeInsetsMake(20, 0, 80, 0)];
}

- (void)testAppearanceWithoutIntersection
{
    [EKFakeKeyboard showWithFrame:CGRectMake(0, 480, 320, 216)];
   
	//Scroll view should contain initial content inset
	[self checkContentInsetsWithExpectedInsets:UIEdgeInsetsMake(40, 0, 100, 0)];
	[self checkIndicatorsInsetsWithExpectedInsets:UIEdgeInsetsMake(20, 0, 80, 0)];
}


- (void)testShowAndHideWithTopIntersection
{
	[EKFakeKeyboard showWithFrame:CGRectMake(0.f, 0.f, 320.f, 250.f)];
	[EKFakeKeyboard hide];
	
	//Scroll view should contain initial content inset
	[self checkContentInsetsWithExpectedInsets:UIEdgeInsetsMake(40, 0, 100, 0)];
	[self checkIndicatorsInsetsWithExpectedInsets:UIEdgeInsetsMake(20, 0, 80, 0)];
}

@end


#pragma mark -
@implementation EKKeyboardAvoidingProviderTest (Private)

- (void)checkContentInsetsWithExpectedInsets:(UIEdgeInsets)expectedInsets
{
	UIEdgeInsets calculatedInset = [scrollView contentInset];
	XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(expectedInsets, calculatedInset));
}


- (void)checkIndicatorsInsetsWithExpectedInsets:(UIEdgeInsets)expectedInsets
{
	UIEdgeInsets calculatedIndicatorsInsets = [scrollView scrollIndicatorInsets];
	XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(expectedInsets, calculatedIndicatorsInsets));
}

@end
