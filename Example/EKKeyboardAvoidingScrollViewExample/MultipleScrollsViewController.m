//
//  ScrollPageViewController.m
//  EKKeyboardAvoidingScrollViewExample
//
//  Created by Evgeniy Kirpichenko on 12/5/12.
//  Copyright (c) 2012 Evgeniy Kirpichenko. All rights reserved.
//

#import "MultipleScrollsViewController.h"

#import <EKKeyboardAvoiding/UIScrollView+EKKeyboardAvoiding.h>

@interface MultipleScrollsViewController () <UITextFieldDelegate>
@end

@implementation MultipleScrollsViewController

#pragma mark -
#pragma mark life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [scrollView setContentSize:[scrollView frame].size];
    
    [textView setKeyboardAvoidingEnabled:YES];
    [tableView setKeyboardAvoidingEnabled:YES];
    [scrollView setKeyboardAvoidingEnabled:YES];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(viewWasTapped:)];
    [[self view] addGestureRecognizer:singleTap];
}

- (void)viewDidUnload
{
     textView = nil;
     tableView = nil;
     scrollView = nil;
    
    [super viewDidUnload];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[aTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
    }
    [[cell textLabel] setText:[NSString stringWithFormat:@"Cell #%d",indexPath.row]];
    
    return cell;
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

- (void)viewWasTapped:(UITapGestureRecognizer *)singleTap
{
    [[self view] endEditing:YES];
}

#pragma mark -
#pragma mark rotation

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}


@end
