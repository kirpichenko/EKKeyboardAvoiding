//
//  EKKAPInsetsControllerBase.m
//  EKKeyboardAvoiding
//
//  Created by Andrew Romanov on 06.02.14.
//  Copyright (c) 2014 Evgeniy Kirpichenko. All rights reserved.
//

#import "EKKAPInsetsControllerBase.h"

#import "EKAvoidingInsetCalculator.h"
#import "NSObject+EKKeyboardAvoiding.h"


static NSString *const kKeyboardFrameKey = @"keyboardFrame";


@interface EKKAPInsetsControllerBase ()

@property (nonatomic, assign) UIEdgeInsets extraContentInset;
@property (nonatomic, assign) BOOL avoidingStarted;
@property (nonatomic, strong) EKAvoidingInsetCalculator *calculator;

@end


@interface EKKAPInsetsControllerBase (UpdateInsets)

- (void)_addExtraContentInset:(UIEdgeInsets)extraContentInset;
- (void)_resetAvoidingContentInset;
- (void)_applyAvoidingContentInset:(UIEdgeInsets)avoidingInset;
- (UIEdgeInsets)_calculateExtraContentInset;

@end


@interface EKKAPInsetsControllerBase (Private)

- (void)_beginKeyboardFrameObserving;
- (void)_endKeyboardFrameObserving;

@end


@implementation EKKAPInsetsControllerBase

/*! Initializes new insets controller
 \param scrollView ScrollView for that keyboard avoiding will be provided
 */
- (id)initWithScrollView:(UIScrollView *)scrollView
{
	if (self = [super init])
	{
		self.scrollView = scrollView;
		_calculator = [[EKAvoidingInsetCalculator alloc] init];
		_avoidingStarted = NO;
	}
	
	return self;
}


/// Starts keyboard avoiding
- (void)startAvoiding
{
	if (!self.avoidingStarted)
	{
		[self _beginKeyboardFrameObserving];
		[self setAvoidingStarted:YES];
	}
}


/// Stops keyboard avoiding
- (void)stopAvoiding
{
	if (self.avoidingStarted)
	{
		[self _resetAvoidingContentInset];
		[self _endKeyboardFrameObserving];
		[self setAvoidingStarted:NO];
	}
}


#pragma mark - observe

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context
{
	if (keyPath == kKeyboardFrameKey)
	{
		[self _resetAvoidingContentInset];
		
		UIEdgeInsets newInset = [self _calculateExtraContentInset];
		[self _addExtraContentInset:newInset];
		[UIView animateWithDuration:[self keyboardListener].animationDuration
													delay:0.0
												options:([self keyboardListener].animatonCurve << 16)
										 animations:^{
											 [self.scrollView layoutIfNeeded];
										 }
										 completion:^(BOOL finished) {
										 }];
		self.extraContentInset = newInset;
	}
}

@end


#pragma mark -
@implementation EKKAPInsetsControllerBase (UpdateInsets)

- (void)_addExtraContentInset:(UIEdgeInsets)extraContentInset
{
	UIEdgeInsets currentInset = [self _getCurrentInsets];
	currentInset.top += extraContentInset.top;
	currentInset.bottom += extraContentInset.bottom;
	
	[self _applyAvoidingContentInset:currentInset];
}

- (void)_resetAvoidingContentInset
{
	UIEdgeInsets currentInset = [self _getCurrentInsets];
	currentInset.top -= self.extraContentInset.top;
	currentInset.bottom -= self.extraContentInset.bottom;
	
	[self _applyAvoidingContentInset:currentInset];
}

- (void)_applyAvoidingContentInset:(UIEdgeInsets)avoidingInset
{
	[self _setCurrentInsets:avoidingInset];
}

- (UIEdgeInsets)_calculateExtraContentInset
{
	CGRect keyboardFrame = [self.keyboardListener convertedKeyboardFrameForView:self.scrollView];
	
	if (@available(iOS 11.0, *))
	{
		_calculator.contentAdjustmentBehavior = self.scrollView.contentInsetAdjustmentBehavior;
		_calculator.safeAreaInsets = self.scrollView.safeAreaInsets;
		_calculator.alwaysBounceVertical = self.scrollView.alwaysBounceVertical;
		_calculator.alwaysBounceHorizontal = self.scrollView.alwaysBounceHorizontal;
	}
	
	[_calculator setKeyboardFrame:keyboardFrame];
	[_calculator setScrollViewFrame:[self.scrollView frame]];
	[_calculator setScrollViewInset:[self _getCurrentInsets]];
	UIEdgeInsets extraInsets = [_calculator calculateAvoidingInset];
	
	return extraInsets;
}

@end


#pragma mark -
@implementation EKKAPInsetsControllerBase (Private)

- (void)_beginKeyboardFrameObserving
{
	@try
	{
		[[self keyboardListener] ek_addObserver:self forKeyPath:kKeyboardFrameKey];
	}
	@catch (NSException *exception)
	{
		NSLog(@"tried twice add observer");
	}
}

- (void)_endKeyboardFrameObserving
{
	@try
	{
		[[self keyboardListener] removeObserver:self forKeyPath:kKeyboardFrameKey];
	}
	@catch (NSException *exception)
	{
		NSLog(@"tried twice remove observer");
	}
}

@end


@implementation EKKAPInsetsControllerBase (Protected)

- (UIEdgeInsets)_getCurrentInsets
{
	return UIEdgeInsetsZero;
}


- (void)_setCurrentInsets:(UIEdgeInsets)insets
{
}

@end
