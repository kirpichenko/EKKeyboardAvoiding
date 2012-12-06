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

@interface AppDelegate ()
@property (nonatomic, retain) UITabBarController *tabBarController;
@end

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    SingleScrollViewController *controller = [[[SingleScrollViewController alloc] initWithUniversalNib] autorelease];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    [self.tabBarController setViewControllers:@[
        [navigationController autorelease],
        [[[MultipleScrollsViewController alloc] initWithUniversalNib] autorelease]
     ]];
    
    [self setTabBarItemWithText:@"Single Scroll" forControllerAtIndex:0];
    [self setTabBarItemWithText:@"Multiple Scrolls" forControllerAtIndex:1];
    
    [self.window setRootViewController:self.tabBarController];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void) setTabBarItemWithText:(NSString *) text forControllerAtIndex:(NSInteger) index
{
    UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:text image:nil tag:NSNotFound];
    [[[self.tabBarController viewControllers] objectAtIndex:index] setTabBarItem:item];
    [item release];
}

@end
