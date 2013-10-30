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

- (CGRect)convertedKeyboardFrameForView:(UIView *)view;

@property (nonatomic,readonly) CGRect keyboardFrame;
@property (nonatomic,readonly) NSDictionary *keyboardInfo;

@end
