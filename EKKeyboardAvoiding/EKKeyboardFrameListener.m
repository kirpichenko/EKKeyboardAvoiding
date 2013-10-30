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
@property (nonatomic,strong) NSDictionary *keyboardInfo;
@end

@implementation EKKeyboardFrameListener

#pragma mark life cycle

- (id)init {
    if (self = [super init]) {
        [self startNotificationsObseving];
    }
    return self;
}

- (void)dealloc {
    [self stopNotificationsObserving];
}

#pragma mark - public methods

- (CGRect)convertedKeyboardFrameForView:(UIView *)view {
    return [[view superview] convertRect:[self keyboardFrame] fromView:nil];
}

#pragma mark - private methods

- (void)startNotificationsObseving {
    [self observeNotificationNamed:UIKeyboardDidChangeFrameNotification
                            action:@selector(keyboardDidChangeFrame:)];
}

#pragma mark - observe keyboard frame

- (void)keyboardDidChangeFrame:(NSNotification *)notification {
    self.keyboardInfo = [notification userInfo];
    
    NSValue *frameValue = [self.keyboardInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    self.keyboardFrame = [frameValue CGRectValue];
    
    NSLog(@"1");
}

@end
