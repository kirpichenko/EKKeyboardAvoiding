//
//  NSObject+EKAssociatedObject.h
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 9/30/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (EKAssociatedObject)

- (void)setAssociatedObject:(id)object forKey:(NSString *)key;
- (id)associatedObjectForKey:(NSString *)key;

@end
