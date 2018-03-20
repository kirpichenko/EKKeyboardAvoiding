//
//  NSObject+EKAssociatedObject.h
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 9/30/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
@interface NSObject (EKKeyboardAvoiding)

/*! Adds associated object
 \param object An object to be associated with key
 \param key String to be used for access to associated object
 */
- (void)ek_associateObject:(nullable id)object forKey:(NSString *)key;

/*! Provides an access to associated objects
 \param key Key for associated object to be returned
 \return Associated object for key
 */
- (nullable id)ek_associatedObjectForKey:(NSString *)key;

/*! Add observer for keyPath
 \param target Object to be observing keyPath values
 \param keyPath Path where observing value is placed
 */
- (void)ek_addObserver:(id)target forKeyPath:(NSString *)keyPath;

@end


@interface NSObject (EK_NotificationsObserving)

/*! Registers for notification observing
 \param notificationName The name of notification to be observed
 \param action Selector to be called when observing notification posted
 */
- (void)ek_observeNotificationNamed:(NSString *)notificationName action:(SEL)action;

/*! Stops subscribed notifications observing
 */
- (void)ek_stopNotificationsObserving;

@end


NS_ASSUME_NONNULL_END
