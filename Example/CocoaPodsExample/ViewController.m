//
//  ViewController.m
//  CocoaPodsExample
//
//  Created by Andrew Romanov on 20/03/2018.
//  Copyright © 2018 Evgeniy Kirpichenko. All rights reserved.
//

#import "ViewController.h"
@import EKKeyboardAvoiding;

@interface ViewController () <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView* scrollView;
@property (nonatomic, strong) IBOutlet UITextField* textField;

@end


@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self.scrollView ek_setKeyboardAvoidingEnabled:YES];
}


#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField        // return NO to disallow editing.
{
	return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField          // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
{
	return YES;
}


- (BOOL)textFieldShouldClear:(UITextField *)textField               // called when clear button pressed. return NO to ignore (no notifications)
{
	return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[self.textField resignFirstResponder];
	
	return YES;
}


- (void)dealloc
{
	[self.scrollView ek_setKeyboardAvoidingEnabled:NO];
}


@end
