//
//  EKAvoidingInsetCalculator.m
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 9/25/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "EKAvoidingInsetCalculator.h"
#import "EKInsetsAdjustingDetector.h"



@interface EKAvoidingInsetCalculator ()

@property (nonatomic, strong) EKInsetsAdjustingDetector* adjustingDetector NS_AVAILABLE_IOS(11.0);

@end


@interface EKAvoidingInsetCalculator (Private)

- (UIEdgeInsets)_adjustResultInsets:(UIEdgeInsets)insets;

@end


@implementation EKAvoidingInsetCalculator

- (instancetype)init
{
	if (self = [super init])
	{
		_keyboardFrame = CGRectZero;
		_scrollViewFrame = CGRectZero;
		_scrollViewInset = UIEdgeInsetsZero;
		_safeAreaInsets = UIEdgeInsetsZero;
		
		if (@available (iOS 11.0, *))
		{
			_contentAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
			_alwaysBounceHorizontal = NO;
			_alwaysBounceVertical = YES;
			
			_adjustingDetector = [[EKInsetsAdjustingDetector alloc] init];
		}
		
	}
	
	return self;
}


#pragma mark - public methods

- (UIEdgeInsets)calculateAvoidingInset
{
	UIEdgeInsets contentInset = UIEdgeInsetsZero;
	if ([self intersectionExists])
	{
		if ([self keyboardAtTheTop])
		{
			CGFloat coverage = CGRectGetMaxY(_keyboardFrame) - CGRectGetMinY(_scrollViewFrame);
			contentInset.top = MAX(coverage - _scrollViewInset.top, 0);
		}
		else if ([self keyboardAtTheBottom])
		{
			CGFloat coverage = CGRectGetMaxY(_scrollViewFrame) - CGRectGetMinY(_keyboardFrame);
			contentInset.bottom = MAX(coverage - _scrollViewInset.bottom, 0);
		}
	}
	UIEdgeInsets result = [self _adjustResultInsets:contentInset];
	return result;
}

#pragma mark - find intersection

- (BOOL)intersectionExists
{
	BOOL intersect = CGRectIntersectsRect(_keyboardFrame, _scrollViewFrame);
	BOOL keyboardContains = CGRectContainsRect(_keyboardFrame, _scrollViewFrame);
	BOOL sameHeight =  _scrollViewFrame.size.height == _keyboardFrame.size.height;
	BOOL empty = CGRectEqualToRect(_keyboardFrame, CGRectZero);
	
	return (intersect && !keyboardContains && !sameHeight && !empty);
}


- (BOOL)keyboardAtTheTop
{
	return _keyboardFrame.origin.y <= _scrollViewFrame.origin.y;
}


- (BOOL)keyboardAtTheBottom
{
	return (_keyboardFrame.origin.y <= CGRectGetMaxY(_scrollViewFrame) &&
					CGRectGetMaxY(_keyboardFrame) >= CGRectGetMaxY(_scrollViewFrame));
}

@end


@implementation EKAvoidingInsetCalculator (Private)

- (UIEdgeInsets)_adjustResultInsets:(UIEdgeInsets)insets
{
	UIEdgeInsets result = insets;
	
	if (@available(iOS 11.0, *))
	{
		if (self.adjustingDetector.adjustLeft)
		{
			result.left -= self.safeAreaInsets.left;
		}
		if (self.adjustingDetector.adjustTop)
		{
			result.top -= self.safeAreaInsets.top;
		}
		if (self.adjustingDetector.adjustRight)
		{
			result.right -= self.safeAreaInsets.right;
		}
		if (self.adjustingDetector.adjustBottom)
		{
			result.bottom -= self.safeAreaInsets.bottom;
		}
	}
	
	return result;
}

@end

