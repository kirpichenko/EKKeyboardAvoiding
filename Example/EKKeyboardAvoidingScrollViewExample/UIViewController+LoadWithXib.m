//
//  UIViewController+LoadWithXib.m
//  EKKeyboardAvoidingScrollViewExample
//
//  Created by Evgeniy Kirpichenko on 12/5/12.
//  Copyright (c) 2012 Evgeniy Kirpichenko. All rights reserved.
//

#import "UIViewController+LoadWithXib.h"

#define UIDeviceIsiPad() UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

@implementation UIViewController (LoadWithXib)

- (id) initWithUniversalNib
{
    NSString *className = NSStringFromClass([self class]);
    return [self initWithUniversalNibName:className];
}

- (id) initWithUniversalNibName:(NSString *) nibNameOrNil
{
    NSMutableString *universalNibName = [NSMutableString stringWithString:nibNameOrNil];
    [universalNibName appendString:UIDeviceIsiPad() ? @"_iPad" : @""];
    
    if([[NSBundle mainBundle] pathForResource:universalNibName ofType:@"nib"]) {
        return [self initWithNibName:universalNibName bundle:nil];
    }
    return [self initWithNibName:nibNameOrNil bundle:nil];
}

@end
