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

@property (nonatomic, assign) CGRect keyboardFrame;
@property (nonatomic, assign) CGRect scrollViewFrame;
@property (nonatomic, assign) UIEdgeInsets scrollViewInitialInset;

- (UIEdgeInsets)calculateAvoidingInset;

@end
