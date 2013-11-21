//
//  ContenInsetAutoChangeTest.m
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 10/30/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "EKFakeKeyboard.h"
#import "EKFakeKeyboardFrameListener.h"

#import "EKKeyboardAvoidingProvider.h"

@interface ContenInsetAutoChangeTest : XCTestCase
@property (nonatomic, strong) EKKeyboardAvoidingProvider *avoidingProvider;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic) UIEdgeInsets portraitAutomaticInset;
@property (nonatomic) UIEdgeInsets landscapeAutomaticInset;

@property (nonatomic) CGRect portraitFrame;
@property (nonatomic) CGRect landscapeFrame;
@end

@implementation ContenInsetAutoChangeTest

- (void)setUp
{
    [super setUp];
    
    self.portraitAutomaticInset = UIEdgeInsetsMake(64, 0, 49, 0);
    self.landscapeAutomaticInset = UIEdgeInsetsMake(52, 0, 49, 0);
    
    self.portraitFrame = CGRectMake(0, 0, 320, 568);
    self.landscapeFrame = CGRectMake(0, 0, 568, 320);
    
    self.scrollView = [[UIScrollView alloc] init];
    self.avoidingProvider = [[EKKeyboardAvoidingProvider alloc] initWithScrollView:self.scrollView];
    self.avoidingProvider.keyboardListener = [EKFakeKeyboardFrameListener new];

    [self.avoidingProvider startAvoiding];
    [self rotateScrollToPortraitOrientation];
}

- (void)tearDown
{
    [self.avoidingProvider stopAvoiding];
    [super tearDown];
}

- (void)testInitialContentInset
{
    UIEdgeInsets expectedInset = UIEdgeInsetsMake(64, 0, 49, 0);
    XCTAssertEqual([self.scrollView contentInset], expectedInset);
}

- (void)testRotationToLandscape
{
    [self rotateScrollToLandscapeOrientation];
    
    XCTAssertEqual([self.scrollView frame], self.landscapeFrame);
    XCTAssertEqual([self.scrollView contentInset], self.landscapeAutomaticInset);
}

- (void)testPortraitRotateAndShowKeyboard
{
    [self rotateScrollToPortraitOrientation];
    [EKFakeKeyboard showWithFrame:CGRectMake(0, 352, 320, 216)];
    
    UIEdgeInsets expectedInset = UIEdgeInsetsMake(64, 0, 216, 0);
    XCTAssertEqual([self.scrollView contentInset], expectedInset);
}

- (void)testLandscapeRotateAndShowKeyboard
{
    [self rotateScrollToLandscapeOrientation];
    [EKFakeKeyboard showWithFrame:CGRectMake(0, 158, 568, 162)];
    
    UIEdgeInsets expectedInset = UIEdgeInsetsMake(52, 0, 162, 0);
    XCTAssertEqual([self.scrollView contentInset], expectedInset);
}

- (void)testLandscapeShowKeyboardAndRotate
{
    [EKFakeKeyboard showWithFrame:CGRectMake(0, 352, 568, 162)];
    [self rotateScrollToLandscapeOrientation];
    [EKFakeKeyboard showWithFrame:CGRectMake(0, 158, 568, 162)];
    
    UIEdgeInsets expectedInset = UIEdgeInsetsMake(52, 0, 162, 0);
    XCTAssertEqual([self.scrollView contentInset], expectedInset);
}

#pragma mark - helpers

- (void)updateContentInset:(UIEdgeInsets)contentInset
{
    [[self scrollView] setContentInset:contentInset];
}

- (void)rotateScrollToPortraitOrientation
{
    [self.scrollView setFrame:self.portraitFrame];
    [self.scrollView setContentInset:self.portraitAutomaticInset];
}

- (void)rotateScrollToLandscapeOrientation
{
    [self.scrollView setFrame:self.landscapeFrame];
    [self.scrollView setContentInset:self.landscapeAutomaticInset];
}

@end
