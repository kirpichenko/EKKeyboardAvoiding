//
//  EKKeyboardFrameCalculator.h
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 10/28/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EKKeyboardFrameConverter : NSObject

- (CGRect)convertFrame:(CGRect)keyboardFrame forView:(UIView *)view;

@end
