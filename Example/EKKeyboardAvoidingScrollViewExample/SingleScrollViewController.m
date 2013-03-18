//
//  SingleScrollViewController.m
//  EKKeyboardAvoidingScrollViewExample
//
//  Created by Evgeniy Kirpichenko on 12/5/12.
//  Copyright (c) 2012 Evgeniy Kirpichenko. All rights reserved.
//

#import "SingleScrollViewController.h"
#import "RegisteringViewController.h"

#import "UIViewController+LoadWithXib.h"
#import <EKKeyboardAvoidingScrollView/EKKeyboardAvoidingScrollViewManager.h>


@interface SingleScrollViewController () <UITextFieldDelegate>
@end

@implementation SingleScrollViewController

#pragma mark -
#pragma mark life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];    
    [scrollView setContentSize:[scrollView frame].size];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(viewTapped:)];
    [singleTap setCancelsTouchesInView:NO];
    [[self view] addGestureRecognizer:[singleTap autorelease]];
}

- (void)dealloc {
    [scrollView release];
    [super dealloc];
}

#pragma mark -
#pragma mark UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [[self view] endEditing:YES];
    return YES;
}

#pragma mark -
#pragma mark touches

- (void) viewTapped:(UITapGestureRecognizer *) singleTap
{
    [[self view] endEditing:YES];
}

#pragma mark -
#pragma mark actions

- (IBAction) showNext
{
    SingleScrollViewController *controller = [[SingleScrollViewController alloc] initWithUniversalNib];
    [[self navigationController] pushViewController:[controller autorelease] animated:YES];
}

- (IBAction)showCustom
{
    RegisteringViewController *controller = [[RegisteringViewController alloc] init];
    [[self navigationController] pushViewController:controller animated:YES];
    [controller release];
}

#pragma mark -
#pragma mark rotation

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

@end
