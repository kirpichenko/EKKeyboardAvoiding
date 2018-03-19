//
//  EKKeyboardAvoidingProvider.m
//  EKKeyboardAvoiding
//
//  Created by Evgeniy Kirpichenko on 9/17/13.
//  Copyright (c) 2013 Evgeniy Kirpichenko. All rights reserved.
//

#import "EKKeyboardAvoidingProvider.h"

#import "EKKAPInsetsControllerContentInsets.h"
#import "EKKAPInsetsControllerScrollIndicatorsInsets.h"


@interface EKKeyboardAvoidingProvider ()

@property (nonatomic, weak) UIScrollView* scrollView;
@property (nonatomic, strong) NSArray<EKKAPInsetsControllerBase*>* insetsControllers;

@end


@interface EKKeyboardAvoidingProvider (Initialization)

- (void)initiateInsetsControllers;

@end


@implementation EKKeyboardAvoidingProvider

- (id)initWithScrollView:(UIScrollView *)scrollView
{
    if (self = [super init])
    {
        [self setScrollView:scrollView];
		 [self initiateInsetsControllers];
    }
	
    return self;
}


- (void)setScrollView:(UIScrollView *)scrollView
{
	_scrollView = scrollView;

	[_insetsControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		EKKAPInsetsControllerBase* controller = obj;
		controller.scrollView = scrollView;
	}];
}


- (void)setKeyboardListener:(EKKeyboardFrameListener *)keyboardListener
{
	_keyboardListener = keyboardListener;
	[_insetsControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		EKKAPInsetsControllerBase* controller = obj;
		controller.keyboardListener = keyboardListener;
	}];
}


- (void)dealloc
{
    [self stopAvoiding];
}

#pragma mark - public methods

- (void)startAvoiding
{
  [_insetsControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
	  EKKAPInsetsControllerBase* controller = obj;
	  [controller startAvoiding];
  }];
}

- (void)stopAvoiding
{
   [_insetsControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		EKKAPInsetsControllerBase* controller = obj;
		[controller stopAvoiding];
	}];
}

@end


#pragma mark -
@implementation EKKeyboardAvoidingProvider (Initialization)

- (void)initiateInsetsControllers
{
	EKKAPInsetsControllerBase* contentInsetsController = [[EKKAPInsetsControllerContentInsets alloc] initWithScrollView:self.scrollView];
	EKKAPInsetsControllerBase* scrollIndicatorsInsetsController = [[EKKAPInsetsControllerScrollIndicatorsInsets alloc] initWithScrollView:self.scrollView];
	self.insetsControllers = @[contentInsetsController, scrollIndicatorsInsetsController];
	if (_keyboardListener)
	{
		self.keyboardListener = _keyboardListener;
	}
}

@end
