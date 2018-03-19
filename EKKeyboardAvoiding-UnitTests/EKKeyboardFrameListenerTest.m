//
//  EKKeyboardFrameListenerTest.m
//  EKKeyboardAvoiding-UnitTests
//
//  Created by Andrew Romanov on 19/03/2018.
//  Copyright © 2018 Evgeniy Kirpichenko. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EKKeyboardFrameListener.h"
#import "EKFakeKeyboard.h"

@interface EKKeyboardFrameListenerTest : XCTestCase

@property (nonatomic, strong) EKKeyboardFrameListener* listener;

@end


@implementation EKKeyboardFrameListenerTest

- (void)setUp
{
	[super setUp];
	// Put setup code here. This method is called before the invocation of each test method in the class.
	_listener = [[EKKeyboardFrameListener alloc] init];
}

- (void)tearDown
{
	// Put teardown code here. This method is called after the invocation of each test method in the class.
	[super tearDown];
	_listener = nil;
}

- (void)testCallbackCalling
{
	__block BOOL called = NO;
	self.listener.keyboadFrameUpdatedBlock = ^(EKKeyboardFrameListener *sender) {
		called = YES;
	};
	
	[EKFakeKeyboard showFromBottom];
	XCTAssertTrue(called);
}

@end
