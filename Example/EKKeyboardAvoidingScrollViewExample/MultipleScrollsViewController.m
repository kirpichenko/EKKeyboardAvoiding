//
//  ScrollPageViewController.m
//  EKKeyboardAvoidingScrollViewExample
//
//  Created by Evgeniy Kirpichenko on 12/5/12.
//  Copyright (c) 2012 Evgeniy Kirpichenko. All rights reserved.
//

#import "MultipleScrollsViewController.h"

#import <EKKeyboardAvoiding/UIScrollView+EKKeyboardAvoiding.h>

static NSString *const kCellIdentifier = @"CellIdentifier";

@interface MultipleScrollsViewController () <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation MultipleScrollsViewController

#pragma mark -
#pragma mark life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.scrollView setContentSize:[self.scrollView frame].size];
    [self.scrollView setKeyboardAvoidingEnabled:YES];
    
    [self.textView setKeyboardAvoidingEnabled:YES];

    [self.tableView setKeyboardAvoidingEnabled:YES];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    
    [self addViewTap];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    [cell.textLabel setText:[NSString stringWithFormat:@"Cell #%d",indexPath.row]];
    
    return cell;
}

#pragma mark -
#pragma mark UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

#pragma mark - rotation

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

#pragma mark - helpers

- (void)addViewTap
{
    UITapGestureRecognizer *singleTap;
    singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewWasTapped:)];

    [self.view addGestureRecognizer:singleTap];
}

- (void)viewWasTapped:(UITapGestureRecognizer *)singleTap
{
    [self.view endEditing:YES];
}

@end
