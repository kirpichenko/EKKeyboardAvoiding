//
//  Keyboard.h
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 10/9/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EKFakeKeyboard : NSObject

+ (void)showFromBottom;
+ (void)showFromTop;
+ (void)showAtMiddle;
+ (void)hide;

+ (void)showWithFrame:(CGRect)frame;

@end
