//
//  EKKAPInsetsControllerScrollIndicatorsInsets.m
//  EKKeyboardAvoiding
//
//  Created by Andrew Romanov on 06.02.14.
//  Copyright (c) 2014 Evgeniy Kirpichenko. All rights reserved.
//

#import "EKKAPInsetsControllerScrollIndicatorsInsets.h"

@implementation EKKAPInsetsControllerScrollIndicatorsInsets

- (UIEdgeInsets)_getCurrentInsets
{
   return self.scrollView.scrollIndicatorInsets;
}


- (void)_setCurrentInsets:(UIEdgeInsets)insets
{
	self.scrollView.scrollIndicatorInsets = insets;
}

@end
