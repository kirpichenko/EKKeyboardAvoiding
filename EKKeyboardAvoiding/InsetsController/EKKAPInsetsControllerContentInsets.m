//
//  EKKAPInsetsControllerContentInsets.m
//  EKKeyboardAvoiding
//
//  Created by Andrew Romanov on 06.02.14.
//  Copyright (c) 2014 Evgeniy Kirpichenko. All rights reserved.
//

#import "EKKAPInsetsControllerContentInsets.h"

@implementation EKKAPInsetsControllerContentInsets

- (UIEdgeInsets)_getCurrentInsets
{
   return self.scrollView.contentInset;
}


- (void)_setCurrentInsets:(UIEdgeInsets)insets
{
	self.scrollView.contentInset = insets;
}

@end
