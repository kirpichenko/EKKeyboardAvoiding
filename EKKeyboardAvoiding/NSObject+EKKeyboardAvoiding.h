//
//  NSObject+EKAssociatedObject.h
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 9/30/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (EKKeyboardAvoiding)

/*! Adds associated object
 \param object An object to be associated with key
 \param key String to be used for access to associated object
 */
- (void)associateObject:(id)object forKey:(NSString *)key;

/*! Provides an access to associated objects
 \param key Key for associated object to be returned
 \return Associated object for key
 */
- (id)associatedObjectForKey:(NSString *)key;

/*! Registers for notification observing
 \param notificationName The name of notification to be observed
 \param action Selector to be called when observing notification posted
 */
- (void)observeNotificationNamed:(NSString *)notificationName action:(SEL)action;

/*! Stops all notifications observing
 */
- (void)stopNotificationsObserving;

/*! Add observer for keyPath
 \param target Object to be observing keyPath values
 \param keyPath Path where observing value is placed
 */
- (void)addObserver:(id)target forKeyPath:(NSString *)keyPath;

@end
