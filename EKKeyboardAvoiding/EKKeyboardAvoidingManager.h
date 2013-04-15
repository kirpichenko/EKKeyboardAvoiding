//
//  UIScrollViewDisplayManager.h
//  EKKeyboardAvoidingScrollView
//
//  Created by Evgeniy Kirpichenko on 11/22/12.
//
//

#import <UIKit/UIKit.h>

@interface EKKeyboardAvoidingManager : NSObject
{
    NSMutableArray *registeredScrolls;
}

@property (atomic,readonly) CGRect keyboardFrame;

+ (id)sharedInstance;

- (void)registerScrollView:(UIScrollView *)scrollView;
- (void)unregisterScrollView:(UIScrollView *)scrollView;

- (void)updateRegisteredScrollViews;

@end
