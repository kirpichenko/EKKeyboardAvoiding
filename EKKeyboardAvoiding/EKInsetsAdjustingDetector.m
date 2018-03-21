//
//  EKInsetsAdjustingDetector.m
//  EKKeyboardAvoiding
//
//  Created by Andrew Romanov on 21/03/2018.
//  Copyright © 2018 Evgeniy Kirpichenko. All rights reserved.
//

#import "EKInsetsAdjustingDetector.h"


@interface EKInsetsAdjustingDetector (Private)

- (BOOL)_adjustHorizontal NS_AVAILABLE_IOS(11.0);
- (BOOL)_adjustVertical NS_AVAILABLE_IOS(11.0);

@end


@implementation EKInsetsAdjustingDetector

- (instancetype)init
{
	if (self = [super init])
	{
		_scrollViewFrame = CGRectZero;
		_contentSize = CGSizeZero;
		if (@available(iOS 11.0, *))
		{
			_safeInsets = UIEdgeInsetsZero;
			_contentAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
		}
		_alwaysBounceVertical = NO;
		_alwaysBounceHorizontal = NO;
	}
	
	return self;
}



- (BOOL)adjustLeft
{
	BOOL adjust = NO;
	if (@available(iOS 11.0, *))
	{
		adjust = [self _adjustHorizontal];
	}
	
	return adjust;
}


- (BOOL)adjustTop
{
	BOOL adjust = NO;
	if (@available(iOS 11.0, *))
	{
		adjust = [self _adjustVertical];
	}
	
	return adjust;
}


- (BOOL)adjustRight
{
	BOOL adjust = NO;
	if (@available(iOS 11.0, *))
	{
		adjust = [self _adjustHorizontal];
	}
	
	return adjust;
}


- (BOOL)adjustBottom
{
	BOOL adjust = NO;
	if (@available(iOS 11.0, *))
	{
		adjust = [self _adjustVertical];
	}
	
	return adjust;
}

@end


#pragma mark -
@implementation EKInsetsAdjustingDetector (Private)

/*
 UIScrollViewContentInsetAdjustmentAutomatic, // Similar to .scrollableAxes, but for backward compatibility will also adjust the top & bottom contentInset when the scroll view is owned by a view controller with automaticallyAdjustsScrollViewInsets = YES inside a navigation controller, regardless of whether the scroll view is scrollable
 UIScrollViewContentInsetAdjustmentScrollableAxes, // Edges for scrollable axes are adjusted (i.e., contentSize.width/height > frame.size.width/height or alwaysBounceHorizontal/Vertical = YES)
 UIScrollViewContentInsetAdjustmentNever, // contentInset is not adjusted
 UIScrollViewContentInsetAdjustmentAlways, // contentInset is always adjusted by the scroll view's safeAreaInsets
 */


- (BOOL)_adjustHorizontal
{
	BOOL adjust = NO;
	
	switch (self.contentAdjustmentBehavior)
	{
		case UIScrollViewContentInsetAdjustmentAutomatic:
		{
			/*
			 Content is always adjusted vertically when the scroll view is the content view of a view controller that is currently displayed by a navigation or tab bar controller. If the scroll view is horizontally scrollable, the horizontal content offset is also adjusted when there are nonzero safe area insets.
			*/
			adjust = self.alwaysBounceHorizontal || self.contentSize.width > CGRectGetWidth(self.scrollViewFrame) || !UIEdgeInsetsEqualToEdgeInsets(self.safeInsets, UIEdgeInsetsZero);
		}
			break;
		case UIScrollViewContentInsetAdjustmentScrollableAxes:
		{
			/*
			 The top and bottom insets include the safe area inset values when the vertical content size is greater than the height of the scroll view itself. The top and bottom insets are also adjusted when the alwaysBounceVertical property is YES. Similarly, the left and right insets include the safe area insets when the horizontal content size is greater than the width of the scroll view.
			 */
			adjust= self.alwaysBounceHorizontal || self.contentSize.width > CGRectGetWidth(self.scrollViewFrame);
		}
			break;
		case UIScrollViewContentInsetAdjustmentNever:
		{
			adjust = NO;
		}
			break;
		case UIScrollViewContentInsetAdjustmentAlways:
		{
			adjust = YES;
		}
			break;
	
		default:
			break;
	}
	
	return adjust;
}


- (BOOL)_adjustVertical
{
	BOOL adjust = NO;
	
	switch (self.contentAdjustmentBehavior)
	{
		case UIScrollViewContentInsetAdjustmentAutomatic:
		{
			/*
			 Content is always adjusted vertically when the scroll view is the content view of a view controller that is currently displayed by a navigation or tab bar controller. If the scroll view is horizontally scrollable, the horizontal content offset is also adjusted when there are nonzero safe area insets.
			 */
			adjust = self.alwaysBounceVertical || self.contentSize.height > CGRectGetHeight(self.scrollViewFrame) || !UIEdgeInsetsEqualToEdgeInsets(self.safeInsets, UIEdgeInsetsZero);
		}
			break;
		case UIScrollViewContentInsetAdjustmentScrollableAxes:
		{
			/*
			 The top and bottom insets include the safe area inset values when the vertical content size is greater than the height of the scroll view itself. The top and bottom insets are also adjusted when the alwaysBounceVertical property is YES. Similarly, the left and right insets include the safe area insets when the horizontal content size is greater than the width of the scroll view.
			 */
			adjust= self.alwaysBounceVertical || self.contentSize.height > CGRectGetHeight(self.scrollViewFrame);
		}
			break;
		case UIScrollViewContentInsetAdjustmentNever:
		{
			adjust = NO;
		}
			break;
		case UIScrollViewContentInsetAdjustmentAlways:
		{
			adjust = YES;
		}
			break;
			
		default:
			break;
	}
	
	return adjust;
}

@end
