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
@property (nonatomic, strong) UITabBarController *tabBarController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    SingleScrollViewController *controller = [[SingleScrollViewController alloc] initWithUniversalNib];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    self.tabBarController = [[UITabBarController alloc] init];
    [self.tabBarController setViewControllers:@[
        navigationController,
        [[MultipleScrollsViewController alloc] initWithUniversalNib]
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
}

@end
