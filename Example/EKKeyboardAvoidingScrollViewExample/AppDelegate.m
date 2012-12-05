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
    SingleScrollViewController *controller = [[SingleScrollViewController new] autorelease];
    [self.window setRootViewController:controller];

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
