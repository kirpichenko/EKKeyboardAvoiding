//
//  EKAvoidingListener.h
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 9/17/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "EKKeyboardFrameListener.h"

@interface EKAvoidingListener : NSObject

- (id)initWithScrollView:(UIScrollView *)scrollView;

- (void)startAvoiding;
- (void)stopAvoiding;

@property (nonatomic, strong) EKKeyboardFrameListener *keyboardListener;

@end
