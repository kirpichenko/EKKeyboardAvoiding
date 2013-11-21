//
//  EKAvoidingInsetCalculatorTest.m
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 11/15/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "EKAvoidingInsetCalculator.h"

@interface EKAvoidingInsetCalculatorTest : XCTestCase
@property (nonatomic, strong) EKAvoidingInsetCalculator *calculator;
@end

@implementation EKAvoidingInsetCalculatorTest

- (void)setUp
{
    [super setUp];
    
    self.calculator = [EKAvoidingInsetCalculator new];
}

- (void)testViewFrameFullyContainsKeyboardFrame
{
    self.calculator.scrollViewFrame = CGRectMake(0, 0, 568, 320);
    self.calculator.keyboardFrame = CGRectMake(320, 0, 216, 320);
    self.calculator.scrollViewInset = UIEdgeInsetsMake(10, 0, 20, 0);
    
    UIEdgeInsets insets = [self.calculator calculateAvoidingInset];
    XCTAssertEqual(insets, UIEdgeInsetsZero, @"shouldn't calculate any extra inset");
}

- (void)testKeyboardFrameContainsViewFrame
{
    self.calculator.scrollViewFrame = CGRectMake(0, 352, 320, 216);
    self.calculator.keyboardFrame = CGRectMake(0, 352, 320, 216);
    self.calculator.scrollViewInset = UIEdgeInsetsMake(10, 0, 20, 0);
    
    UIEdgeInsets insets = [self.calculator calculateAvoidingInset];
    XCTAssertEqual(insets, UIEdgeInsetsZero, @"shouldn't calculate any extra inset");
}

@end
