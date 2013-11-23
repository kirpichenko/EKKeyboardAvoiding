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

/*! Returns keyboard frame in coordinate system ov view's superview
 \param view View which superview to be used for keyboard frame converting
 \returns Converted keyboard frame
 */
- (CGRect)convertedKeyboardFrameForView:(UIView *)view;

/// Last observed keyboard frame
@property (nonatomic,readonly) CGRect keyboardFrame;

@end
