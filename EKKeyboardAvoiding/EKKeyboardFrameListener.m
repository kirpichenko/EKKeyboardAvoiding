//
//  EKKeyboardFrameListener.m
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 10/8/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "EKKeyboardFrameListener.h"
#import "NSObject+EKKeyboardAvoiding.h"

@interface EKKeyboardFrameListener ()

@property (nonatomic,assign) CGRect keyboardFrame;
@property (nonatomic,strong) NSDictionary *keyboardInfo;

@end


@interface EKKeyboardFrameListener (Notifications)

- (void)_startNotificationsObseving;
- (void)_stopObservingNotifications;
- (void)_keyboardDidChangeFrame:(NSNotification *)notification;
- (void)_keyboardWillChangeFrameNotification:(NSNotification*)notification;

@end


@implementation EKKeyboardFrameListener

#pragma mark life cycle

- (id)init
{
    if (self = [super init])
    {
        [self _startNotificationsObseving];
    }
    return self;
}

- (void)dealloc
{
	[self _stopObservingNotifications];
}


- (UIViewAnimationCurve)animatonCurve
{
	NSNumber* curve = [self.keyboardInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
	return [curve unsignedIntegerValue];
}


- (NSTimeInterval)animationDuration
{
	NSNumber* duration = [self.keyboardInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
	return [duration doubleValue];
}

#pragma mark - public methods

- (CGRect)convertedKeyboardFrameForView:(UIView *)view
{
    CGRect convertedFrame = [[view superview] convertRect:[self keyboardFrame] fromView:nil];
    return convertedFrame;
}

@end


#pragma mark -
@implementation EKKeyboardFrameListener (Notifications)

- (void)_startNotificationsObseving
{
	[self ek_observeNotificationNamed:UIKeyboardWillChangeFrameNotification
														 action:@selector(_keyboardWillChangeFrameNotification:)];
	[self ek_observeNotificationNamed:UIKeyboardDidChangeFrameNotification
														 action:@selector(_keyboardDidChangeFrame:)];
}


- (void)_stopObservingNotifications
{
	[self ek_stopNotificationsObserving];
}


- (void)_keyboardDidChangeFrame:(NSNotification *)notification
{
	if (self.keyboardAnimationAppearingCompletedBlock)
	{
		self.keyboardAnimationAppearingCompletedBlock(self);
	}
}


- (void)_keyboardWillChangeFrameNotification:(NSNotification*)notification
{
	[self willChangeValueForKey:@"animatonCurve"];
	[self willChangeValueForKey:@"animationDuration"];
	self.keyboardInfo = [notification userInfo];
	[self didChangeValueForKey:@"animatonCurve"];
	[self didChangeValueForKey:@"animationDuration"];
	
	NSValue* frameValue = [self.keyboardInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
	if (!CGRectEqualToRect(self.keyboardFrame, [frameValue CGRectValue]))
	{
		self.keyboardFrame = [frameValue CGRectValue];
		
		if (self.keyboadFrameUpdatedBlock)
		{
			self.keyboadFrameUpdatedBlock(self);
		}
	}
}
@end
