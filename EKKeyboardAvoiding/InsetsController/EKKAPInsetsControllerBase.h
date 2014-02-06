//
//  EKKAPInsetsControllerBase.h
//  EKKeyboardAvoiding
//
//  Created by Andrew Romanov on 06.02.14.
//  Copyright (c) 2014 Evgeniy Kirpichenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EKKeyboardFrameListener.h"


@interface EKKAPInsetsControllerBase : NSObject

@property (nonatomic, weak) UIScrollView* scrollView;
/// Listens keyboard frame that will be used for extra inset calculation
@property (nonatomic, strong) EKKeyboardFrameListener* keyboardListener;


/*! Initializes new insets controller
 \param scrollView ScrollView for that keyboard avoiding will be provided
 */
- (id)initWithScrollView:(UIScrollView *)scrollView;

/// Starts keyboard avoiding
- (void)startAvoiding;

/// Stops keyboard avoiding
- (void)stopAvoiding;

@end



@interface EKKAPInsetsControllerBase (Protected)

- (UIEdgeInsets)_getCurrentInsets;
- (void)_setCurrentInsets:(UIEdgeInsets)insets;

@end


