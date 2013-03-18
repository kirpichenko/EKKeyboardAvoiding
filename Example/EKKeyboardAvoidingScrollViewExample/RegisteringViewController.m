//
//  RegisteringViewController.m
//  EKKeyboardAvoidingScrollViewExample
//
//  Created by Evgeniy Kirpichenko on 3/18/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "RegisteringViewController.h"
#import <EKKeyboardAvoiding/EKKeyboardAvoidingManager.h>

@interface RegisteringViewController ()

@end

@implementation RegisteringViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [scrollView setContentSize:[scrollView frame].size];
    [[EKKeyboardAvoidingManager sharedInstance] registerForKeyboardAvoiding:scrollView];
}

- (void)viewDidUnload
{
    [scrollView release]; scrollView = nil;
    [super viewDidUnload];
}

- (void)dealloc
{
    NSLog(@"dealloc");
    [scrollView release];
    [super dealloc];
}

@end
