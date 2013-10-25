////
////  EKAvoidingCalculatorTest.m
////  EKKeyboardAvoiding
////
////  Created by Evgeniy Kirpichenko on 9/25/13.
////  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
////
//
//#import <XCTest/XCTest.h>
//
//#import "EKAvoidingInsetCalculator.h"
//
//@interface EKAvoidingCalculatorTest : XCTestCase {
//    EKAvoidingInsetCalculator *calculator;
//}
//
//@end
//
//@implementation EKAvoidingCalculatorTest
//
//- (void)setUp {
//    [super setUp];
//    
//    calculator = [[EKAvoidingInsetCalculator alloc] init];
//    calculator.scrollViewFrame = CGRectMake(10, 20, 30, 40);
//    calculator.scrollViewInitialInset = UIEdgeInsetsMake(10, 0, 15, 0);
//}
//
//- (void)tearDown {
//    [super tearDown];
//}
//
//- (void)testKeyboardTopIntersectionThatCoversInitialContentInset {
//    [calculator setKeyboardFrame:CGRectMake(0, 15, 50, 20)];
//    
//    UIEdgeInsets expectedInset = UIEdgeInsetsMake(15, 0, 15, 0);
//    UIEdgeInsets calculatedInset = [calculator calculateAvoidingInset];
//    
//    XCTAssertEqual(expectedInset, calculatedInset, "insets shoulld be equal");
//}
//
//- (void)testKeyboardTopIntersectionThatDoesntCoverInitialContentInset {
//    [calculator setKeyboardFrame:CGRectMake(0, 5, 50, 20)];
//    
//    UIEdgeInsets expectedInset = UIEdgeInsetsMake(10, 0, 15, 0);
//    UIEdgeInsets calculatedInset = [calculator calculateAvoidingInset];
//    
//    XCTAssertEqual(expectedInset, calculatedInset, "insets shoulld be equal");
//}
//
//
//- (void)testKeyboardBottomIntersectionThatCoversInitialContentInset {
//    [calculator setKeyboardFrame:CGRectMake(0, 40, 50, 20)];
//    
//    UIEdgeInsets expectedInset = UIEdgeInsetsMake(10, 0, 20, 0);
//    UIEdgeInsets calculatedInset = [calculator calculateAvoidingInset];
//    
//    XCTAssertEqual(expectedInset, calculatedInset, "insets should be eual");
//}
//
//- (void)testKeyboardBottomIntersectionThatDoesntCoverInitialContentInset {
//    [calculator setKeyboardFrame:CGRectMake(0, 50, 50, 20)];
//    
//    UIEdgeInsets expectedInset = UIEdgeInsetsMake(10, 0, 15, 0);
//    UIEdgeInsets calculatedInset = [calculator calculateAvoidingInset];
//    
//    XCTAssertEqual(expectedInset, calculatedInset, "insets should be eual");
//}
//
//- (void)testKeyboardMiddleIntersection {
//    [calculator setKeyboardFrame:CGRectMake(0, 30, 50, 20)];
//    
//    UIEdgeInsets expectedInset = calculator.scrollViewInitialInset;
//    UIEdgeInsets calculatedInset = [calculator calculateAvoidingInset];
//    
//    XCTAssertEqual(expectedInset, calculatedInset, "insets should be equal");
//}
//
//- (void)testKeyboardEmptyFrame {
//    [calculator setKeyboardFrame:CGRectZero];
//    
//    UIEdgeInsets expectedInset = calculator.scrollViewInitialInset;
//    UIEdgeInsets calculatedInset = [calculator calculateAvoidingInset];
//    
//    XCTAssertEqual(expectedInset, calculatedInset, "insets should be equal");
//}
//
//- (void)testKeyboardNoIntersection {
//    [calculator setKeyboardFrame:CGRectMake(0, 70, 50, 20)];
//    
//    UIEdgeInsets expectedInset = calculator.scrollViewInitialInset;
//    UIEdgeInsets calculatedInset = [calculator calculateAvoidingInset];
//    
//    XCTAssertEqual(expectedInset, calculatedInset, "insets should be equal");
//}
//
//@end
