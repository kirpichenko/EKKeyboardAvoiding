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
//    [scrollView addObserver:self forKeyPath:@"contentInset" options:NSKeyValueObservingOptionNew
//                    context:nil];
    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(viewWasTapped:)];
    [singleTap setCancelsTouchesInView:NO];
    [[self view] addGestureRecognizer:singleTap];
    
    [self setAutomaticallyAdjustsScrollViewInsets:<#(BOOL)#>]
}

- (void)dealloc {
    [scrollView setKeyboardAvoidingEnabled:NO];
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

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    NSLog(@"aa new value %@",change);
    NSLog(@"scroll %@",scrollView);
}

@end
