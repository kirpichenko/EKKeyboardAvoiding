//
//  AppDelegate.m
//  EKKeyboardAvoidingScrollViewExample
//
//  Created by Evgeniy Kirpichenko on 12/5/12.
//  Copyright (c) 2012 Evgeniy Kirpichenko. All rights reserved.
//

#import "AppDelegate.h"
#import "MultipleScrollsViewController.h"
#import "SingleScrollViewController.h"
#import "UIViewController+LoadWithXib.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
//    MultipleScrollsViewController *controller = [[MultipleScrollsViewController new] autorelease];
    SingleScrollViewController *controller = [[SingleScrollViewController alloc] initWithUniversalNib];
    [self.window setRootViewController:[controller autorelease]];

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
