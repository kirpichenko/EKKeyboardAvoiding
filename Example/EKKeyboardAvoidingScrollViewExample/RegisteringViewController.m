//
//  RegisteringViewController.m
//  EKKeyboardAvoidingScrollViewExample
//
//  Created by Evgeniy Kirpichenko on 3/18/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "RegisteringViewController.h"
#import <EKKeyboardAvoiding/UIScrollView+EKKeyboardAvoiding.h>

@interface RegisteringViewController ()

@end

@implementation RegisteringViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [scrollView setContentSize:[scrollView frame].size];
    [scrollView setKeyboardAvoidingEnabled:YES];
}

- (void)viewDidUnload
{
     scrollView = nil;
    [super viewDidUnload];
}

@end
