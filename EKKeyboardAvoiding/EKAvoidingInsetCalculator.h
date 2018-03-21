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
@property (nonatomic) CGRect keyboardFrame;

/// Current scrollView frame to be used for extra inset calculation
@property (nonatomic) CGRect scrollViewFrame;

/// Current scrollView inset to be used for extra inset calculation
@property (nonatomic) UIEdgeInsets scrollViewInset;

//To determine insets adjusting behaviour
@property (nonatomic) UIEdgeInsets safeAreaInsets;
@property (nonatomic) UIScrollViewContentInsetAdjustmentBehavior contentAdjustmentBehavior NS_AVAILABLE_IOS(11);
@property (nonatomic) BOOL alwaysBounceVertical;
@property (nonatomic) BOOL alwaysBounceHorizontal;

/*! Calculates extra inset that should be added to current to be able to avoid keyboard
 \returns Extra content inset
 */
- (UIEdgeInsets)calculateAvoidingInset;

@end
