//
//  UIScrollView+EKKeyboardAvoiding.h
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 9/17/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (EKKeyboardAvoiding)

- (BOOL)keyboardAvoidingEnabled;
- (void)setKeyboardAvoidingEnabled:(BOOL)enabled;

@end
