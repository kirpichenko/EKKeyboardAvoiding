//
//  UIScrollView+EKKeyboardAvoiding.h
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 9/17/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (EKKeyboardAvoiding)

/*! Returns the state of the keyboard avoiding
 \returns A Boolean value that determines whether the keyboard avoiding is enabled.
 */
- (BOOL)keyboardAvoidingEnabled;

/*! Set the state of the keyboard avoiding to On or Off
 \params enabled YES if the scrollView should avoid keyboard and NO if it shouldn't
 */
- (void)setKeyboardAvoidingEnabled:(BOOL)enabled;

@end
