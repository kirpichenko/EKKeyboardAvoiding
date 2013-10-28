//
//  EKAvoidingListener.h
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 9/17/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "EKKeyboardFrameConverter.h"

@interface EKAvoidingListener : NSObject

- (id)initWithScrollView:(UIScrollView *)scrollView;

@property (nonatomic, strong) EKKeyboardFrameConverter *frameConverter;

@end
