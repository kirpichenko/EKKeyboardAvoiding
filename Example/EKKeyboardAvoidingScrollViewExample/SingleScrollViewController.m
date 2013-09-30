//
//  SingleScrollViewController.m
//  EKKeyboardAvoidingScrollViewExample
//
//  Created by Evgeniy Kirpichenko on 12/5/12.
//  Copyright (c) 2012 Evgeniy Kirpichenko. All rights reserved.
//

#import "SingleScrollViewController.h"
#import "RegisteringViewController.h"

#import <EKKeyboardAvoiding/UIScrollView+EKKeyboardAvoiding.h>

@interface SingleScrollViewController () <UITextFieldDelegate>
@end

@implementation SingleScrollViewController

#pragma mark -
#pragma mark life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];    
   
    [scrollView setContentSize:[scrollView frame].size];
    [scrollView setKeyboardAvoidingEnabled:YES];

    
//    [self setAutomaticallyAdjustsScrollViewInsets:NO];

    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(viewWasTapped:)];
    [singleTap setCancelsTouchesInView:NO];
    [[self view] addGestureRecognizer:singleTap];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    
//    [scrollView setContentInset:UIEdgeInsetsMake(10, 0, 20, 0)];
    
    [super viewDidAppear:animated];
    
    NSLog(@"co  = %@",NSStringFromUIEdgeInsets([scrollView contentInset]));
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

- (void)viewWasTapped:(UITapGestureRecognizer *) singleTap
{
    [[self view] endEditing:YES];
}

#pragma mark -
#pragma mark actions

- (IBAction)showNext
{
    SingleScrollViewController *controller = [[SingleScrollViewController alloc] init];
    [[self navigationController] pushViewController:controller animated:YES];
}

- (IBAction)showCustom
{
    RegisteringViewController *controller = [[RegisteringViewController alloc] init];
    [[self navigationController] pushViewController:controller animated:YES];
}

#pragma mark -
#pragma mark rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

@end
