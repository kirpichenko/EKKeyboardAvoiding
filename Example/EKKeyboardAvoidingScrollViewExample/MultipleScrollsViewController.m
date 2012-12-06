//
//  ScrollPageViewController.m
//  EKKeyboardAvoidingScrollViewExample
//
//  Created by Evgeniy Kirpichenko on 12/5/12.
//  Copyright (c) 2012 Evgeniy Kirpichenko. All rights reserved.
//

#import "MultipleScrollsViewController.h"
#import <EKKeyboardAvoidingScrollView/EKKeyboardAvoidingScrollViewManger.h>

@interface MultipleScrollsViewController () <UITextFieldDelegate>

@end

@implementation MultipleScrollsViewController

#pragma mark -
#pragma mark life cycle

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [scrollView setContentSize:[scrollView frame].size];
    
    [[EKKeyboardAvoidingScrollViewManger sharedInstance] registerScrollViewForKeyboardAvoiding:textView];
    [[EKKeyboardAvoidingScrollViewManger sharedInstance] registerScrollViewForKeyboardAvoiding:tableView];
    [[EKKeyboardAvoidingScrollViewManger sharedInstance] registerScrollViewForKeyboardAvoiding:scrollView];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(viewTapped:)];
    [[self view] addGestureRecognizer:[singleTap autorelease]];
}

- (void) viewDidUnload
{
    [textView release]; textView = nil;
    [tableView release]; tableView = nil;
    [scrollView release]; scrollView = nil;
    
    [super viewDidUnload];
}

- (void) dealloc
{
    [[EKKeyboardAvoidingScrollViewManger sharedInstance] unregisterScrollViewFromKeyboardAvoiding:textView];
    [[EKKeyboardAvoidingScrollViewManger sharedInstance] unregisterScrollViewFromKeyboardAvoiding:tableView];
    [[EKKeyboardAvoidingScrollViewManger sharedInstance] unregisterScrollViewFromKeyboardAvoiding:scrollView];
    
    [textView release];
    [tableView release];
    [scrollView release];
    
    [super dealloc];
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
        [cell autorelease];
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

- (void) viewTapped:(UITapGestureRecognizer *) singleTap
{
    [[self view] endEditing:YES];
}

@end
