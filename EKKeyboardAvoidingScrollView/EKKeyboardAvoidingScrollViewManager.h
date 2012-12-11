//
//  UIScrollViewDisplayManager.h
//  EKKeyboardAvoidingScrollView
//
//  Created by Evgeniy Kirpichenko on 11/22/12.
//
//

#import <UIKit/UIKit.h>

@interface EKKeyboardAvoidingScrollViewManager : NSObject
{
    NSMutableArray *registeredScrolls;
}

@property (atomic, assign, readonly) CGRect keyboardFrame;

+ (id) sharedInstance;

- (void) registerScrollViewForKeyboardAvoiding:(UIScrollView *) scrollView;
- (void) unregisterScrollViewFromKeyboardAvoiding:(UIScrollView *) scrollView;

- (void) updateRegisteredScrolls;

@end
