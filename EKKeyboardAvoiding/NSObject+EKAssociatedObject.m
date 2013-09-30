//
//  NSObject+EKAssociatedObject.m
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 9/30/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "NSObject+EKAssociatedObject.h"

#import <objc/runtime.h>

@implementation NSObject (EKAssociatedObject)

#pragma mark - associate avoiding listener

- (void)setAssociatedObject:(id)object forKey:(NSString *)key {
    objc_setAssociatedObject(self, [key UTF8String], object, OBJC_ASSOCIATION_RETAIN);
}

- (id)associatedObjectForKey:(NSString *)key {
    return objc_getAssociatedObject(self, [key UTF8String]);
}

@end
