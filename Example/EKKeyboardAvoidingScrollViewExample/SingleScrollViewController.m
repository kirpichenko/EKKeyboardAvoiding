//
//  SingleScrollViewController.m
//  EKKeyboardAvoidingScrollViewExample
//
//  Created by Evgeniy Kirpichenko on 12/5/12.
//  Copyright (c) 2012 Evgeniy Kirpichenko. All rights reserved.
//

#import "SingleScrollViewController.h"
#import <EKKeyboardAvoidingScrollView/EKKeyboardAvoidingScrollViewManger.h>

@interface SingleScrollViewController ()

@end

@implementation SingleScrollViewController

#pragma mark -
#pragma mark life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];    
    [[EKKeyboardAvoidingScrollViewManger sharedInstance] registerScrollViewForKeyboardAvoiding:scrollView];
    [scrollView setContentSize:[scrollView frame].size];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(viewTapped:)];
    [[self view] addGestureRecognizer:[singleTap autorelease]];
}

- (void) viewDidUnload
{
    [super viewDidUnload];
    [[EKKeyboardAvoidingScrollViewManger sharedInstance] unregisterScrollViewFromKeyboardAvoiding:scrollView];
}

- (void)dealloc {
    [[EKKeyboardAvoidingScrollViewManger sharedInstance] unregisterScrollViewFromKeyboardAvoiding:scrollView];
    [scrollView release];
    [super dealloc];
}

#pragma mark -
#pragma mark touches

- (void) viewTapped:(UITapGestureRecognizer *) singleTap
{
    [[self view] endEditing:YES];
}

@end
