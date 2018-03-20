//
//  NSObjectCategoryTest.m
//  EKKeyboardAvoiding-UnitTests
//
//  Created by Andrew Romanov on 20/03/2018.
//  Copyright © 2018 Evgeniy Kirpichenko. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSObject+EKKeyboardAvoiding.h"


@interface NSObjectCategoryTest : XCTestCase

@end


@interface EKTestNotificationsObserver : NSObject

@property (nonatomic) BOOL notification1Called;
@property (nonatomic) BOOL notification2Called;

- (void)reset;

- (void)notification1Action:(NSNotification*)notification;
- (void)notification2Action:(NSNotification*)notification;

@end


@implementation EKTestNotificationsObserver

- (id)init
{
	if (self = [super init])
	{
		[self reset];
	}
	
	return self;
}


- (void)reset
{
	_notification1Called = NO;
	_notification2Called = NO;
}


- (void)notification1Action:(NSNotification *)notification
{
	_notification1Called = YES;
}


- (void)notification2Action:(NSNotification *)notification
{
	_notification2Called = YES;
}

@end


@implementation NSObjectCategoryTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testAssotiatedObject
{
	NSObject* object = [[NSObject alloc] init];
	NSString* key = @"key_str";
	
	@autoreleasepool{
		NSNumber* num = @(3);
		[object ek_associateObject:num forKey:key];
		num = nil;
	}
	
	XCTAssertNotNil([object ek_associatedObjectForKey:key]);
	[object ek_associateObject:nil forKey:key];
	XCTAssertNil([object ek_associatedObjectForKey:key]);
}


- (void)testNotifications
{
	NSString* notification1Name = @"notification1Name";
	NSString* notification2Name = @"notification2Name";
	
	EKTestNotificationsObserver* observer = [[EKTestNotificationsObserver alloc] init];
	[[NSNotificationCenter defaultCenter] addObserver:observer
																					 selector:@selector(notification1Action:)
																							 name:notification1Name
																						 object:nil];
	[observer ek_observeNotificationNamed:notification2Name action:@selector(notification2Action:)];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:notification1Name object:nil userInfo:nil];
	[[NSNotificationCenter defaultCenter] postNotificationName:notification2Name object:nil userInfo:nil];
	
	XCTAssertTrue(observer.notification1Called);
	XCTAssertTrue(observer.notification2Called);
	
	[observer reset];
	XCTAssertFalse(observer.notification1Called);
	XCTAssertFalse(observer.notification2Called);
	
	[observer ek_stopNotificationsObserving];
	[[NSNotificationCenter defaultCenter] postNotificationName:notification1Name object:nil userInfo:nil];
	[[NSNotificationCenter defaultCenter] postNotificationName:notification2Name object:nil userInfo:nil];
	XCTAssertTrue(observer.notification1Called);
	XCTAssertFalse(observer.notification2Called);
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
