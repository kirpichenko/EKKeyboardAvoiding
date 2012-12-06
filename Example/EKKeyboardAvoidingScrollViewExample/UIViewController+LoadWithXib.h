//
//  UIViewController+LoadWithXib.h
//  EKKeyboardAvoidingScrollViewExample
//
//  Created by Evgeniy Kirpichenko on 12/5/12.
//  Copyright (c) 2012 Evgeniy Kirpichenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LoadWithXib)

- (id) initWithUniversalNib;
- (id) initWithUniversalNibName:(NSString *) nibNameOrNil;

@end
