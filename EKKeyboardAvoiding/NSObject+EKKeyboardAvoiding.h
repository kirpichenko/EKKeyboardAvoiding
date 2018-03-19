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
- (void)ek_associateObject:(id)object forKey:(NSString *)key;

/*! Provides an access to associated objects
 \param key Key for associated object to be returned
 \return Associated object for key
 */
- (id)ek_associatedObjectForKey:(NSString *)key;

/*! Registers for notification observing
 \param notificationName The name of notification to be observed
 \param action Selector to be called when observing notification posted
 */
- (void)ek_observeNotificationNamed:(NSString *)notificationName action:(SEL)action;

/*! Stops all notifications observing
 */
- (void)ek_stopNotificationsObserving;

/*! Add observer for keyPath
 \param target Object to be observing keyPath values
 \param keyPath Path where observing value is placed
 */
- (void)ek_addObserver:(id)target forKeyPath:(NSString *)keyPath;

@end
