//
//  NSObject+EKAssociatedObject.h
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 9/30/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (EKKeyboardAvoiding)

- (void)associateObject:(id)object forKey:(NSString *)key;
- (id)associatedObjectForKey:(NSString *)key;

- (void)observeNotificationNamed:(NSString *)notificationName action:(SEL)action;
- (void)stopNotificationsObserving;

- (void)addObserver:(id)target forKeyPath:(NSString *)keyPath;

@end
