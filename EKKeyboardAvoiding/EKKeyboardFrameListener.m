//
//  EKKeyboardFrameListener.m
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 10/8/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "EKKeyboardFrameListener.h"
#import "NSObject+EKKeyboardAvoiding.h"

@interface EKKeyboardFrameListener ()
@property (nonatomic,assign) CGRect keyboardFrame;
@end

@implementation EKKeyboardFrameListener

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

@end
