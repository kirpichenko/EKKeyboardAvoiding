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

- (void)registerForKeyboardAvoiding:(UIScrollView *)scrollView;
- (void)unregisterFromKeyboardAvoiding:(UIScrollView *)scrollView;

- (void)updateRegisteredScrolls;

@end
