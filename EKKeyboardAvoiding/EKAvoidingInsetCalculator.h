//
//  EKAvoidingInsetCalculator.h
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 9/25/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EKAvoidingInsetCalculator : NSObject

/// Current keyboard frame to be used for extra inset calculation
@property (nonatomic, assign) CGRect keyboardFrame;

/// Current scrollView frame to be used for extra inset calculation
@property (nonatomic, assign) CGRect scrollViewFrame;

/// Current scrollView inset to be used for extra inset calculation
@property (nonatomic, assign) UIEdgeInsets scrollViewInset;

/*! Calculates extra inset that should be added to current to be able to avoid keyboard
 \returns Extra content inset
 */
- (UIEdgeInsets)calculateAvoidingInset;

@end
