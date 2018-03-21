//
//  EKKeyboardFrameListener.h
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 10/8/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EKKeyboardFrameListener : NSObject

@property (nonatomic, copy) void(^keyboadFrameUpdatedBlock)(EKKeyboardFrameListener* sender);
@property (nonatomic, copy) void(^keyboardAnimationAppearingCompletedBlock)(EKKeyboardFrameListener* sender);

/*! Returns keyboard frame in coordinate system ov view's superview
 \param view View which superview to be used for keyboard frame converting
 \returns Converted keyboard frame
 */
- (CGRect)convertedKeyboardFrameForView:(UIView *)view;

/// Last observed keyboard appearing/disappearing  properties
@property (nonatomic,readonly) CGRect keyboardFrame;
@property (nonatomic, readonly) UIViewAnimationCurve animatonCurve;
@property (nonatomic, readonly) NSTimeInterval animationDuration;

@end
